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
							           builder build zoomToFit ] ];
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
