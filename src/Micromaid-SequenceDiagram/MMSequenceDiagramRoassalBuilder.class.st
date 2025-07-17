Class {
	#name : 'MMSequenceDiagramRoassalBuilder',
	#superclass : 'MMRoassalBuilder',
	#instVars : [
		'nodePositions'
	],
	#category : 'Micromaid-SequenceDiagram-Roassal',
	#package : 'Micromaid-SequenceDiagram',
	#tag : 'Roassal'
}

{ #category : 'instance creation' }
MMSequenceDiagramRoassalBuilder >> newShapeForEdge: aMMSequenceDiagramMessage [

	| line halfWidth label |
	halfWidth := (nodePositions at: aMMSequenceDiagramMessage node2)
	             - (nodePositions at: aMMSequenceDiagramMessage node1)
	             / 2.
	line := RSLine new
		        color: Color black;
		        controlPoints: {
				        (halfWidth negated @ 5).
				        (halfWidth @ 5) };
		        markerStart:
			        (self newMarkerFor: aMMSequenceDiagramMessage head1);
		        markerEnd:
			        (self newMarkerFor: aMMSequenceDiagramMessage head2);
		        yourself.
	aMMSequenceDiagramMessage linestyle = #dotted ifTrue: [ line dashed ].
	label := RSLabel new
		         metricsProvider: RSPharoMetricsProvider new;
		         text: aMMSequenceDiagramMessage label;
		         color: Color black;
		         yourself.
	label translateTo: 0 @ (-5 - (label height / 2)).
	^ {
		  line.
		  label } asShapeFor: aMMSequenceDiagramMessage
]

{ #category : 'instance creation' }
MMSequenceDiagramRoassalBuilder >> newShapeForNode: aMMNode [

	^ aMMNode isMMActor
		  ifTrue: [ self newShapeForHumanNode: aMMNode ]
		  ifFalse: [ self newShapeForRoundedRectNode: aMMNode ]
]

{ #category : 'rendering' }
MMSequenceDiagramRoassalBuilder >> renderIn: aCanvas [

	aCanvas color: (Color gray: 0.8).
	self
		renderNodesIn: aCanvas;
		renderLinksIn: aCanvas
]

{ #category : 'rendering' }
MMSequenceDiagramRoassalBuilder >> renderLinksIn: aCanvas [

	| y |
	y := gap.
	edges do: [ :message |
			| shape |
			shape := (self newShapeForEdge: message) translateTo:
				         (nodePositions at: message node1)
				         + (nodePositions at: message node2) / 2 @ y.

			aCanvas addShape: shape.
			y := y + shape encompassingRectangle height + 10 ].
	nodePositions valuesDo: [ :x |
			aCanvas addShape: (RSLine new
					 controlPoints: {
							 (x @ 0).
							 (x @ y) };
					 color: Color gray;
					 yourself) ]
]

{ #category : 'rendering' }
MMSequenceDiagramRoassalBuilder >> renderNodesIn: aCanvas [

	| x |
	x := 0.
	nodePositions := Dictionary new.
	nodes valuesDo: [ :node |
			| shape rect |
			shape := self newShapeForNode: node.
			rect := shape encompassingRectangle.
			shape translateTo: x - rect left + shape position x
				@ (0 - rect bottom + shape position y).
			aCanvas addShape: shape.
			nodePositions at: node name put: shape position x.
			x := x + gap + rect extent x ]
]
