"
I am an abstract class that represents an AST node for edge in Micromaid scripts.

I implement the `applyToBuilder:` method that adds myself to a roassal builder as an edge.

"
Class {
	#name : 'MMEdge',
	#superclass : 'MMEntity',
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
MMEdge >> applyToBuilder: aMMRoassalBuilder [

	aMMRoassalBuilder addEdge: self
]

{ #category : 'accessing' }
MMEdge >> inversed [

	^ self subclassResponsibility
]

{ #category : 'testing' }
MMEdge >> isMMEdge [

	^ true
]

{ #category : 'testing' }
MMEdge >> isSelfLoop [

	^ node1 = node2
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
