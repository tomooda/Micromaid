"
I am a presenter with two panes horizontally.
The left one is a text editor where the user will edit a Micromaid script.
The right one is a Roassal presenter where the system will render the diagram.
"
Class {
	#name : 'MicromaidLiveEditorPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'text',
		'roassal'
	],
	#category : 'Micromaid-Spec',
	#package : 'Micromaid-Spec'
}

{ #category : 'examples' }
MicromaidLiveEditorPresenter class >> example [

	^ self new open
]

{ #category : 'examples' }
MicromaidLiveEditorPresenter class >> exampleCollection [

	^ self new
		  text: 'classDiagram
	class Collection {
		<<abstract>>
		%% methods
		<<abstract>> size () : Integer
		<<abstract>> do: (BlockClosure)
		collect: (BlockClosure)
	}
	class SequenceableCollection { 
		<<abstract>> 
		%% methods
		<<abstract>> at: (Integer) : Object
		<<abstract>> at:put: (Integer, Object) : Object
		do: (BlockClosure)
	}
	class Array {
		<<variable>>
		%% methods
		<<primitive>> at: (Integer) : Object
		<<primitive>> at:put: (Integer, Object) : Object
		<<primitive>> size () : Integer
	}
	class OrderedCollection {
		array : Array
		firstIndex : Integer
		lastIndex : Integer
		%% methods
		at: (Integer) : Object
		at:put: (Integer, Object) : Object
		size () : Integer
		- compact ()
	}
	class Set { 
		tally : Integer
		array : Array
		%% methods
		size () : Integer
		do: (BlockClosure)
		-rehash ()
	}
	Collection <|-- SequenceableCollection
	SequenceableCollection <|-- Array
	SequenceableCollection <|-- OrderedCollection
	Collection <|-- Set
	Array <.. OrderedCollection : internal container
	Array <.. Set : hash table';
		  open
]

{ #category : 'examples' }
MicromaidLiveEditorPresenter class >> exampleREPL [

	^ self new
		  text: 'flowchart TD
R[Read]
E[Eval]
P[Print]
A([Init]) --> R
R -->  E
E -->|quit| Q([quit])
E --> P
P --> R
';
		  open
]

{ #category : 'examples' }
MicromaidLiveEditorPresenter class >> exampleTwoStrokeEngine [

	^ self new
		  text: 'stateDiagram
state "Intake/scavenging" as A
state "Exhaust" as B
state "Compression" as C
state "Combustion" as D
[*] --> A : kick start
A --> B
B --> C
C --> D
D --> A
C --> [*] : ignition off';
		  open
]

{ #category : 'examples' }
MicromaidLiveEditorPresenter class >> exampleWeb [

	^ self new
		  text: 'sequenceDiagram
	actor User
	participant Browser
	participant Server
	participant  Server2 as External Server
	
	User ->> Browser : open URL
	Browser ->>+ Server : GET request 1
	Server -->>- Browser : response 1
	Browser ->>+ Server : GET request 2
	Browser ->>+ Server : GET request 3
	Browser ->>+ Server2 : GET request 4
	Server -->>- Browser : response 3
	Server -->>- Browser : response 2
	Server2 -->>- Browser : response 4
	Browser ->> User : render the page';
		  open
]

{ #category : 'initialization' }
MicromaidLiveEditorPresenter >> defaultLayout [

	^ SpPanedLayout newHorizontal
		  positionOfSlider: 0.5;
		  add: text;
		  add: roassal;
		  yourself
]

{ #category : 'initialization' }
MicromaidLiveEditorPresenter >> initializePresenters [

	super initializePresenters.
	text := self newText
		        whenTextChangedDo: [ :string | self textChanged: string ];
		        yourself.
	roassal := self newRoassal
		           script: [ :canvas |
				           (MicromaidParser parse: text text asString) ifNotNil: [
							           :graph |
							           | builder |
							           builder := graph roassalBuilder.
							           builder container: canvas.
							           canvas clear.
							           builder build
								           @ RSCanvasController;
								           zoomToFit ] ];
		           yourself
]

{ #category : 'initialization' }
MicromaidLiveEditorPresenter >> initializeWindow: aSpWindowPresenter [

	super initializeWindow: aSpWindowPresenter.
	aSpWindowPresenter
		title: 'Micromaid Live Editor';
		initialExtent: 800 @ 600;
		whenResizingDo: [ roassal refresh ]
]

{ #category : 'accessing' }
MicromaidLiveEditorPresenter >> text: aStirng [

	text text: aStirng
]

{ #category : 'events handling' }
MicromaidLiveEditorPresenter >> textChanged: aString [

	roassal refresh
]
