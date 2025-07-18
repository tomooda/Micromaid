"
I build a Roassal canvas from nodes and links from Micromaid scripts.
"
Class {
	#name : 'MMGraphRoassalBuilder',
	#superclass : 'MMRoassalBuilder',
	#traits : 'MMTDagRoassalBuilder',
	#classTraits : 'MMTDagRoassalBuilder classTrait',
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
MMGraphRoassalBuilder >> newCPAPController [

	^ self
		  ifVertical: [ MMVerticalCPAPController new ]
		  ifHorizontal: [ MMHorizontalCPAPController new ]
]

{ #category : 'instance creation' }
MMGraphRoassalBuilder >> newShapeForEdge: aMMGraphEdge [

	| bezier |
	bezier := RSBezier new
		        model: aMMGraphEdge;
		        color: Color black;
		        markerStart: (self newMarkerFor: aMMGraphEdge head1);
		        markerEnd: (self newMarkerFor: aMMGraphEdge head2);
		        yourself.
	aMMGraphEdge linestyle = #dotted ifTrue: [ bezier dashed ].
	^ bezier
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
