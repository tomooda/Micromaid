Class {
	#name : 'MMGraphBuilder',
	#superclass : 'Object',
	#instVars : [
		'nodes',
		'edges',
		'direction'
	],
	#category : 'Micromaid-Graph',
	#package : 'Micromaid-Graph'
}

{ #category : 'instance creation' }
MMGraphBuilder class >> fromString: aString [

	| builder |
	builder := self new.
	[ MMGraphParser new parse: aString ]
		on: MMGraphParserNotification
		do: [ :ex |
				ex applyToBuilder: builder.
				ex resume ].
	^ builder
]

{ #category : 'adding' }
MMGraphBuilder >> addEdge: aMMGraphEdge [

	^ edges addLast: aMMGraphEdge
]

{ #category : 'adding' }
MMGraphBuilder >> addNode: aMMGraphNode [

	^ nodes at: aMMGraphNode name put: aMMGraphNode
]

{ #category : 'adding' }
MMGraphBuilder >> addSimpleNode: aMMGraphSimpleNode [

	^ nodes
		  at: aMMGraphSimpleNode name
		  ifAbsentPut: [ aMMGraphSimpleNode ]
]

{ #category : 'accessing' }
MMGraphBuilder >> direction [

	^ direction
]

{ #category : 'accessing' }
MMGraphBuilder >> direction: aSymbol [

	direction := aSymbol
]

{ #category : 'accessing' }
MMGraphBuilder >> edges [

	^ edges
]

{ #category : 'initialization' }
MMGraphBuilder >> initialize [

	super initialize.
	nodes := OrderedDictionary new.
	edges := OrderedCollection new
]

{ #category : 'accessing' }
MMGraphBuilder >> nodes [

	^ nodes
]
