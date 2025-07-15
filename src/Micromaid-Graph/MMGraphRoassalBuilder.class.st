"
I build a Roassal canvas from nodes and links from Micromaid scripts.
"
Class {
	#name : 'MMGraphRoassalBuilder',
	#superclass : 'RSBuilder',
	#instVars : [
		'nodes',
		'edges',
		'direction',
		'gap'
	],
	#category : 'Micromaid-Graph-Roassal',
	#package : 'Micromaid-Graph',
	#tag : 'Roassal'
}

{ #category : 'adding' }
MMGraphRoassalBuilder >> addEdge: aMMGraphEdge [

	^ edges addLast: aMMGraphEdge
]

{ #category : 'adding' }
MMGraphRoassalBuilder >> addNode: aMMGraphNode [

	^ nodes at: aMMGraphNode name put: aMMGraphNode
]

{ #category : 'adding' }
MMGraphRoassalBuilder >> addSimpleNode: aMMGraphSimpleNode [

	^ nodes
		  at: aMMGraphSimpleNode name
		  ifAbsentPut: [ aMMGraphSimpleNode ]
]

{ #category : 'private' }
MMGraphRoassalBuilder >> attach: aRSBezier from: aRSShape to: anotherRSShape in: aRSCanvas [

	| margin others |
	margin := gap.
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
MMGraphRoassalBuilder >> direction [

	^ direction
]

{ #category : 'accessing' }
MMGraphRoassalBuilder >> direction: aSymbol [

	direction := aSymbol
]

{ #category : 'accessing' }
MMGraphRoassalBuilder >> edges [

	^ edges
]

{ #category : 'accessing' }
MMGraphRoassalBuilder >> gap [

	^ gap
]

{ #category : 'accessing' }
MMGraphRoassalBuilder >> gap: aNumber [

	gap := aNumber
]

{ #category : 'controlling' }
MMGraphRoassalBuilder >> ifVertical: aBlock ifHorizontal: anotherBlock [

	^ (#( TB TD BT ) includes: direction)
		  ifTrue: aBlock
		  ifFalse: anotherBlock
]

{ #category : 'initialization' }
MMGraphRoassalBuilder >> initialize [

	super initialize.
	gap := 50.
	nodes := OrderedDictionary new.
	edges := OrderedCollection new
]

{ #category : 'testing' }
MMGraphRoassalBuilder >> isBottommostShape: aRSShape in: aCollectionOfRSShape [

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
MMGraphRoassalBuilder >> isLeftmostShape: aRSShape in: aCollectionOfRSShape [

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
MMGraphRoassalBuilder >> isRightmostShape: aRSShape in: aCollectionOfRSShape [

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
MMGraphRoassalBuilder >> isTopmostShape: aRSShape in: aCollectionOfRSShape [

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
MMGraphRoassalBuilder >> newCPAPController [

	^ self
		  ifVertical: [ MMGraphVerticalCPAPController new ]
		  ifHorizontal: [ MMGraphHorizontalCPAPController new ]
]

{ #category : 'instance creation' }
MMGraphRoassalBuilder >> newLabelForEdge: aMMGraphEdge [

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
MMGraphRoassalBuilder >> newLabelForNode: aMMGraphNode [

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
MMGraphRoassalBuilder >> newShapeForAsymmetricNode: aMMGraphNode [

	| label extent left right top bottom box |
	label := self newLabelForNode: aMMGraphNode.
	extent := label extent + 20.
	left := extent x / -2 - 10.
	right := extent x / 2.
	top := extent y / -2.
	bottom := extent y / 2.
	box := RSPolygon new
		       points: {
				       (left @ top).
				       (right @ top).
				       (right @ bottom).
				       (left @ bottom).
				       (left + 10 @ 0) };
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
MMGraphRoassalBuilder >> newShapeForCircleNode: aMMGraphNode [

	| label extent circle |
	label := self newLabelForNode: aMMGraphNode.
	extent := (label extent x max: label extent y) asPoint.
	circle := RSCircle new
		          extent: (extent x squared + extent y squared) sqrt asPoint;
		          color: Color white;
		          border: (RSBorder new
				           color: Color black;
				           yourself);
		          yourself.
	^ {
		  circle.
		  label } asShapeFor: aMMGraphNode
]

{ #category : 'instance creation' }
MMGraphRoassalBuilder >> newShapeForCylinderNode: aMMGraphNode [

	| label extent box lid bottom leftBar rightBar |
	label := self newLabelForNode: aMMGraphNode.
	extent := label extent + (20 @ 10).
	box := RSBox new
		       position: 0 @ (extent x / -16);
		       extent: extent x @ (extent x / 8 + extent y);
		       color: Color white;
		       yourself.
	lid := RSEllipse new
		       position: 0 @ (extent y / -2 + (extent x / -8));
		       extent: extent x @ (extent x / 4);
		       color: Color white;
		       border: (RSBorder new color: Color black).
	bottom := RSEllipse new
		          center: 0 @ (extent y / 2);
		          extent: extent x @ (extent x / 4);
		          color: Color white;
		          border: (RSBorder new color: Color black).
	leftBar := RSLine new
		           from: extent x / -2 @ (extent y / -2 + (extent x / -8));
		           to: extent x / -2 @ (extent y / 2);
		           color: Color black.
	rightBar := RSLine new
		            from: extent x / 2 @ (extent y / -2 + (extent x / -8));
		            to: extent x / 2 @ (extent y / 2);
		            color: Color black.
	^ {
		  bottom.
		  box.
		  lid.
		  leftBar.
		  rightBar.
		  label } asShapeFor: aMMGraphNode
]

{ #category : 'instance creation' }
MMGraphRoassalBuilder >> newShapeForDoubleCircleNode: aMMGraphNode [

	| label extent circle circle2 |
	label := self newLabelForNode: aMMGraphNode.
	extent := (label extent x max: label extent y) asPoint.
	circle := RSCircle new
		          extent: (extent x squared + extent y squared) sqrt asPoint;
		          color: Color white;
		          border: (RSBorder new
				           color: Color black;
				           yourself);
		          yourself.
	circle2 := RSCircle new
		          extent: ((extent x squared + extent y squared) sqrt + 5) asPoint;
		          color: Color white;
		          border: (RSBorder new
				           color: Color black;
				           yourself);
		          yourself.
	^ {
		  circle2.
		  circle.
		  label } asShapeFor: aMMGraphNode
]

{ #category : 'instance creation' }
MMGraphRoassalBuilder >> newShapeForEdge: edge [

	^ RSBezier new
		  model: edge;
		  color: Color black;
		  markerStart: (self newMarkerFor: edge head1);
		  markerEnd: (self newMarkerFor: edge head2);
		  yourself
]

{ #category : 'instance creation' }
MMGraphRoassalBuilder >> newShapeForHexagonNode: aMMGraphNode [

	| label extent left right top bottom box |
	label := self newLabelForNode: aMMGraphNode.
	extent := label extent + 20.
	left := extent x / -2.
	right := extent x / 2.
	top := extent y / -2.
	bottom := extent y / 2.
	box := RSPolygon new
		       points: {
				       (left @ top).
				       (right @ top).
				       (right + 10 @ 0).
				       (right @ bottom).
				       (left @ bottom).
				       (left - 10 @ 0) };
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
MMGraphRoassalBuilder >> newShapeForNode: aMMGraphNode [

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
	aMMGraphNode shape = #cylinder ifTrue: [
		^ self newShapeForCylinderNode: aMMGraphNode ].
	aMMGraphNode shape = #circle ifTrue: [
		^ self newShapeForCircleNode: aMMGraphNode ].
	aMMGraphNode shape = #doubleCircle ifTrue: [
		^ self newShapeForDoubleCircleNode: aMMGraphNode ].
	aMMGraphNode shape = #asymmetric ifTrue: [
		^ self newShapeForAsymmetricNode: aMMGraphNode ].
	aMMGraphNode shape = #hexagon ifTrue: [
		^ self newShapeForHexagonNode: aMMGraphNode ].
	aMMGraphNode shape = #parallelogram ifTrue: [
		^ self newShapeForParallelogramNode: aMMGraphNode ].
	aMMGraphNode shape = #parallelogramAlt ifTrue: [
		^ self newShapeForParallelogramAltNode: aMMGraphNode ].
	aMMGraphNode shape = #trapezoid ifTrue: [
		^ self newShapeForTrapezoidNode: aMMGraphNode ].
	aMMGraphNode shape = #trapezoidAlt ifTrue: [
		^ self newShapeForTrapezoidAltNode: aMMGraphNode ].
	^ nil
]

{ #category : 'instance creation' }
MMGraphRoassalBuilder >> newShapeForParallelogramAltNode: aMMGraphNode [

	| label extent left right top bottom box |
	label := self newLabelForNode: aMMGraphNode.
	extent := label extent + 20.
	left := extent x / -2.
	right := extent x / 2.
	top := extent y / -2.
	bottom := extent y / 2.
	box := RSPolygon new
		       points: {
				       (left - 10 @ top).
				       (right - 10 @ top).
				       (right + 10 @ bottom).
				       (left + 10 @ bottom) };
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
MMGraphRoassalBuilder >> newShapeForParallelogramNode: aMMGraphNode [

	| label extent left right top bottom box |
	label := self newLabelForNode: aMMGraphNode.
	extent := label extent + 20.
	left := extent x / -2.
	right := extent x / 2.
	top := extent y / -2.
	bottom := extent y / 2.
	box := RSPolygon new
		       points: {
				       (left + 10 @ top).
				       (right + 10 @ top).
				       (right - 10 @ bottom).
				       (left - 10 @ bottom) };
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
MMGraphRoassalBuilder >> newShapeForRectNode: aMMGraphNode [

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
MMGraphRoassalBuilder >> newShapeForRhombusNode: aMMGraphNode [

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
MMGraphRoassalBuilder >> newShapeForRoundedRectNode: aMMGraphNode [

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
MMGraphRoassalBuilder >> newShapeForStadiumNode: aMMGraphNode [

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
MMGraphRoassalBuilder >> newShapeForSubroutineNode: aMMGraphNode [

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
MMGraphRoassalBuilder >> newShapeForTrapezoidAltNode: aMMGraphNode [

	| label extent left right top bottom box |
	label := self newLabelForNode: aMMGraphNode.
	extent := label extent + 20.
	left := extent x / -2.
	right := extent x / 2.
	top := extent y / -2.
	bottom := extent y / 2.
	box := RSPolygon new
		       points: {
				       (left - 10 @ top).
				       (right + 10 @ top).
				       (right - 10 @ bottom).
				       (left + 10 @ bottom) };
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
MMGraphRoassalBuilder >> newShapeForTrapezoidNode: aMMGraphNode [

	| label extent left right top bottom box |
	label := self newLabelForNode: aMMGraphNode.
	extent := label extent + 20.
	left := extent x / -2.
	right := extent x / 2.
	top := extent y / -2.
	bottom := extent y / 2.
	box := RSPolygon new
		       points: {
				       (left + 10 @ top).
				       (right - 10 @ top).
				       (right + 10 @ bottom).
				       (left - 10 @ bottom) };
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

{ #category : 'accessing' }
MMGraphRoassalBuilder >> nodes [

	^ nodes
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
