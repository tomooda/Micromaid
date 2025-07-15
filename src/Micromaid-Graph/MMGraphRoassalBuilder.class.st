"
I build a Roassal canvas from nodes and links from Micromaid scripts.
"
Class {
	#name : 'MMGraphRoassalBuilder',
	#superclass : 'MMRoassalBuilder',
	#instVars : [
		'direction'
	],
	#category : 'Micromaid-Graph-Roassal',
	#package : 'Micromaid-Graph',
	#tag : 'Roassal'
}

{ #category : 'accessing' }
MMGraphRoassalBuilder >> direction [

	^ direction
]

{ #category : 'accessing' }
MMGraphRoassalBuilder >> direction: aSymbol [

	direction := aSymbol
]

{ #category : 'controlling' }
MMGraphRoassalBuilder >> ifVertical: aBlock ifHorizontal: anotherBlock [

	^ (#( TB TD BT ) includes: direction)
		  ifTrue: aBlock
		  ifFalse: anotherBlock
]

{ #category : 'instance creation' }
MMGraphRoassalBuilder >> newMarkerFor: aSymbol [

	aSymbol = #arrowhead ifTrue: [
			| shape marker |
			shape := RSPolygon new
				         points: {
						         (-6 @ 8).
						         (0 @ 0).
						         (6 @ 8) };
				         color: Color black;
				         yourself.
			marker := shape asMarker.
			marker offset: shape height / 2.
			^ marker ].
	aSymbol = #circle ifTrue: [
			| shape marker |
			shape := RSCircle new
				         extent: 8 @ 8;
				         color: Color black;
				         yourself.
			marker := shape asMarker.
			marker offset: 4.
			^ marker ].
	aSymbol = #cross ifTrue: [
			| shape marker |
			shape := {
				         (RSLine new
					          startPoint: -5 @ -5;
					          endPoint: 5 @ 5;
					          width: 2;
					          color: Color black;
					          yourself).
				         (RSLine new
					          startPoint: 5 @ -5;
					          endPoint: -5 @ 5;
					          color: Color black;
					          width: 2;
					          yourself) } asShape.
			marker := shape asMarker.
			marker offset: 5.
			^ marker ].

	^ nil
]

{ #category : 'instance creation' }
MMGraphRoassalBuilder >> newTreeLayouter [

	direction = #LR ifTrue: [
			^ RSHorizontalVanDerPloegTreeLayout new
				  verticalGap: gap;
				  horizontalGap: gap ].
	direction = #RL ifTrue: [
			^ RSHorizontalVanDerPloegTreeLayout new
				  verticalGap: gap;
				  horizontalGap: gap;
				  horizontallyReverse ].
	direction = #BT ifTrue: [
			^ RSVanDerPloegTreeLayout new
				  verticalGap: gap;
				  horizontalGap: gap;
				  verticallyReverse ].
	^ RSVanDerPloegTreeLayout new
		  verticalGap: gap;
		  horizontalGap: gap
]

{ #category : 'rendering' }
MMGraphRoassalBuilder >> renderIn: aCanvas [

	aCanvas color: (Color gray: 0.8).
	self
		renderNodesIn: aCanvas;
		renderLinksIn: aCanvas
]

{ #category : 'rendering' }
MMGraphRoassalBuilder >> renderLinksIn: aRSCanvas [

	| treeEdges |
	treeEdges := self treeEdges.
	treeEdges do: [ :edge |
			| node1 node2 |
			node1 := nodes at: edge node1.
			node2 := nodes at: edge node2.
			(aRSCanvas nodes
				 detect: [ :node | node model = node1 ]
				 ifNone: [ nil ]) ifNotNil: [ :from |
					(aRSCanvas nodes
						 detect: [ :node | node model = node2 ]
						 ifNone: [ nil ]) ifNotNil: [ :to |
							| line |
							line := self newShapeForEdge: edge.
							line
								attachPoint: MMAttachPoint new;
								from: from;
								to: to;
								controlPointsController: (self newCPAPController t: 1 / 10).
							aRSCanvas add: line.
							line pushBack ] ] ].
	self newTreeLayouter on: aRSCanvas nodes.
	treeEdges := treeEdges asSet.
	edges do: [ :edge |
			(treeEdges includes: edge) ifFalse: [
					| node1 node2 |
					node1 := nodes at: edge node1.
					node2 := nodes at: edge node2.
					(aRSCanvas nodes
						 detect: [ :node | node model = node1 ]
						 ifNone: [ nil ]) ifNotNil: [ :from |
							(aRSCanvas nodes
								 detect: [ :node | node model = node2 ]
								 ifNone: [ nil ]) ifNotNil: [ :to |
									| line |
									line := self newShapeForEdge: edge.
									self
										attach: line
										from: from
										to: to
										in: aRSCanvas.
									aRSCanvas add: line ] ] ] ].
	aRSCanvas edges do: [ :bezier |
			bezier model isMMEdge ifTrue: [
					(self newLabelForEdge: bezier model) ifNotNil: [ :label |
							label position: (bezier atT:
									 (bezier controlPointsController
										  ifNotNil: #labelT
										  ifNil: [ 0.5 ])).
							aRSCanvas addShape: label ] ] ]
]

{ #category : 'rendering' }
MMGraphRoassalBuilder >> renderNodesIn: aRSCanvas [

	nodes valuesDo: [ :node |
			| shape |
			shape := self newShapeForNode: node.
			aRSCanvas
				addNode: shape;
				addShape: shape ]
]

{ #category : 'accessing' }
MMGraphRoassalBuilder >> treeEdges [

	| knownNodes |
	knownNodes := Set new: nodes size.
	^ Array streamContents: [ :stream |
			  edges do: [ :edge |
					  | node2 |
					  node2 := edge node2.
					  (knownNodes includes: node2) ifFalse: [
							  knownNodes
								  add: edge node1;
								  add: node2.
							  stream nextPut: edge ] ] ]
]
