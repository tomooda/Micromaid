Class {
	#name : 'MMGraphEdge',
	#superclass : 'Object',
	#traits : 'TMMGraphEntity',
	#classTraits : 'TMMGraphEntity classTrait',
	#instVars : [
		'node1',
		'node2',
		'label',
		'head1',
		'head2',
		'line',
		'length'
	],
	#category : 'Micromaid-Graph',
	#package : 'Micromaid-Graph'
}

{ #category : 'building' }
MMGraphEdge >> applyToBuilder: aMMGraphBuilder [

	aMMGraphBuilder addEdge: self
]

{ #category : 'accessing' }
MMGraphEdge >> head1 [

	^ head1
]

{ #category : 'accessing' }
MMGraphEdge >> head1: aSymbol [

	head1 := aSymbol
]

{ #category : 'accessing' }
MMGraphEdge >> head2 [

	^ head2
]

{ #category : 'accessing' }
MMGraphEdge >> head2: aSymbol [

	head2 := aSymbol
]

{ #category : 'initialization' }
MMGraphEdge >> initialize [

	super initialize.
	line := #normal.
	head1 := #none.
	head2 := #none
]

{ #category : 'accessing' }
MMGraphEdge >> label [

	^ label
]

{ #category : 'accessing' }
MMGraphEdge >> label: aString [

	label := aString
]

{ #category : 'accessing' }
MMGraphEdge >> length [

	^ length
]

{ #category : 'accessing' }
MMGraphEdge >> length: anInteger [

	length := anInteger
]

{ #category : 'accessing' }
MMGraphEdge >> line [

	^ line
]

{ #category : 'accessing' }
MMGraphEdge >> line: aSymbol [

	line := aSymbol
]

{ #category : 'accessing' }
MMGraphEdge >> node1 [

	^ node1
]

{ #category : 'accessing' }
MMGraphEdge >> node1: aString [

	node1 := aString
]

{ #category : 'accessing' }
MMGraphEdge >> node2 [

	^ node2
]

{ #category : 'accessing' }
MMGraphEdge >> node2: aString [

	node2 := aString
]

{ #category : 'class access' }
MMGraphEdge >> notificationClass [

	^ MMGraphParserEdgeNotification
]
