Class {
	#name : 'MMGraphBuilder',
	#superclass : 'RSBuilder',
	#instVars : [
		'nodes',
		'edges',
		'direction',
		'gap'
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
    G([stadium スタジアム])
    H[[subroutine サブルーチン]]
    G x-o|cross and circle heads| H') build
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

{ #category : 'private' }
MMGraphBuilder >> attach: aRSBezier from: aRSShape to: anotherRSShape in: aRSCanvas [

	| margin others |
	margin := gap / 2.
	others := aRSCanvas nodes copyWithoutAll: {
			          aRSShape.
			          anotherRSShape }.
	((self isRightmostShape: aRSShape in: others) and: [
		 self isRightmostShape: anotherRSShape in: others ]) ifTrue: [
			| right |
			right := (((others select: [ :shape |
					            shape encompassingRectangle center y
						            between: (aRSShape encompassingRectangle top min:
								             anotherRSShape encompassingRectangle top)
						            and: (aRSShape encompassingRectangle bottom max:
								             anotherRSShape encompassingRectangle bottom) ])
				           copyWithAll: {
						           aRSShape.
						           anotherRSShape }) collect: [ :shape |
				          shape encompassingRectangle right ]) max.
			right := right
			         + (right - (aRSShape encompassingRectangle right max:
					           anotherRSShape encompassingRectangle right)) + margin.
			aRSBezier controlPoints: {
					aRSShape encompassingRectangle rightCenter.
					(right @ aRSShape encompassingRectangle center y).
					(right @ anotherRSShape encompassingRectangle center y).
					anotherRSShape encompassingRectangle rightCenter }.
			^ self ].
	((self isLeftmostShape: aRSShape in: others) and: [
		 self isLeftmostShape: anotherRSShape in: others ]) ifTrue: [
			| left |
			left := (((others select: [ :shape |
					           shape encompassingRectangle center y
						           between: (aRSShape encompassingRectangle top min:
								            anotherRSShape encompassingRectangle top)
						           and: (aRSShape encompassingRectangle bottom max:
								            anotherRSShape encompassingRectangle bottom) ])
				          copyWithAll: {
						          aRSShape.
						          anotherRSShape }) collect: [ :shape |
				         shape encompassingRectangle left ]) min.
			left := left + ((aRSShape encompassingRectangle left min:
				          anotherRSShape encompassingRectangle left) - left)
			        - margin.
			aRSBezier controlPoints: {
					aRSShape encompassingRectangle leftCenter.
					(left @ aRSShape encompassingRectangle center y).
					(left @ anotherRSShape encompassingRectangle center y).
					anotherRSShape encompassingRectangle leftCenter }.
			^ self ].
	((self isBottommostShape: aRSShape in: others) and: [
		 self isBottommostShape: anotherRSShape in: others ]) ifTrue: [
			| bottom |
			bottom := (((others select: [ :shape |
					             shape encompassingRectangle center x
						             between: (aRSShape encompassingRectangle left min:
								              anotherRSShape encompassingRectangle left)
						             and: (aRSShape encompassingRectangle right max:
								              anotherRSShape encompassingRectangle right) ])
				            copyWithAll: {
						            aRSShape.
						            anotherRSShape }) collect: [ :shape |
				           shape encompassingRectangle bottom ]) max.
			bottom := bottom
			          + (bottom - (aRSShape encompassingRectangle bottom max:
					            anotherRSShape encompassingRectangle bottom))
			          + margin.

			aRSBezier controlPoints: {
					aRSShape encompassingRectangle bottomCenter.
					(aRSShape encompassingRectangle center x @ bottom).
					(anotherRSShape encompassingRectangle center x @ bottom).
					anotherRSShape encompassingRectangle bottomCenter }.
			^ self ].
	((self isTopmostShape: aRSShape in: others) and: [
		 self isTopmostShape: anotherRSShape in: others ]) ifTrue: [
			| top |
			top := (((others select: [ :shape |
					          shape encompassingRectangle center x
						          between: (aRSShape encompassingRectangle left min:
								           anotherRSShape encompassingRectangle left)
						          and: (aRSShape encompassingRectangle right max:
								           anotherRSShape encompassingRectangle right) ])
				         copyWithAll: {
						         aRSShape.
						         anotherRSShape }) collect: [ :shape |
				        shape encompassingRectangle top ]) min.
			top := top + ((aRSShape encompassingRectangle top min:
				         anotherRSShape encompassingRectangle top) - top) - margin.

			aRSBezier controlPoints: {
					aRSShape encompassingRectangle topCenter.
					(aRSShape encompassingRectangle center x @ top).
					(anotherRSShape encompassingRectangle center x @ top).
					anotherRSShape encompassingRectangle topCenter }.
			^ self ].

	aRSBezier
		attachPoint: MMGraphAttachPoint new;
		from: aRSShape;
		to: anotherRSShape;
		controlPointsController: (self newCPAPController t: 9 / 10)
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
	gap := 100.
	nodes := OrderedDictionary new.
	edges := OrderedCollection new
]

{ #category : 'testing' }
MMGraphBuilder >> isBottommostShape: aRSShape in: aCollectionOfRSShape [

	| left right y |
	left := aRSShape encompassingRectangle left.
	right := aRSShape encompassingRectangle right.
	y := aRSShape encompassingRectangle top.
	^ aCollectionOfRSShape allSatisfy: [ :shape |
			  y > shape encompassingRectangle bottom or: [
					  shape encompassingRectangle right < left or: [
						  shape encompassingRectangle left > right ] ] ]
]

{ #category : 'testing' }
MMGraphBuilder >> isLeftmostShape: aRSShape in: aCollectionOfRSShape [

	| x top bottom |
	x := aRSShape encompassingRectangle right.
	top := aRSShape encompassingRectangle top.
	bottom := aRSShape encompassingRectangle bottom.
	^ aCollectionOfRSShape allSatisfy: [ :shape |
			  x < shape encompassingRectangle left or: [
					  shape encompassingRectangle bottom < top or: [
						  shape encompassingRectangle top > bottom ] ] ]
]

{ #category : 'testing' }
MMGraphBuilder >> isRightmostShape: aRSShape in: aCollectionOfRSShape [

	| x top bottom |
	x := aRSShape encompassingRectangle left.
	top := aRSShape encompassingRectangle top.
	bottom := aRSShape encompassingRectangle bottom.
	^ aCollectionOfRSShape allSatisfy: [ :shape |
			  x > shape encompassingRectangle right or: [
					  shape encompassingRectangle bottom < top or: [
						  shape encompassingRectangle top > bottom ] ] ]
]

{ #category : 'testing' }
MMGraphBuilder >> isTopmostShape: aRSShape in: aCollectionOfRSShape [

	| left right y |
	left := aRSShape encompassingRectangle left.
	right := aRSShape encompassingRectangle right.
	y := aRSShape encompassingRectangle bottom.
	^ aCollectionOfRSShape allSatisfy: [ :shape |
			  y < shape encompassingRectangle top or: [
					  shape encompassingRectangle right < left or: [
						  shape encompassingRectangle left > right ] ] ]
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
				           metricsProvider: RSPharoMetricsProvider new;
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

	| lines |
	lines := aMMGraphNode label lines collect: #trim.
	^ lines size = 1
		  ifTrue: [
				  RSLabel new
					  metricsProvider: RSPharoMetricsProvider new;
					  text: lines first;
					  color: Color black;
					  yourself ]
		  ifFalse: [
				  | labels center |
				  labels := lines
					            collect: [ :line |
							            RSLabel new
								            metricsProvider: RSPharoMetricsProvider new;
								            text: line;
								            color: Color black;
								            yourself ]
					            as: RSGroup.
				  RSVerticalLineLayout new
					  alignCenter;
					  on: labels.
				  center := labels encompassingRectangle center.
				  labels do: [ :label | label position: label position - center ].
				  labels asShape ]
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

	| label extent box |
	label := self newLabelForNode: aMMGraphNode.
	extent := label extent + 20.
	box := RSBox new
		       extent: (extent x max: extent y) + 20 @ extent y;
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
									self
										attach: line
										from: from
										to: to
										in: aRSCanvas.
									aRSCanvas add: line ] ] ] ].
	aRSCanvas edges do: [ :bezier |
			bezier model isMMGraphEdge ifTrue: [
					(self newLabelForEdge: bezier model) ifNotNil: [ :label |
							label position: (bezier atT:
									 (bezier controlPointsController
										  ifNotNil: #labelT
										  ifNil: [ 0.5 ])).
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
							  knownNodes
								  add: edge node1;
								  add: node2.
							  stream nextPut: edge ] ] ]
]
