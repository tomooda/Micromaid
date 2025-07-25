Class {
	#name : 'MMRoassalBuilder',
	#superclass : 'RSBuilder',
	#instVars : [
		'edges',
		'nodes',
		'gap'
	],
	#category : 'Micromaid-Base-Roassal',
	#package : 'Micromaid-Base',
	#tag : 'Roassal'
}

{ #category : 'testing' }
MMRoassalBuilder class >> isAbstract [

	^ self = MMRoassalBuilder
]

{ #category : 'adding' }
MMRoassalBuilder >> addEdge: aMMEdge [

	^ edges addLast: aMMEdge
]

{ #category : 'adding' }
MMRoassalBuilder >> addNode: aMMNode [

	^ nodes at: aMMNode name put: aMMNode
]

{ #category : 'adding' }
MMRoassalBuilder >> addSimpleNode: aMMSimpleNode [

	^ nodes
		  at: aMMSimpleNode name
		  ifAbsentPut: [ aMMSimpleNode ]
]

{ #category : 'defaults' }
MMRoassalBuilder >> defaultGap [

	^ 50
]

{ #category : 'accessing' }
MMRoassalBuilder >> edges [

	^ edges
]

{ #category : 'accessing' }
MMRoassalBuilder >> gap [

	^ gap
]

{ #category : 'accessing' }
MMRoassalBuilder >> gap: aNumber [

	gap := aNumber
]

{ #category : 'initialization' }
MMRoassalBuilder >> initialize [

	super initialize.
	nodes := OrderedDictionary new.
	edges := OrderedCollection new.
	gap := self defaultGap
]

{ #category : 'testing' }
MMRoassalBuilder >> isBottommostShape: aRSShape in: aCollectionOfRSShape [

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
MMRoassalBuilder >> isLeftmostShape: aRSShape in: aCollectionOfRSShape [

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
MMRoassalBuilder >> isRightmostShape: aRSShape in: aCollectionOfRSShape [

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
MMRoassalBuilder >> isTopmostShape: aRSShape in: aCollectionOfRSShape [

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
MMRoassalBuilder >> newLabelForEdge: aMMEdge [

	^ aMMEdge label ifNotNil: [ :string |
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
				  label } asShapeFor: aMMEdge ]
]

{ #category : 'instance creation' }
MMRoassalBuilder >> newLabelForNode: aMMNode [

	| lines |
	lines := aMMNode label lines collect: #trim.
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
MMRoassalBuilder >> newMarkerFor: aSymbol [

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
	aSymbol = #wedgehead ifTrue: [
			| shape marker |
			shape := RSPolygon new
				         points: {
						         (-6 @ 8).
						         (0 @ 0).
						         (6 @ 8).
						         (0 @ 4) };
				         color: Color black;
				         yourself.
			marker := shape asMarker.
			marker offset: shape height / 2.
			^ marker ].
	aSymbol = #aggregation ifTrue: [
			^ (RSPolygon new
				   points: {
						   (-9 @ 0).
						   (0 @ 12).
						   (9 @ 0).
						   (0 @ -12) };
				   color: Color white;
				   borderColor: Color black;
				   borderWidth: 1;
				   asMarker) offset: 12 ].
	aSymbol = #composition ifTrue: [
			^ (RSPolygon new
				   points: {
						   (-9 @ 0).
						   (0 @ 12).
						   (9 @ 0).
						   (0 @ -12) };
				   color: Color black;
				   borderColor: Color black;
				   borderWidth: 1;
				   asMarker) offset: 12 ].
	aSymbol = #inheritance ifTrue: [
			^ (RSPolygon new
				   points: {
						   (-12 @ 12).
						   (0 @ 0).
						   (12 @ 12) };
				   color: Color white;
				   borderColor: Color black;
				   borderWidth: 1;
				   asMarker) offset: 6 ].
	^ nil
]

{ #category : 'instance creation' }
MMRoassalBuilder >> newShapeForAsymmetricNode: aMMNode [

	| label extent left right top bottom box |
	label := self newLabelForNode: aMMNode.
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
		  label } asShapeFor: aMMNode
]

{ #category : 'instance creation' }
MMRoassalBuilder >> newShapeForCircleNode: aMMNode [

	| label extent circle |
	label := self newLabelForNode: aMMNode.
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
		  label } asShapeFor: aMMNode
]

{ #category : 'instance creation' }
MMRoassalBuilder >> newShapeForCylinderNode: aMMNode [

	| label extent box lid bottom leftBar rightBar |
	label := self newLabelForNode: aMMNode.
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
		  label } asShapeFor: aMMNode
]

{ #category : 'instance creation' }
MMRoassalBuilder >> newShapeForDoubleCircleNode: aMMNode [

	| label extent circle circle2 |
	label := self newLabelForNode: aMMNode.
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
		  label } asShapeFor: aMMNode
]

{ #category : 'instance creation' }
MMRoassalBuilder >> newShapeForHexagonNode: aMMNode [

	| label extent left right top bottom box |
	label := self newLabelForNode: aMMNode.
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
		  label } asShapeFor: aMMNode
]

{ #category : 'instance creation' }
MMRoassalBuilder >> newShapeForHumanNode: aMMNode [

	| label head arms stem legs |
	label := self newLabelForNode: aMMNode.
	head := RSCircle new
		        center: 0 @ -5;
		        extent: 20 @ 20;
		        color: Color lightGray;
		        border: (RSBorder new color: Color gray);
		        yourself.
	arms := RSLine new
		        controlPoints: {
				        (-10 @ 10).
				        (10 @ 10) };
		        color: Color gray;
		        yourself.
	stem := RSLine new
		        controlPoints: {
				        (0 @ 5).
				        (0 @ 20) };
		        color: Color gray;
		        yourself.
	legs := RSPolyline new
		        controlPoints: {
				        (-10 @ 30).
				        (0 @ 20).
				        (10 @ 30) };
		        color: Color gray;
		        yourself.
	label position: 0 @ (30 + (label extent y / 2)).
	^ {
		  head.
		  stem.
		  arms.
		  legs.
		  label } asShapeFor: aMMNode
]

{ #category : 'instance creation' }
MMRoassalBuilder >> newShapeForParallelogramAltNode: aMMNode [

	| label extent left right top bottom box |
	label := self newLabelForNode: aMMNode.
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
		  label } asShapeFor: aMMNode
]

{ #category : 'instance creation' }
MMRoassalBuilder >> newShapeForParallelogramNode: aMMNode [

	| label extent left right top bottom box |
	label := self newLabelForNode: aMMNode.
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
		  label } asShapeFor: aMMNode
]

{ #category : 'instance creation' }
MMRoassalBuilder >> newShapeForRectNode: aMMNode [

	| label box |
	label := self newLabelForNode: aMMNode.
	box := RSBox new
		       extent: label extent + 20;
		       color: Color white;
		       border: (RSBorder new
				        color: Color black;
				        yourself);
		       yourself.
	^ {
		  box.
		  label } asShapeFor: aMMNode
]

{ #category : 'instance creation' }
MMRoassalBuilder >> newShapeForRhombusNode: aMMNode [

	| label extent diamond |
	label := self newLabelForNode: aMMNode.
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
		  label } asShapeFor: aMMNode
]

{ #category : 'instance creation' }
MMRoassalBuilder >> newShapeForRoundedRectNode: aMMNode [

	| label box |
	label := self newLabelForNode: aMMNode.
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
		  label } asShapeFor: aMMNode
]

{ #category : 'instance creation' }
MMRoassalBuilder >> newShapeForStadiumNode: aMMNode [

	| label extent box |
	label := self newLabelForNode: aMMNode.
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
		  label } asShapeFor: aMMNode
]

{ #category : 'instance creation' }
MMRoassalBuilder >> newShapeForSubroutineNode: aMMNode [

	| label box1 box2 |
	label := self newLabelForNode: aMMNode.
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
		  label } asShapeFor: aMMNode
]

{ #category : 'instance creation' }
MMRoassalBuilder >> newShapeForTrapezoidAltNode: aMMNode [

	| label extent left right top bottom box |
	label := self newLabelForNode: aMMNode.
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
		  label } asShapeFor: aMMNode
]

{ #category : 'instance creation' }
MMRoassalBuilder >> newShapeForTrapezoidNode: aMMNode [

	| label extent left right top bottom box |
	label := self newLabelForNode: aMMNode.
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
		  label } asShapeFor: aMMNode
]

{ #category : 'accessing' }
MMRoassalBuilder >> nodes [

	^ nodes
]
