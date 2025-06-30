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
    A[Christmas] -->|Get money| B(Go shopping)
    B --> C{Let me think}
    C -->|One| D[Laptop]
    C -->|Two| E[iPhone]
    C -->|Three| F[Car]
    G([stadium]) x-o|cross and circle heads| H[[subroutine]]') build
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

{ #category : 'controlling' }
MMGraphBuilder >> ifVertical: aBlock ifHorizontal: anotherBlock [

	^ (#( TB TD BT ) includes: direction)
		  ifTrue: aBlock
		  ifFalse: anotherBlock
]

{ #category : 'initialization' }
MMGraphBuilder >> initialize [

	super initialize.
	nodes := OrderedDictionary new.
	edges := OrderedCollection new
]

{ #category : 'instance creation' }
MMGraphBuilder >> newCPAPController [

	^ self
		  ifVertical: [ MMGraphVerticalCPAPController new ]
		  ifHorizontal: [ MMGraphHorizontalCPAPController new ]
]

{ #category : 'instance creation' }
MMGraphBuilder >> newLabelForEdge: aMMGraphEdge [

	^ aMMGraphEdge label ifNotNil: [ :string |
			  | label box |
			  label := RSLabel new
				           text: string;
				           color: Color black;
				           yourself.
			  box := RSBox new
				         extent: label extent + 4;
				         color: Color lightGray;
				         yourself.
			  {
				  box.
				  label } asShapeFor: aMMGraphEdge ]
]

{ #category : 'instance creation' }
MMGraphBuilder >> newLabelForNode: aMMGraphNode [

	^ RSLabel new
		  text: aMMGraphNode label;
		  color: Color black;
		  yourself
]

{ #category : 'instance creation' }
MMGraphBuilder >> newMarkerFor: aSymbol [

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
MMGraphBuilder >> newShapeForEdge: edge [

	^ RSBezier new
		  model: edge;
		  color: Color black;
		  markerStart: (self newMarkerFor: edge head1);
		  markerEnd: (self newMarkerFor: edge head2);
		  yourself
]

{ #category : 'instance creation' }
MMGraphBuilder >> newShapeForNode: aMMGraphNode [

	aMMGraphNode shape = #rect ifTrue: [
		^ self newShapeForRectNode: aMMGraphNode ].
	aMMGraphNode shape = #roundedRect ifTrue: [
		^ self newShapeForRoundedRectNode: aMMGraphNode ].
	aMMGraphNode shape = #rhombus ifTrue: [
		^ self newShapeForRhombusNode: aMMGraphNode ].
	aMMGraphNode shape = #stadium ifTrue: [
		^ self newShapeForStadiumNode: aMMGraphNode ].
	aMMGraphNode shape = #subroutine ifTrue: [
		^ self newShapeForSubroutineNode: aMMGraphNode ].
	^ nil
]

{ #category : 'instance creation' }
MMGraphBuilder >> newShapeForRectNode: aMMGraphNode [

	| label box |
	label := self newLabelForNode: aMMGraphNode.
	box := RSBox new
		       extent: label extent + 20;
		       color: Color white;
		       border: (RSBorder new
				        color: Color black;
				        yourself);
		       yourself.
	^ {
		  box.
		  label } asShapeFor: aMMGraphNode
]

{ #category : 'instance creation' }
MMGraphBuilder >> newShapeForRhombusNode: aMMGraphNode [

	| label extent diamond |
	label := self newLabelForNode: aMMGraphNode.
	extent := (label extent x max: label extent y) asPoint.
	diamond := RSPolygon new
		           points: {
				           (extent x negated - 5 @ 0).
				           (0 @ (extent y negated - 5)).
				           (extent x + 5 @ 0).
				           (0 @ (extent y + 5)) };
		           color: Color white;
		           border: (RSBorder new
				            color: Color black;
				            yourself);
		           yourself.
	^ {
		  diamond.
		  label } asShapeFor: aMMGraphNode
]

{ #category : 'instance creation' }
MMGraphBuilder >> newShapeForRoundedRectNode: aMMGraphNode [

	| label box |
	label := self newLabelForNode: aMMGraphNode.
	box := RSBox new
		       extent: label extent + 20;
		       cornerRadius: 5;
		       color: Color white;
		       border: (RSBorder new
				        color: Color black;
				        yourself);
		       yourself.
	^ {
		  box.
		  label } asShapeFor: aMMGraphNode
]

{ #category : 'instance creation' }
MMGraphBuilder >> newShapeForStadiumNode: aMMGraphNode [

	| label box |
	label := self newLabelForNode: aMMGraphNode.
	box := RSBox new
		       extent: label extent + 20;
		       cornerRadius: (label extent x min: label extent y) + 20 / 2;
		       color: Color white;
		       border: (RSBorder new
				        color: Color black;
				        yourself);
		       yourself.
	^ {
		  box.
		  label } asShapeFor: aMMGraphNode
]

{ #category : 'instance creation' }
MMGraphBuilder >> newShapeForSubroutineNode: aMMGraphNode [

	| label box1 box2 |
	label := self newLabelForNode: aMMGraphNode.
	box1 := RSBox new
		        extent: label extent + 20;
		        color: Color white;
		        border: (RSBorder new
				         color: Color black;
				         yourself);
		        yourself.
	box2 := box1 copy extent: box1 extent + (10 @ 0).
	^ {
		  box2.
		  box1.
		  label } asShapeFor: aMMGraphNode
]

{ #category : 'instance creation' }
MMGraphBuilder >> newTreeLayouter [

	direction = #LR ifTrue: [
			^ RSHorizontalTreeLayout new
				  verticalGap: 100;
				  horizontalGap: 100 ].
	direction = #RL ifTrue: [
			^ RSHorizontalTreeLayout new
				  verticalGap: 100;
				  horizontalGap: 100;
				  horizontallyReverse ].
	direction = #BT ifTrue: [
			^ RSTreeLayout new
				  verticalGap: 100;
				  horizontalGap: 100;
				  verticallyReverse ].
	^ RSTreeLayout new
		  verticalGap: 100;
		  horizontalGap: 100
]

{ #category : 'accessing' }
MMGraphBuilder >> nodes [

	^ nodes
]

{ #category : 'rendering' }
MMGraphBuilder >> renderIn: aCanvas [

	aCanvas color: (Color gray: 0.8).
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
								attachPoint: MMGraphAttachPoint new;
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
									line
										attachPoint: MMGraphAttachPoint new;
										from: from;
										to: to;
										controlPointsController: (self newCPAPController t: 9 / 10).
									aRSCanvas add: line ] ] ] ].
	aRSCanvas edges do: [ :bezier |
			bezier model isMMGraphEdge ifTrue: [
					(self newLabelForEdge: bezier model) ifNotNil: [ :label |
							label position:
								(bezier atT: bezier controlPointsController labelT).
							aRSCanvas addShape: label ] ] ]
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
