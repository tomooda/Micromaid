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
		attachPoint: MMAttachPoint new;
		from: aRSShape;
		to: anotherRSShape;
		controlPointsController: (self newCPAPController t: 9 / 10)
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
