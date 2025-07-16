Class {
	#name : 'MMStateDiagramStartState',
	#superclass : 'MMSimpleNode',
	#category : 'Micromaid-StateDiagram-AST',
	#package : 'Micromaid-StateDiagram',
	#tag : 'AST'
}

{ #category : 'initialization' }
MMStateDiagramStartState >> initialize [

	super initialize.
	name := '[Start]'
]

{ #category : 'testing' }
MMStateDiagramStartState >> isStartState [

	^ true
]

{ #category : 'testing' }
MMStateDiagramStartState >> isStopState [

	^ false
]
