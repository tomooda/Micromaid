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
		controlPointsController: (self newCPAPController t: 9 / 10)
]

{ #category : 'private' }
MMTDagRoassalBuilder >> attach: aRSBezier fromBottom: aRSShape toBottom: anotherRSShape in: aRSCanvas [

	| margin others bottom |
	others := aRSCanvas nodes copyWithoutAll: {
			          aRSShape.
			          anotherRSShape }.
	((self isBottommostShape: aRSShape in: others) and: [
		 self isBottommostShape: anotherRSShape in: others ]) ifFalse: [
		^ nil ].
	margin := gap.
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
			            anotherRSShape encompassingRectangle bottom)) + margin.

	aRSBezier controlPoints: {
			aRSShape encompassingRectangle bottomCenter.
			(aRSShape encompassingRectangle center x @ bottom).
			(anotherRSShape encompassingRectangle center x @ bottom).
			anotherRSShape encompassingRectangle bottomCenter }
]

{ #category : 'private' }
MMTDagRoassalBuilder >> attach: aRSBezier fromLeft: aRSShape toLeft: anotherRSShape in: aRSCanvas [

	| margin others left |
	others := aRSCanvas nodes copyWithoutAll: {
			          aRSShape.
			          anotherRSShape }.
	((self isLeftmostShape: aRSShape in: others) and: [
		 self isLeftmostShape: anotherRSShape in: others ]) ifFalse: [
		^ nil ].
	margin := gap.
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
			anotherRSShape encompassingRectangle leftCenter }
]

{ #category : 'private' }
MMTDagRoassalBuilder >> attach: aRSBezier fromRight: aRSShape toRight: anotherRSShape in: aRSCanvas [

	| margin others right |
	others := aRSCanvas nodes copyWithoutAll: {
			          aRSShape.
			          anotherRSShape }.
	((self isRightmostShape: aRSShape in: others) and: [
		 self isRightmostShape: anotherRSShape in: others ]) ifFalse: [
		^ nil ].
	margin := gap.
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
	right := right + (right - (aRSShape encompassingRectangle right max:
		           anotherRSShape encompassingRectangle right)) + margin.
	aRSBezier controlPoints: {
			aRSShape encompassingRectangle rightCenter.
			(right @ aRSShape encompassingRectangle center y).
			(right @ anotherRSShape encompassingRectangle center y).
			anotherRSShape encompassingRectangle rightCenter }
]

{ #category : 'private' }
MMTDagRoassalBuilder >> attach: aRSBezier fromTop: aRSShape toTop: anotherRSShape in: aRSCanvas [

	| margin others top |
	others := aRSCanvas nodes copyWithoutAll: {
			          aRSShape.
			          anotherRSShape }.
	((self isTopmostShape: aRSShape in: others) and: [
		 self isTopmostShape: anotherRSShape in: others ]) ifFalse: [ ^ nil ].
	margin := gap.
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
			anotherRSShape encompassingRectangle topCenter }
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

{ #category : 'instance creation' }
MMTDagRoassalBuilder >> newCPAPController [

	^ self subclassResponsibility
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

{ #category : 'rendering' }
MMTDagRoassalBuilder >> renderIn: aCanvas [

	aCanvas color: (Color gray: 0.8).
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
					  | node2 |
					  node2 := edge node2.
					  (knownNodes includes: node2) ifFalse: [
							  knownNodes
								  add: edge node1;
								  add: node2.
							  stream nextPut: edge ] ] ]
]
