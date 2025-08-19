Trait {
	#name : 'MMTDagRoassalBuilder',
	#instVars : [
		'nodes',
		'edges',
		'gap'
	],
	#category : 'Micromaid-Base-Roassal',
	#package : 'Micromaid-Base',
	#tag : 'Roassal'
}

{ #category : 'private' }
MMTDagRoassalBuilder >> attach: aRSBezier from: aRSShape to: anotherRSShape in: aRSCanvas [

	| others |
	others := aRSCanvas nodes copyWithoutAll: {
			          aRSShape.
			          anotherRSShape }.
	aRSShape = anotherRSShape ifTrue: [
		^ self attach: aRSBezier loopAt: aRSShape in: aRSCanvas ].
	aRSShape encompassingRectangle center y
	<= anotherRSShape encompassingRectangle center y
		ifTrue: [
				(self
					 attach: aRSBezier
					 fromRight: aRSShape
					 toRight: anotherRSShape
					 in: aRSCanvas) ifNotNil: [ ^ self ].
				(self
					 attach: aRSBezier
					 fromLeft: aRSShape
					 toLeft: anotherRSShape
					 in: aRSCanvas) ifNotNil: [ ^ self ] ]
		ifFalse: [
				(self
					 attach: aRSBezier
					 fromLeft: aRSShape
					 toLeft: anotherRSShape
					 in: aRSCanvas) ifNotNil: [ ^ self ].
				(self
					 attach: aRSBezier
					 fromRight: aRSShape
					 toRight: anotherRSShape
					 in: aRSCanvas) ifNotNil: [ ^ self ] ].
	aRSShape encompassingRectangle center x
	<= anotherRSShape encompassingRectangle center x
		ifTrue: [
				(self
					 attach: aRSBezier
					 fromTop: aRSShape
					 toTop: anotherRSShape
					 in: aRSCanvas) ifNotNil: [ ^ self ].
				(self
					 attach: aRSBezier
					 fromBottom: aRSShape
					 toBottom: anotherRSShape
					 in: aRSCanvas) ifNotNil: [ ^ self ] ]
		ifFalse: [
				(self
					 attach: aRSBezier
					 fromBottom: aRSShape
					 toBottom: anotherRSShape
					 in: aRSCanvas) ifNotNil: [ ^ self ].
				(self
					 attach: aRSBezier
					 fromTop: aRSShape
					 toTop: anotherRSShape
					 in: aRSCanvas) ifNotNil: [ ^ self ] ].

	aRSBezier
		attachPoint: MMAttachPoint new;
		from: aRSShape;
		to: anotherRSShape;
		controlPointsController: ((self
				  newCPAPControllerBetween: aRSShape position
				  and: anotherRSShape position) t: 0.4)
]

{ #category : 'private' }
MMTDagRoassalBuilder >> attach: aRSBezier fromBottom: aRSShape toBottom: anotherRSShape in: aRSCanvas [

	| margin bottom bottomRect point1 point2 |
	((self isBottommostShape: aRSShape in: aRSCanvas nodes) and: [
		 self isBottommostShape: anotherRSShape in: aRSCanvas nodes ])
		ifFalse: [ ^ nil ].
	margin := gap.
	bottom := (((aRSCanvas nodes select: [ :shape |
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
			            anotherRSShape encompassingRectangle bottom)) + margin.
	bottomRect := aRSShape position x @ (bottom - 10) corner:
		              anotherRSShape position x @ bottom.
	(aRSCanvas nodes anySatisfy: [ :shape |
		 bottomRect intersects: shape encompassingRectangle ]) ifTrue: [
		^ nil ].
	point1 := self attachPointFromBottomOf: aRSShape to: anotherRSShape.
	point2 := self attachPointFromBottomOf: anotherRSShape to: aRSShape.
	aRSBezier controlPoints: {
			point1.
			(point1 x @ bottom).
			(point2 x @ bottom).
			point2 }
]

{ #category : 'private' }
MMTDagRoassalBuilder >> attach: aRSBezier fromLeft: aRSShape toLeft: anotherRSShape in: aRSCanvas [

	| margin left leftRect point1 point2 |
	((self isLeftmostShape: aRSShape in: aRSCanvas nodes) and: [
		 self isLeftmostShape: anotherRSShape in: aRSCanvas nodes ])
		ifFalse: [ ^ nil ].
	margin := gap.
	left := (((aRSCanvas nodes select: [ :shape |
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
	leftRect := left @ aRSShape position y corner:
		            left + 10 @ anotherRSShape position y.
	(aRSCanvas nodes anySatisfy: [ :shape |
		 leftRect intersects: shape encompassingRectangle ]) ifTrue: [
		^ nil ].
	point1 := self attachPointFromLeftOf: aRSShape to: anotherRSShape.
	point2 := self attachPointFromLeftOf: anotherRSShape to: aRSShape.
	aRSBezier controlPoints: {
			point1.
			(left @ point1 y).
			(left @ point2 y).
			point2 }
]

{ #category : 'private' }
MMTDagRoassalBuilder >> attach: aRSBezier fromRight: aRSShape toRight: anotherRSShape in: aRSCanvas [

	| margin right rightRect point1 point2 |
	((self isRightmostShape: aRSShape in: aRSCanvas nodes) and: [
		 self isRightmostShape: anotherRSShape in: aRSCanvas nodes ])
		ifFalse: [ ^ nil ].
	margin := gap.
	right := (((aRSCanvas nodes select: [ :shape |
			            shape encompassingRectangle center y
				            between: (aRSShape encompassingRectangle top min:
						             anotherRSShape encompassingRectangle top)
				            and: (aRSShape encompassingRectangle bottom max:
						             anotherRSShape encompassingRectangle bottom) ])
		           copyWithAll: {
				           aRSShape.
				           anotherRSShape }) collect: [ :shape |
		          shape encompassingRectangle right ]) max.
	right := right + (right - (aRSShape encompassingRectangle right max:
		           anotherRSShape encompassingRectangle right)) + margin.
	rightRect := right - 10 @ aRSShape position y corner:
		             right + 10 @ anotherRSShape position y.
	(aRSCanvas nodes anySatisfy: [ :shape |
		 rightRect intersects: shape encompassingRectangle ]) ifTrue: [
		^ nil ].
	point1 := self attachPointFromRightOf: aRSShape to: anotherRSShape.
	point2 := self attachPointFromRightOf: anotherRSShape to: aRSShape.
	aRSBezier controlPoints: {
			point1.
			(right @ point1 y).
			(right @ point2 y).
			point2 }
]

{ #category : 'private' }
MMTDagRoassalBuilder >> attach: aRSBezier fromTop: aRSShape toTop: anotherRSShape in: aRSCanvas [

	| margin top topRect point1 point2 |
	((self isTopmostShape: aRSShape in: aRSCanvas nodes) and: [
		 self isTopmostShape: anotherRSShape in: aRSCanvas nodes ])
		ifFalse: [ ^ nil ].
	margin := gap.
	top := (((aRSCanvas nodes select: [ :shape |
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
	topRect := aRSShape position x @ top corner:
		           anotherRSShape position x @ (top + 10).
	(aRSCanvas nodes anySatisfy: [ :shape |
		 topRect intersects: shape encompassingRectangle ]) ifTrue: [ ^ nil ].
	point1 := self attachPointFromTopOf: aRSShape to: anotherRSShape.
	point2 := self attachPointFromTopOf: anotherRSShape to: aRSShape.
	aRSBezier controlPoints: {
			point1.
			(point1 x @ top).
			(point2 x @ top).
			point2 }
]

{ #category : 'private' }
MMTDagRoassalBuilder >> attach: aRSBezier loopAt: aRSShape in: aRSCanvas [

	| lines delta rect |
	lines := aRSCanvas shapes select: #isLine.
	delta := gap / 3.
	rect := aRSShape encompassingRectangle.
	(lines anySatisfy: [ :line |
			 line encompassingRectangle containsPoint:
				 rect rightCenter + (delta @ 0) ]) ifFalse: [
		^ self
			  attach: aRSBezier
			  loopFromRightToRight: aRSShape
			  in: aRSCanvas ].
	(lines anySatisfy: [ :line |
			 line encompassingRectangle containsPoint:
				 rect leftCenter + (delta negated @ 0) ]) ifFalse: [
		^ self attach: aRSBezier loopFromLeftToLeft: aRSShape in: aRSCanvas ].
	(lines anySatisfy: [ :line |
			 line encompassingRectangle containsPoint:
				 rect bottomRight + (delta @ delta) ]) ifFalse: [
		^ self
			  attach: aRSBezier
			  loopFromBottomToRight: aRSShape
			  in: aRSCanvas ].
	(lines anySatisfy: [ :line |
			 line encompassingRectangle containsPoint:
				 rect bottomLeft + (delta negated @ delta) ]) ifFalse: [
		^ self
			  attach: aRSBezier
			  loopFromBottomToLeft: aRSShape
			  in: aRSCanvas ].
	(lines anySatisfy: [ :line |
			 line encompassingRectangle containsPoint:
				 rect topRight + (delta @ delta negated) ]) ifFalse: [
		^ self attach: aRSBezier loopFromRightToTop: aRSShape in: aRSCanvas ].
	(lines anySatisfy: [ :line |
			 line encompassingRectangle containsPoint:
				 rect topLeft + (delta negated @ delta negated) ]) ifFalse: [
		^ self attach: aRSBezier loopFromLeftToTop: aRSShape in: aRSCanvas ].
	(lines anySatisfy: [ :line |
			 line encompassingRectangle containsPoint:
				 rect bottomCenter + (0 @ delta) ]) ifFalse: [
			^ self
				  attach: aRSBezier
				  loopFromBottomToBottom: aRSShape
				  in: aRSCanvas ].
	(lines anySatisfy: [ :line |
			 line encompassingRectangle containsPoint:
				 rect topCenter + (0 @ delta negated) ]) ifFalse: [
		^ self attach: aRSBezier loopFromTopToTop: aRSShape in: aRSCanvas ].

	^ self
		  attach: aRSBezier
		  loopFromBottomToRight: aRSShape
		  in: aRSCanvas
]

{ #category : 'private' }
MMTDagRoassalBuilder >> attach: aRSBezier loopFromBottomToBottom: aRSShape in: aRSCanvas [

	| delta point |
	delta := gap.
	point := aRSShape encompassingRectangle bottomCenter.
	aRSBezier controlPoints: {
			point.
			(point + (delta negated @ delta)).
			(point + (delta @ delta)).
			point }
]

{ #category : 'private' }
MMTDagRoassalBuilder >> attach: aRSBezier loopFromBottomToLeft: aRSShape in: aRSCanvas [

	| delta point |
	delta := gap.
	point := aRSShape encompassingRectangle bottomLeft.
	aRSBezier controlPoints: {
			point.
			(point + (0 @ delta)).
			(point + (delta negated @ 0)).
			point }
]

{ #category : 'private' }
MMTDagRoassalBuilder >> attach: aRSBezier loopFromBottomToRight: aRSShape in: aRSCanvas [

	| delta point |
	delta := gap.
	point := aRSShape encompassingRectangle bottomRight.
	aRSBezier controlPoints: {
			point.
			(point + (0 @ delta)).
			(point + (delta @ 0)).
			point }
]

{ #category : 'private' }
MMTDagRoassalBuilder >> attach: aRSBezier loopFromLeftToLeft: aRSShape in: aRSCanvas [

	| delta point |
	delta := gap.
	point := aRSShape encompassingRectangle leftCenter.
	aRSBezier controlPoints: {
			point.
			(point + (delta negated @ delta)).
			(point + (delta negated @ delta negated)).
			point }
]

{ #category : 'private' }
MMTDagRoassalBuilder >> attach: aRSBezier loopFromLeftToTop: aRSShape in: aRSCanvas [

	| delta point |
	delta := gap.
	point := aRSShape encompassingRectangle topLeft.
	aRSBezier controlPoints: {
			point.
			(point + (delta negated @ 0)).
			(point + (0 @ delta negated)).
			point }
]

{ #category : 'private' }
MMTDagRoassalBuilder >> attach: aRSBezier loopFromRightToRight: aRSShape in: aRSCanvas [

	| delta point |
	delta := gap.
	point := aRSShape encompassingRectangle rightCenter.
	aRSBezier controlPoints: {
			point.
			(point + (delta @ delta)).
			(point + (delta @ delta negated)).
			point }
]

{ #category : 'private' }
MMTDagRoassalBuilder >> attach: aRSBezier loopFromRightToTop: aRSShape in: aRSCanvas [

	| delta point |
	delta := gap.
	point := aRSShape encompassingRectangle topRight.
	aRSBezier controlPoints: {
			point.
			(point + (delta @ 0)).
			(point + (0 @ delta negated)).
			point }
]

{ #category : 'private' }
MMTDagRoassalBuilder >> attach: aRSBezier loopFromTopToTop: aRSShape in: aRSCanvas [

	| delta point |
	delta := gap.
	point := aRSShape encompassingRectangle topCenter.
	aRSBezier controlPoints: {
			point.
			(point + (delta negated @ delta negated)).
			(point + (delta @ delta negated)).
			point }
]

{ #category : 'private' }
MMTDagRoassalBuilder >> attachPointFromBottomOf: aRSShape to: anotherRSShape [

	| theta rect |
	theta := ((GLine
		           through: aRSShape encompassingRectangle center
		           and: anotherRSShape encompassingRectangle center)
		          angleWith: (GLine through: 0 @ 0 and: 0 @ 1))
	         \\ (Float pi * 2).
	theta > Float pi ifTrue: [ theta := theta - (Float pi * 2.0) ].
	rect := aRSShape encompassingRectangle.
	^ rect bottomCenter + (theta / Float pi * rect width / 2.0 @ 0)
]

{ #category : 'private' }
MMTDagRoassalBuilder >> attachPointFromLeftOf: aRSShape to: anotherRSShape [

	| theta rect |
	theta := ((GLine
		           through: aRSShape encompassingRectangle center
		           and: anotherRSShape encompassingRectangle center)
		          angleWith: (GLine through: 1 @ 0 and: 0 @ 0))
	         \\ (Float pi * 2).
	theta > Float pi ifTrue: [ theta := theta - (Float pi * 2.0) ].
	rect := aRSShape encompassingRectangle.
	^ rect leftCenter + (0 @ (theta / Float pi * rect height / 2.0))
]

{ #category : 'private' }
MMTDagRoassalBuilder >> attachPointFromRightOf: aRSShape to: anotherRSShape [

	| theta rect |
	theta := ((GLine
		           through: aRSShape encompassingRectangle center
		           and: anotherRSShape encompassingRectangle center)
		          angleWith: (GLine through: 1 @ 0 and: 0 @ 0))
	         \\ (Float pi * 2).
	theta > Float pi ifTrue: [ theta := theta - (Float pi * 2.0) ].
	rect := aRSShape encompassingRectangle.
	^ rect rightCenter + (0 @ (theta / Float pi * rect height / 2.0))
]

{ #category : 'private' }
MMTDagRoassalBuilder >> attachPointFromTopOf: aRSShape to: anotherRSShape [

	| theta rect |
	theta := ((GLine
		           through: aRSShape encompassingRectangle center
		           and: anotherRSShape encompassingRectangle center)
		          angleWith: (GLine through: 0 @ 0 and: 0 @ 1))
	         \\ (Float pi * 2).
	theta > Float pi ifTrue: [ theta := theta - (Float pi * 2.0) ].
	rect := aRSShape encompassingRectangle.
	^ rect topCenter + (theta / Float pi * rect width / 2.0 @ 0)
]

{ #category : 'testing' }
MMTDagRoassalBuilder >> isBottommostShape: aRSShape in: aCollectionOfRSShape [

	| left right y |
	left := aRSShape encompassingRectangle left.
	right := aRSShape encompassingRectangle right.
	y := aRSShape encompassingRectangle top.
	^ aCollectionOfRSShape allSatisfy: [ :shape |
			  shape == aRSShape or: [
					  y > shape encompassingRectangle bottom or: [
							  shape encompassingRectangle right < left or: [
								  shape encompassingRectangle left > right ] ] ] ]
]

{ #category : 'testing' }
MMTDagRoassalBuilder >> isLeftmostShape: aRSShape in: aCollectionOfRSShape [

	| x top bottom |
	x := aRSShape encompassingRectangle right.
	top := aRSShape encompassingRectangle top.
	bottom := aRSShape encompassingRectangle bottom.
	^ aCollectionOfRSShape allSatisfy: [ :shape |
			  shape == aRSShape or: [
					  x < shape encompassingRectangle left or: [
							  shape encompassingRectangle bottom < top or: [
								  shape encompassingRectangle top > bottom ] ] ] ]
]

{ #category : 'testing' }
MMTDagRoassalBuilder >> isRightmostShape: aRSShape in: aCollectionOfRSShape [

	| x top bottom |
	x := aRSShape encompassingRectangle left.
	top := aRSShape encompassingRectangle top.
	bottom := aRSShape encompassingRectangle bottom.
	^ aCollectionOfRSShape allSatisfy: [ :shape |
			  shape == aRSShape or: [
					  x > shape encompassingRectangle right or: [
							  shape encompassingRectangle bottom < top or: [
								  shape encompassingRectangle top > bottom ] ] ] ]
]

{ #category : 'testing' }
MMTDagRoassalBuilder >> isTopmostShape: aRSShape in: aCollectionOfRSShape [

	| left right y |
	left := aRSShape encompassingRectangle left.
	right := aRSShape encompassingRectangle right.
	y := aRSShape encompassingRectangle bottom.
	^ aCollectionOfRSShape allSatisfy: [ :shape |
			  shape == aRSShape or: [
					  y < shape encompassingRectangle top or: [
							  shape encompassingRectangle right < left or: [
								  shape encompassingRectangle left > right ] ] ] ]
]

{ #category : 'instance creation' }
MMTDagRoassalBuilder >> newCPAPController [

	^ self subclassResponsibility
]

{ #category : 'instance creation' }
MMTDagRoassalBuilder >> newCPAPControllerBetween: aPoint and: anotherPoint [

	| v |
	v := anotherPoint - aPoint.
	^ v x abs <= v y abs
		  ifTrue: [ self newVerticalCPAPController ]
		  ifFalse: [ self newHorizontalCPAPController ]
]

{ #category : 'instance creation' }
MMTDagRoassalBuilder >> newHorizontalCPAPController [

	^ MMHorizontalCPAPController new
]

{ #category : 'instance creation' }
MMTDagRoassalBuilder >> newShapeForEdge: aMMEdge [

	^ self subclassResponsibility
]

{ #category : 'instance creation' }
MMTDagRoassalBuilder >> newShapeForNode: aMMNode [

	^ self subclassResponsibility
]

{ #category : 'rendering' }
MMTDagRoassalBuilder >> newTreeLayouter [

	^ self subclassResponsibility
]

{ #category : 'instance creation' }
MMTDagRoassalBuilder >> newVerticalCPAPController [

	^ MMVerticalCPAPController new
]

{ #category : 'rendering' }
MMTDagRoassalBuilder >> renderIn: aCanvas [

	self
		renderNodesIn: aCanvas;
		renderLinksIn: aCanvas
]

{ #category : 'rendering' }
MMTDagRoassalBuilder >> renderLinksIn: aRSCanvas [

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
MMTDagRoassalBuilder >> renderNodesIn: aRSCanvas [

	nodes valuesDo: [ :node |
			| shape |
			shape := self newShapeForNode: node.
			aRSCanvas
				addNode: shape;
				addShape: shape ]
]

{ #category : 'accessing' }
MMTDagRoassalBuilder >> treeEdges [

	| knownNodes |
	knownNodes := Set new: nodes size.
	^ Array streamContents: [ :stream |
			  edges do: [ :edge |
					  edge isSelfLoop ifFalse: [
							  (knownNodes includes: edge node2)
								  ifTrue: [
										  (knownNodes includes: edge node1) ifFalse: [
												  knownNodes
													  add: edge node1;
													  add: edge node2.
												  stream nextPut: edge inversed ] ]
								  ifFalse: [
										  knownNodes
											  add: edge node1;
											  add: edge node2.
										  stream nextPut: edge ] ] ] ]
]
