"
I am a presenter with two panes horizontally.
The left one is a text editor where the user will edit a Micromaid script.
The right one is a Roassal presenter where the system will render the diagram.
"
Class {
	#name : 'MicrodownLiveEditorPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'text',
		'roassal'
	],
	#category : 'Micromaid-Spec',
	#package : 'Micromaid-Spec'
}

{ #category : 'examples' }
MicrodownLiveEditorPresenter class >> example [

	^ self new open
]

{ #category : 'examples' }
MicrodownLiveEditorPresenter class >> exampleREPL [

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

{ #category : 'initialization' }
MicrodownLiveEditorPresenter >> defaultLayout [

	^ SpPanedLayout newHorizontal
		  positionOfSlider: 0.5;
		  add: text;
		  add: roassal;
		  yourself
]

{ #category : 'initialization' }
MicrodownLiveEditorPresenter >> initializePresenters [

	super initializePresenters.
	text := self newText
		        whenTextChangedDo: [ :string | self textChanged: string ];
		        yourself.
	roassal := self newRoassal
		           script: [ :canvas |
				           | builder |
				           builder := MMGraphBuilder fromString:
						                      text text asString.
				           builder container: canvas.
				           canvas clear.
				           builder build zoomToFit ];
		           yourself
]

{ #category : 'initialization' }
MicrodownLiveEditorPresenter >> initializeWindow: aSpWindowPresenter [

	super initializeWindow: aSpWindowPresenter.
	aSpWindowPresenter
		title: 'Micromaid Live Editor';
		initialExtent: 800 @ 600;
		whenResizingDo: [ roassal refresh ]
]

{ #category : 'accessing' }
MicrodownLiveEditorPresenter >> text: aStirng [

	text text: aStirng
]

{ #category : 'events handling' }
MicrodownLiveEditorPresenter >> textChanged: aString [

	roassal refresh
]
