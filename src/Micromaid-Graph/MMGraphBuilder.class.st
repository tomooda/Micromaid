Class {
	#name : 'MMGraphBuilder',
	#superclass : 'RSBuilder',
	#instVars : [
		'nodes',
		'edges',
		'direction'
	],
	#category : 'Micromaid-Graph',
	#package : 'Micromaid-Graph'
}

{ #category : 'examples' }
MMGraphBuilder class >> example [

	(MMGraphBuilder fromString: 'flowchart TD
    A[Christmas] -->|Get money| B[Go shopping]
    B --> C[Let me think]
    C -->|One| D[Laptop]
    C -->|Two| E[iPhone]
    C -->|Three| F[fa:fa-car Car]
    F --> B') build
		zoomToFit;
		open
]

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

{ #category : 'accessing - markers' }
MMGraphBuilder >> markerFor: aSymbol [

	aSymbol = #arrowhead ifTrue: [
			| shape marker |
			shape := RSPolygon new
				         points: {
						         (-4 @ 6).
						         (0 @ 0).
						         (4 @ 6) };
				         color: Color black;
				         yourself.
			marker := shape asMarker.
			marker offset: shape height / 2.
			^ marker ].
	^ nil
]

{ #category : 'instance creation' }
MMGraphBuilder >> newLabelForNode: aMMGraphNode [

	^ RSLabel new
		  text: aMMGraphNode label;
		  color: Color black;
		  yourself
]

{ #category : 'instance creation' }
MMGraphBuilder >> newShapeForEdge: edge [

	^ RSLine new
		  model: edge;
		  color: Color black;
		  markerStart: (self markerFor: edge head1);
		  markerEnd: (self markerFor: edge head2);
		  yourself
]

{ #category : 'instance creation' }
MMGraphBuilder >> newShapeForNode: aMMGraphNode [

	aMMGraphNode shape = #rect ifTrue: [
		^ self newShapeForRectNode: aMMGraphNode ].
	^ nil
]

{ #category : 'instance creation' }
MMGraphBuilder >> newShapeForRectNode: aMMGraphNode [

	| label box |
	label := self newLabelForNode: aMMGraphNode.
	box := RSBox new
		       extent: label extent + 10;
		       color: Color white;
		       border: (RSBorder new
				        color: Color black;
				        yourself);
		       yourself.
	^ {
		  box.
		  label } asShapeFor: aMMGraphNode
]

{ #category : 'accessing' }
MMGraphBuilder >> nodes [

	^ nodes
]

{ #category : 'rendering' }
MMGraphBuilder >> renderIn: aCanvas [

	aCanvas color: Color lightGray.
	self
		renderNodesIn: aCanvas;
		renderLinksIn: aCanvas
]

{ #category : 'rendering' }
MMGraphBuilder >> renderLinksIn: aRSCanvas [

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
								withVerticalAttachPoint;
								from: from;
								to: to.
							aRSCanvas add: line.
							line pushBack ] ] ].
	RSTreeLayout on: aRSCanvas nodes.
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
									line
										attachPoint: RSShortestVerticalAttachPoint new;
										from: from;
										to: to.
									aRSCanvas add: line ] ] ] ]
]

{ #category : 'rendering' }
MMGraphBuilder >> renderNodesIn: aRSCanvas [

	nodes valuesDo: [ :node |
			| shape |
			shape := self newShapeForNode: node.
			aRSCanvas
				addNode: shape;
				addShape: shape ]
]

{ #category : 'accessing' }
MMGraphBuilder >> treeEdges [

	| knownNodes |
	knownNodes := Set new: nodes size.
	^ Array streamContents: [ :stream |
			  edges do: [ :edge |
					  | node2 |
					  node2 := edge node2.
					  (knownNodes includes: node2) ifFalse: [
							  knownNodes add: node2.
							  stream nextPut: edge ] ] ]
]
