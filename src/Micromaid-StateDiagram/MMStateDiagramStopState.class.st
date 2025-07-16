Class {
	#name : 'MMStateDiagramStopState',
	#superclass : 'MMSimpleNode',
	#category : 'Micromaid-StateDiagram-AST',
	#package : 'Micromaid-StateDiagram',
	#tag : 'AST'
}

{ #category : 'initialization' }
MMStateDiagramStopState >> initialize [

	super initialize.
	name := '[Stop]'
]

{ #category : 'testing' }
MMStateDiagramStopState >> isStartState [

	^ false
]

{ #category : 'testing' }
MMStateDiagramStopState >> isStopState [

	^ true
]
