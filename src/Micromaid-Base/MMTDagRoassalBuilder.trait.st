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

{ #category : 'edge layouting' }
MMTDagRoassalBuilder >> attach: aRSBezier from: aRSShape to: anotherRSShape in: aRSCanvas [

	aRSShape == anotherRSShape
		ifTrue: [ self attach: aRSBezier loopAt: aRSShape in: aRSCanvas ]
		ifFalse: [
				(self
					 controlPointsFrom: aRSShape encompassingRectangle
					 to: anotherRSShape encompassingRectangle
					 inCanvas: aRSCanvas)
					ifNotNil: [ :cp | aRSBezier controlPoints: cp ]
					ifNil: [
							aRSBezier
								attachPoint: RSBorderAttachPoint new;
								from: aRSShape;
								to: anotherRSShape;
								controlPointsController: RSDirectedBezierCPAPController new ] ]
]

{ #category : 'edge layouting' }
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

{ #category : 'edge layouting' }
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

{ #category : 'edge layouting' }
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

{ #category : 'edge layouting' }
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

{ #category : 'edge layouting' }
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

{ #category : 'edge layouting' }
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

{ #category : 'edge layouting' }
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

{ #category : 'edge layouting' }
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

{ #category : 'edge layouting' }
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

{ #category : 'edge layouting' }
MMTDagRoassalBuilder >> attachPointFromBottomOf: aRectangle to: anotherRectangle [

	| theta |
	theta := (anotherRectangle center - aRectangle center) theta.
	^ aRectangle bottomCenter + (aRectangle width * 0.3 * theta cos @ 0)
]

{ #category : 'edge layouting' }
MMTDagRoassalBuilder >> attachPointFromLeftOf: aRectangle to: anotherRectangle [

	| theta |
	theta := (anotherRectangle center - aRectangle center) theta.
	^ aRectangle leftCenter + (0 @ (aRectangle height * 0.3 * theta sin))
]

{ #category : 'edge layouting' }
MMTDagRoassalBuilder >> attachPointFromRightOf: aRectangle to: anotherRectangle [

	| theta |
	theta := (anotherRectangle center - aRectangle center) theta.
	^ aRectangle rightCenter + (0 @ (aRectangle height * 0.3 * theta sin))
]

{ #category : 'edge layouting' }
MMTDagRoassalBuilder >> attachPointFromTopOf: aRectangle to: anotherRectangle [

	| theta |
	theta := (anotherRectangle center - aRectangle center) theta.
	^ aRectangle topCenter + (aRectangle width * 0.3 * theta cos @ 0)
]

{ #category : 'edge layouting' }
MMTDagRoassalBuilder >> controlPointsFrom: aRectangle to: anotherRectangle inCanvas: aRSCanvas [

	| geometries leastPenalty bestControlPoints |
	geometries := self geometriesInCanvas: aRSCanvas.
	leastPenalty := Float infinity.
	bestControlPoints := nil.
	self
		possibleControlPointsFrom: aRectangle
		to: anotherRectangle
		do: [ :cp |
				| penalty |
				penalty := self
					           penaltyAgainstControlPoints: cp
					           withGeometries: geometries.
				penalty < leastPenalty ifTrue: [
						leastPenalty := penalty.
						bestControlPoints := cp ] ].
	^ bestControlPoints
]

{ #category : 'edge layouting' }
MMTDagRoassalBuilder >> geometriesInCanvas: aRSCanvas [

	^ aRSCanvas shapes asArray
		  select: [ :shape | shape isKindOf: RSBoundingShape ]
		  thenCollect: [ :shape |
				  | rect |
				  rect := shape encompassingRectangle.
				  GRectangle origin: rect origin corner: rect corner ]
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

{ #category : 'edge layouting' }
MMTDagRoassalBuilder >> penaltyAgainstControlPoints: anArrayOfPoint withGeometries: aCollectionOfGeometry [

	| points lines penalty |
	points := (RSBezier new controlPoints: anArrayOfPoint) lines.
	lines := (1 to: points size - 1) collect: [ :i |
		         GLine through: (points at: i) and: (points at: i + 1) ].
	penalty := 0.
	aCollectionOfGeometry do: [ :geometry |
			(lines anySatisfy: [ :line |
				 (geometry intersectionsWithLine: line) notEmpty ]) ifTrue: [
				penalty := penalty + 1 ] ].
	^ penalty
]

{ #category : 'edge layouting' }
MMTDagRoassalBuilder >> possibleControlPointsFrom: aRectangle to: anotherRectangle do: aBlock [

	self
		possibleControlPointsFromLeft: aRectangle
		toRight: anotherRectangle
		do: aBlock;
		possibleControlPointsFromRight: aRectangle
		toLeft: anotherRectangle
		do: aBlock;
		possibleControlPointsFromBottom: aRectangle
		toTop: anotherRectangle
		do: aBlock;
		possibleControlPointsFromTop: aRectangle
		toBottom: anotherRectangle
		do: aBlock.

	self
		possibleControlPointsFromLeft: aRectangle
		toLeft: anotherRectangle
		do: aBlock;
		possibleControlPointsFromRight: aRectangle
		toRight: anotherRectangle
		do: aBlock.

	self
		possibleControlPointsFromRight: aRectangle
		toBottom: anotherRectangle
		do: aBlock;
		possibleControlPointsFromBottom: aRectangle
		toRight: anotherRectangle
		do: aBlock;
		possibleControlPointsFromBottom: aRectangle
		toLeft: anotherRectangle
		do: aBlock;
		possibleControlPointsFromLeft: aRectangle
		toBottom: anotherRectangle
		do: aBlock;
		possibleControlPointsFromBottom: aRectangle
		toBottom: anotherRectangle
		do: aBlock.

	self
		possibleControlPointsFromLeft: aRectangle
		toTop: anotherRectangle
		do: aBlock;
		possibleControlPointsFromRight: aRectangle
		toTop: anotherRectangle
		do: aBlock;
		possibleControlPointsFromTop: aRectangle
		toRight: anotherRectangle
		do: aBlock;
		possibleControlPointsFromTop: aRectangle
		toLeft: anotherRectangle
		do: aBlock;
		possibleControlPointsFromTop: aRectangle
		toTop: anotherRectangle
		do: aBlock
]

{ #category : 'edge layouting' }
MMTDagRoassalBuilder >> possibleControlPointsFromBottom: aRectangle toBottom: anotherRectangle do: aBlock [

	| bottom p1 p2 |
	bottom := (aRectangle bottom max: anotherRectangle bottom) + self gap.
	p1 := self attachPointFromBottomOf: aRectangle to: anotherRectangle.
	p2 := self attachPointFromBottomOf: anotherRectangle to: aRectangle.
	(p1 x between: anotherRectangle left and: anotherRectangle right)
		ifTrue: [ ^ self ].
	(p2 x between: aRectangle left and: aRectangle right) ifTrue: [
		^ self ].
	aBlock value: {
			p1.
			(p1 x @ bottom).
			(p2 x @ bottom).
			p2 }
]

{ #category : 'edge layouting' }
MMTDagRoassalBuilder >> possibleControlPointsFromBottom: aRectangle toLeft: anotherRectangle do: aBlock [

	| p1 p2 |
	aRectangle bottom <= anotherRectangle center y ifFalse: [ ^ self ].
	aRectangle center x <= anotherRectangle left ifFalse: [ ^ self ].
	p1 := self attachPointFromBottomOf: aRectangle to: anotherRectangle.
	p2 := self attachPointFromLeftOf: anotherRectangle to: aRectangle.
	aBlock value: {
			p1.
			(p1 x @ p2 y).
			p2 }
]

{ #category : 'edge layouting' }
MMTDagRoassalBuilder >> possibleControlPointsFromBottom: aRectangle toRight: anotherRectangle do: aBlock [

	| p1 p2 |
	aRectangle bottom <= anotherRectangle center y ifFalse: [ ^ self ].
	anotherRectangle right <= aRectangle center x ifFalse: [ ^ self ].
	p1 := self attachPointFromBottomOf: aRectangle to: anotherRectangle.
	p2 := self attachPointFromRightOf: anotherRectangle to: aRectangle.
	aBlock value: {
			p1.
			(p1 x @ p2 y).
			p2 }
]

{ #category : 'edge layouting' }
MMTDagRoassalBuilder >> possibleControlPointsFromBottom: aRectangle toTop: anotherRectangle do: aBlock [

	| p1 p2 middle |
	aRectangle bottom < anotherRectangle top ifFalse: [ ^ self ].
	p1 := self attachPointFromBottomOf: aRectangle to: anotherRectangle.
	p2 := self attachPointFromTopOf: anotherRectangle to: aRectangle.
	middle := p1 y + p2 y / 2.0.
	aBlock value: {
			p1.
			(p1 x @ middle).
			(p2 x @ middle).
			p2 }
]

{ #category : 'edge layouting' }
MMTDagRoassalBuilder >> possibleControlPointsFromLeft: aRectangle toBottom: anotherRectangle do: aBlock [

	self
		possibleControlPointsFromBottom: anotherRectangle
		toLeft: aRectangle
		do: [ :cp | aBlock value: cp reversed ]
]

{ #category : 'edge layouting' }
MMTDagRoassalBuilder >> possibleControlPointsFromLeft: aRectangle toLeft: anotherRectangle do: aBlock [

	| left p1 p2 |
	left := (aRectangle left min: anotherRectangle left) - self gap.
	p1 := self attachPointFromLeftOf: aRectangle to: anotherRectangle.
	p2 := self attachPointFromLeftOf: anotherRectangle to: aRectangle.
	(p1 y between: anotherRectangle top and: anotherRectangle bottom)
		ifTrue: [ ^ self ].
	(p2 y between: aRectangle top and: aRectangle bottom) ifTrue: [
		^ self ].
	aBlock value: {
			p1.
			(left @ p1 y).
			(left @ p2 y).
			p2 }
]

{ #category : 'edge layouting' }
MMTDagRoassalBuilder >> possibleControlPointsFromLeft: aRectangle toRight: anotherRectangle do: aBlock [

	| p1 p2 middle |
	anotherRectangle right < aRectangle left ifFalse: [ ^ self ].
	p1 := self attachPointFromLeftOf: aRectangle to: anotherRectangle.
	p2 := self attachPointFromRightOf: anotherRectangle to: aRectangle.
	middle := p1 x + p2 x / 2.0.
	aBlock value: {
			p1.
			(middle @ p1 y).
			(middle @ p2 y).
			p2 }
]

{ #category : 'edge layouting' }
MMTDagRoassalBuilder >> possibleControlPointsFromLeft: aRectangle toTop: anotherRectangle do: aBlock [

	| p1 p2 |
	anotherRectangle center x <= aRectangle left ifFalse: [ ^ self ].
	aRectangle center y <= anotherRectangle top ifFalse: [ ^ self ].
	p1 := self attachPointFromLeftOf: aRectangle to: anotherRectangle.
	p2 := self attachPointFromTopOf: anotherRectangle to: aRectangle.
	aBlock value: {
			p1.
			(p2 x @ p1 y).
			p2 }
]

{ #category : 'edge layouting' }
MMTDagRoassalBuilder >> possibleControlPointsFromRight: aRectangle toBottom: anotherRectangle do: aBlock [

	self
		possibleControlPointsFromBottom: anotherRectangle
		toRight: aRectangle
		do: [ :cp | aBlock value: cp reversed ]
]

{ #category : 'edge layouting' }
MMTDagRoassalBuilder >> possibleControlPointsFromRight: aRectangle toLeft: anotherRectangle do: aBlock [

	self
		possibleControlPointsFromLeft: anotherRectangle
		toRight: aRectangle
		do: [ :cp | aBlock value: cp reversed ]
]

{ #category : 'edge layouting' }
MMTDagRoassalBuilder >> possibleControlPointsFromRight: aRectangle toRight: anotherRectangle do: aBlock [

	| right p1 p2 |
	right := (aRectangle right max: anotherRectangle right) + self gap.
	p1 := self attachPointFromRightOf: aRectangle to: anotherRectangle.
	p2 := self attachPointFromRightOf: anotherRectangle to: aRectangle.
	(p1 y between: anotherRectangle top and: anotherRectangle bottom)
		ifTrue: [ ^ self ].
	(p2 y between: aRectangle top and: aRectangle bottom) ifTrue: [
		^ self ].
	aBlock value: {
			p1.
			(right @ p1 y).
			(right @ p2 y).
			p2 }
]

{ #category : 'edge layouting' }
MMTDagRoassalBuilder >> possibleControlPointsFromRight: aRectangle toTop: anotherRectangle do: aBlock [

	| p1 p2 |
	aRectangle right <= anotherRectangle center x ifFalse: [ ^ self ].
	aRectangle center y <= anotherRectangle top ifFalse: [ ^ self ].
	p1 := self attachPointFromRightOf: aRectangle to: anotherRectangle.
	p2 := self attachPointFromTopOf: anotherRectangle to: aRectangle.
	aBlock value: {
			p1.
			(p2 x @ p1 y).
			p2 }
]

{ #category : 'edge layouting' }
MMTDagRoassalBuilder >> possibleControlPointsFromTop: aRectangle toBottom: anotherRectangle do: aBlock [

	self
		possibleControlPointsFromBottom: anotherRectangle
		toTop: aRectangle
		do: [ :cp | aBlock value: cp reversed ]
]

{ #category : 'edge layouting' }
MMTDagRoassalBuilder >> possibleControlPointsFromTop: aRectangle toLeft: anotherRectangle do: aBlock [

	self
		possibleControlPointsFromLeft: anotherRectangle
		toTop: aRectangle
		do: [ :cp | aBlock value: cp reversed ]
]

{ #category : 'edge layouting' }
MMTDagRoassalBuilder >> possibleControlPointsFromTop: aRectangle toRight: anotherRectangle do: aBlock [

	self
		possibleControlPointsFromRight: anotherRectangle
		toTop: aRectangle
		do: [ :cp | aBlock value: cp reversed ]
]

{ #category : 'edge layouting' }
MMTDagRoassalBuilder >> possibleControlPointsFromTop: aRectangle toTop: anotherRectangle do: aBlock [

	| top p1 p2 |
	top := (aRectangle top min: anotherRectangle top) - self gap.
	p1 := self attachPointFromTopOf: aRectangle to: anotherRectangle.
	p2 := self attachPointFromTopOf: anotherRectangle to: aRectangle.
	(p1 x between: anotherRectangle left and: anotherRectangle right)
		ifTrue: [ ^ self ].
	(p2 x between: aRectangle left and: aRectangle right) ifTrue: [
		^ self ].
	aBlock value: {
			p1.
			(p1 x @ top).
			(p2 x @ top).
			p2 }
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
