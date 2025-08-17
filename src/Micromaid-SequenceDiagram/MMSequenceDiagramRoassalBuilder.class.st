Class {
	#name : 'MMSequenceDiagramRoassalBuilder',
	#superclass : 'MMRoassalBuilder',
	#instVars : [
		'nodePositions',
		'nodeThreads',
		'openNodeThreads',
		'activationWidth',
		'messageMargin',
		'edgePositions'
	],
	#category : 'Micromaid-SequenceDiagram-Roassal',
	#package : 'Micromaid-SequenceDiagram',
	#tag : 'Roassal'
}

{ #category : 'adding' }
MMSequenceDiagramRoassalBuilder >> addActivation: aMMSequenceDiagramActivation [

	(openNodeThreads
		 at: aMMSequenceDiagramActivation name
		 ifAbsentPut: [ OrderedCollection new ]) addLast: {
			edges size.
			nil }
]

{ #category : 'adding' }
MMSequenceDiagramRoassalBuilder >> addDeactivation: aMMSequenceDiagramActivation [

	openNodeThreads
		at: aMMSequenceDiagramActivation name
		ifPresent: [ :openThreads |
				openThreads ifNotEmpty: [
						| thread |
						thread := openThreads removeLast.
						thread at: 2 put: edges size.
						(nodeThreads
							 at: aMMSequenceDiagramActivation name
							 ifAbsentPut: [
								 SortedCollection sortBlock: [ :less :more |
									 less first <= more first ] ]) add: thread ] ]
]

{ #category : 'defaults' }
MMSequenceDiagramRoassalBuilder >> defaultActivationWidth [

	^ 10
]

{ #category : 'defaults' }
MMSequenceDiagramRoassalBuilder >> defaultGap [

	^ 100
]

{ #category : 'defaults' }
MMSequenceDiagramRoassalBuilder >> defaultMessageMargin [

	^ 36
]

{ #category : 'initialization' }
MMSequenceDiagramRoassalBuilder >> initialize [

	super initialize.
	nodeThreads := Dictionary new.
	openNodeThreads := Dictionary new.
	activationWidth := self defaultActivationWidth.
	messageMargin := self defaultMessageMargin
]

{ #category : 'instance creation' }
MMSequenceDiagramRoassalBuilder >> newShapeForEdge: aMMSequenceDiagramMessage y: aNumber [

	| line centerX positions label lineY |
	aMMSequenceDiagramMessage node1 = aMMSequenceDiagramMessage node2
		ifTrue: [
		^ self newShapeForLoopEdge: aMMSequenceDiagramMessage y: aNumber ].
	centerX := (nodePositions at: aMMSequenceDiagramMessage node2)
	           + (nodePositions at: aMMSequenceDiagramMessage node1) / 2.
	positions := self xPositionsOfMessage: aMMSequenceDiagramMessage.
	label := RSLabel new
		         metricsProvider: RSPharoMetricsProvider new;
		         text: aMMSequenceDiagramMessage label;
		         color: Color black;
		         yourself.
	label translateTo: centerX @ (aNumber + (label height / 2)).
	lineY := label encompassingRectangle bottom + 4.
	line := RSLine new
		        color: Color black;
		        startPoint: positions first @ lineY;
		        endPoint: positions second @ lineY;
		        markerStart:
			        (self newMarkerFor: aMMSequenceDiagramMessage head1);
		        markerEnd:
			        (self newMarkerFor: aMMSequenceDiagramMessage head2);
		        yourself.
	edgePositions at: aMMSequenceDiagramMessage put: lineY.
	aMMSequenceDiagramMessage linestyle = #dotted ifTrue: [ line dashed ].
	^ {
		  line.
		  label } asShapeFor: aMMSequenceDiagramMessage
]

{ #category : 'instance creation' }
MMSequenceDiagramRoassalBuilder >> newShapeForLoopEdge: aMMSequenceDiagramMessage y: aNumber [

	| centerX positions label lineY line1 line2 line3 |
	centerX := (nodePositions at: aMMSequenceDiagramMessage node1)
	           + (gap / 2).
	positions := self xPositionsOfMessage: aMMSequenceDiagramMessage.
	label := RSLabel new
		         metricsProvider: RSPharoMetricsProvider new;
		         text: aMMSequenceDiagramMessage label;
		         color: Color black;
		         yourself.
	label translateTo: centerX @ (aNumber + (label height / 2)).
	lineY := label encompassingRectangle bottom + 4.
	line1 := RSLine new
		         startPoint: positions first @ lineY;
		         endPoint: centerX @ lineY;
		         color: Color black;
		         markerStart:
			         (self newMarkerFor: aMMSequenceDiagramMessage head1);
		         yourself.
	line2 := RSLine new
		         startPoint: centerX @ lineY;
		         endPoint: centerX @ (lineY + 20);
		         color: Color black;
		         yourself.
	line3 := RSLine new
		         startPoint: centerX @ (lineY + 20);
		         endPoint: positions second @ (lineY + 20);
		         color: Color black;
		         markerEnd:
			         (self newMarkerFor: aMMSequenceDiagramMessage head2);
		         yourself.
	edgePositions at: aMMSequenceDiagramMessage put: lineY + 20.
	aMMSequenceDiagramMessage linestyle = #dotted ifTrue: [
			line1 dashed.
			line2 dashed.
			line3 dashed ].
	^ {
		  line1.
		  line2.
		  line3.
		  label } asShapeFor: aMMSequenceDiagramMessage
]

{ #category : 'instance creation' }
MMSequenceDiagramRoassalBuilder >> newShapeForNode: aMMNode [

	^ aMMNode isMMActor
		  ifTrue: [ self newShapeForHumanNode: aMMNode ]
		  ifFalse: [ self newShapeForRoundedRectNode: aMMNode ]
]

{ #category : 'accessing' }
MMSequenceDiagramRoassalBuilder >> nodeLeftAt: aString messageIndex: anInteger [

	^ (self threadsAt: aString messageIndex: anInteger)
		  ifNotEmpty: [ (nodePositions at: aString) - (activationWidth / 2) ]
		  ifEmpty: [ nodePositions at: aString ]
]

{ #category : 'accessing' }
MMSequenceDiagramRoassalBuilder >> nodeRightAt: aString messageIndex: anInteger [

	^ (nodePositions at: aString)
	  + ((self threadsAt: aString messageIndex: anInteger) size
		   * activationWidth / 2)
]

{ #category : 'rendering' }
MMSequenceDiagramRoassalBuilder >> renderIn: aCanvas [

	nodePositions := Dictionary new.
	edgePositions := Dictionary new.
	self
		renderNodesIn: aCanvas;
		renderLinksIn: aCanvas
]

{ #category : 'rendering' }
MMSequenceDiagramRoassalBuilder >> renderLinksIn: aCanvas [

	| y |
	y := 40.
	edges do: [ :message |
			| shape |
			shape := self newShapeForEdge: message y: y.
			aCanvas addShape: shape.
			y := y + shape encompassingRectangle height + messageMargin ].
	(Array streamContents: [ :stream |
				 nodeThreads keysAndValuesDo: [ :node :threads |
							 | stack |
							 stack := Array new.
							 threads do: [ :pair |
										 | y1 y2 box |
										 stack := (stack select: [ :p | p second > pair first ])
											          copyWith: pair.
										 y1 := edgePositions at: (edges at: pair first).
										 y2 := edgePositions at: (edges at: pair second).
										 box := RSBox new
											        position:
												        (nodePositions at: node)
												        + (stack size - 1 * activationWidth / 2)
												        @ (y1 + y2 / 2);
											        extent: activationWidth @ (y2 - y1);
											        color: Color white;
											        border: (RSBorder new color: Color gray).
										 stream nextPut: box ] ] ]) asShape
		addedIn: aCanvas;
		pushBack.
	nodePositions valuesDo: [ :x |
			| line |
			line := RSLine new
				        controlPoints: {
						        (x @ 0).
						        (x @ y) };
				        color: Color gray;
				        yourself.
			aCanvas addShape: line.
			line pushBack ]
]

{ #category : 'rendering' }
MMSequenceDiagramRoassalBuilder >> renderNodesIn: aCanvas [

	| x |
	x := 0.
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

{ #category : 'accessing' }
MMSequenceDiagramRoassalBuilder >> threadsAt: aString messageIndex: anInteger [

	^ nodeThreads
		  at: aString
		  ifPresent: [ :threads |
				  threads select: [ :thread |
					  anInteger between: thread first and: thread second ] ]
		  ifAbsent: [ #(  ) ]
]

{ #category : 'accessing' }
MMSequenceDiagramRoassalBuilder >> xPositionsOfMessage: aMMSequenceDiagramMessage [

	| node1 node2 messageIndex |
	node1 := aMMSequenceDiagramMessage node1.
	node2 := aMMSequenceDiagramMessage node2.
	messageIndex := edges indexOf: aMMSequenceDiagramMessage.
	^ node1 = node2
		  ifTrue: [
				 {self nodeRightAt: node1 messageIndex: messageIndex - 1.
self nodeRightAt: node1 messageIndex: messageIndex} ]
		  ifFalse: [
				  (nodePositions at: node1) <= (nodePositions at: node2)
					  ifTrue: [
							  {
								  (self nodeRightAt: node1 messageIndex: messageIndex).
								  (self nodeLeftAt: node2 messageIndex: messageIndex) } ]
					  ifFalse: [
							  {
								  (self nodeLeftAt: node1 messageIndex: messageIndex).
								  (self nodeRightAt: node2 messageIndex: messageIndex) } ] ]
]
