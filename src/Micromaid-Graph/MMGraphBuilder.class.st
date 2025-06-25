Class {
	#name : 'MMGraphBuilder',
	#superclass : 'Object',
	#instVars : [
		'nodes',
		'edges'
	],
	#category : 'Micromaid-Graph',
	#package : 'Micromaid-Graph'
}

{ #category : 'adding' }
MMGraphBuilder >> addEdge: aMMGraphEdge [

	^ edges addLast: aMMGraphEdge
]

{ #category : 'adding' }
MMGraphBuilder >> addNode: aMMGraphNode [

	^ nodes at: aMMGraphNode name ifAbsentPut: [ aMMGraphNode ]
]

{ #category : 'initialization' }
MMGraphBuilder >> initialize [

	super initialize.
	nodes := OrderedDictionary new.
	edges := OrderedCollection new
]
