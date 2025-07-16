Class {
	#name : 'MMStateDiagramSimpleState',
	#superclass : 'MMSimpleNode',
	#category : 'Micromaid-StateDiagram-AST',
	#package : 'Micromaid-StateDiagram',
	#tag : 'AST'
}

{ #category : 'testing' }
MMStateDiagramSimpleState >> isStartState [

	^ false
]

{ #category : 'testing' }
MMStateDiagramSimpleState >> isStopState [

	^ false
]
