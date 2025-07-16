Class {
	#name : 'MMEdge',
	#superclass : 'Object',
	#instVars : [
		'node1',
		'node2',
		'label'
	],
	#category : 'Micromaid-Base-AST',
	#package : 'Micromaid-Base',
	#tag : 'AST'
}

{ #category : 'testing' }
MMEdge class >> isAbstract [

	^ self = MMEdge
]

{ #category : 'building' }
MMEdge >> applyToBuilder: aMMGraphBuilder [

	aMMGraphBuilder addEdge: self
]

{ #category : 'testing' }
MMEdge >> isMMEdge [

	^ true
]

{ #category : 'accessing' }
MMEdge >> label [

	^ label
]

{ #category : 'accessing' }
MMEdge >> label: aString [

	label := aString
]

{ #category : 'accessing' }
MMEdge >> node1 [

	^ node1
]

{ #category : 'accessing' }
MMEdge >> node1: aString [

	node1 := aString
]

{ #category : 'accessing' }
MMEdge >> node2 [

	^ node2
]

{ #category : 'accessing' }
MMEdge >> node2: aString [

	node2 := aString
]
