Class {
	#name : 'MMStateDiagramRoassalBuilder',
	#superclass : 'MMRoassalBuilder',
	#traits : 'MMTDagRoassalBuilder',
	#classTraits : 'MMTDagRoassalBuilder classTrait',
	#category : 'Micromaid-StateDiagram-Roassal',
	#package : 'Micromaid-StateDiagram',
	#tag : 'Roassal'
}

{ #category : 'instance creation' }
MMStateDiagramRoassalBuilder >> newCPAPController [

	^ MMVerticalCPAPController new
]

{ #category : 'instance creation' }
MMStateDiagramRoassalBuilder >> newShapeForEdge: aMMEdge [

	^ RSBezier new
		  model: aMMEdge;
		  color: Color black;
		  markerEnd: (self newMarkerFor: #arrowhead);
		  yourself
]

{ #category : 'instance creation' }
MMStateDiagramRoassalBuilder >> newShapeForNode: aMMNode [

	aMMNode isStartState ifTrue: [ ^ self newShapeForStartNode: aMMNode ].
	aMMNode isStopState ifTrue: [ ^ self newShapeForStopNode: aMMNode ].
	^ self newShapeForRoundedRectNode: aMMNode
]

{ #category : 'instance creation' }
MMStateDiagramRoassalBuilder >> newShapeForStartNode: aMMStateDiagramStartNode [

	^ RSCircle new
		  extent: 16 @ 16;
		  color: Color black;
		  model: aMMStateDiagramStartNode
]

{ #category : 'instance creation' }
MMStateDiagramRoassalBuilder >> newShapeForStopNode: aMMStateDiagramStopNode [

	^ {
		  (RSCircle new
			   extent: 16 @ 16;
			   color: Color white;
			   border: (RSBorder new color: Color black)).
		  (RSCircle new
			   extent: 8 @ 8;
			   color: Color gray) } asShapeFor: aMMStateDiagramStopNode
]

{ #category : 'rendering' }
MMStateDiagramRoassalBuilder >> newTreeLayouter [

	^ RSVanDerPloegTreeLayout new
		  verticalGap: gap;
		  horizontalGap: gap
]
