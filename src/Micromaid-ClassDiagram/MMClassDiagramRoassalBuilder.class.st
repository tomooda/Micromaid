Class {
	#name : 'MMClassDiagramRoassalBuilder',
	#superclass : 'MMRoassalBuilder',
	#traits : 'MMTDagRoassalBuilder',
	#classTraits : 'MMTDagRoassalBuilder classTrait',
	#instVars : [
		'defaultClass',
		'enforcesOperation',
		'direction'
	],
	#category : 'Micromaid-ClassDiagram-Roassal',
	#package : 'Micromaid-ClassDiagram',
	#tag : 'Roassal'
}

{ #category : 'examples' }
MMClassDiagramRoassalBuilder class >> exampleCollection [

	| diagram |
	diagram := MMClassDiagramParser new parse: 'classDiagram
	class Collection {
		<<abstract>>
		%% methods
		<<abstract>> size () : Integer
		<<abstract>> do: (BlockClosure)
		collect: (BlockClosure)
	}
	class SequenceableCollection { 
		<<abstract>> 
		%% methods
		<<abstract>> at: (Integer) : Object
		<<abstract>> at:put: (Integer, Object) : Object
		do: (BlockClosure)
	}
	class Array {
		<<variable>>
		%% methods
		<<primitive>> at: (Integer) : Object
		<<primitive>> at:put: (Integer, Object) : Object
		<<primitive>> size () : Integer
	}
	class OrderedCollection {
		array : Array
		firstIndex : Integer
		lastIndex : Integer
		%% methods
		at: (Integer) : Object
		at:put: (Integer, Object) : Object
		size () : Integer
		- compact ()
	}
	class Set { 
		tally : Integer
		array : Array
		%% methods
		size () : Integer
		do: (BlockClosure)
		-rehash ()
	}
	Collection <|-- SequenceableCollection
	SequenceableCollection <|-- Array
	SequenceableCollection <|-- OrderedCollection
	Collection <|-- Set
	Array <.. OrderedCollection : internal containter
	Array <.. Set : hash table'.
	diagram roassalBuilder build
		zoomToFit;
		@ RSCanvasController;
		openWithTitle: self class name , ' class >>' , thisContext selector
]

{ #category : 'operations' }
MMClassDiagramRoassalBuilder >> addAnnotation: aString [

	self defaultClass ifNotNil: [ :class |
		(self ensureClassNamed: class) addAnnotation: aString ]
]

{ #category : 'adding' }
MMClassDiagramRoassalBuilder >> addAttribute: aString to: anotherString [

	^ (self ensureClassNamed:
		   (anotherString ifNil: [ self defaultClass ])) addAttribute:
		  aString
]

{ #category : 'operations' }
MMClassDiagramRoassalBuilder >> addMember: aString to: anotherString [

	^ (self enforcesOperation or: [
		   (aString includes: $() and: [ aString includes: $) ] ])
		  ifTrue: [ self addOperation: aString to: anotherString ]
		  ifFalse: [ self addAttribute: aString to: anotherString ]
]

{ #category : 'adding' }
MMClassDiagramRoassalBuilder >> addOperation: aString to: anotherString [

	^ (self ensureClassNamed:
		   (anotherString ifNil: [ self defaultClass ])) addOperation:
		  aString
]

{ #category : 'operations' }
MMClassDiagramRoassalBuilder >> beginAttributes [

	self enforcesOperation: false
]

{ #category : 'operations' }
MMClassDiagramRoassalBuilder >> beginClass: aString label: anotherString [

	(self ensureClassNamed: aString) label: anotherString.
	self defaultClass: aString
]

{ #category : 'operations' }
MMClassDiagramRoassalBuilder >> beginOperations [

	self enforcesOperation: true
]

{ #category : 'private' }
MMClassDiagramRoassalBuilder >> cardinalityLabelPositionFor: aRSLabel in: aRSBezier atT: aNumber [

	| extent position delta theta |
	extent := aRSLabel extent.
	position := aRSBezier atT: aNumber.
	delta := (aRSBezier atT: (aNumber + 0.1 min: 1.0))
	         - (aRSBezier atT: (aNumber - 0.1 max: 0.0)).
	theta := delta theta.
	aNumber >= 0.5 ifTrue: [ theta := theta + Float pi ].
	^ (Point r: 1.0 theta: delta theta + (Float pi / 2))
	  + (Point r: 1.0 theta: theta) * extent * 1.5 + position
]

{ #category : 'accessing' }
MMClassDiagramRoassalBuilder >> defaultClass [

	^ defaultClass
]

{ #category : 'accessing' }
MMClassDiagramRoassalBuilder >> defaultClass: aString [

	defaultClass := aString
]

{ #category : 'accessing' }
MMClassDiagramRoassalBuilder >> direction [

	^ direction
]

{ #category : 'accessing' }
MMClassDiagramRoassalBuilder >> direction: aSymbol [

	direction := aSymbol asSymbol
]

{ #category : 'operations' }
MMClassDiagramRoassalBuilder >> endClass [

	self enforcesOperation: false.
	self defaultClass: nil
]

{ #category : 'testing' }
MMClassDiagramRoassalBuilder >> enforcesOperation [

	^ enforcesOperation = true
]

{ #category : 'accessing' }
MMClassDiagramRoassalBuilder >> enforcesOperation: aBoolean [

	enforcesOperation := aBoolean = true
]

{ #category : 'operations' }
MMClassDiagramRoassalBuilder >> ensureClassNamed: aString [

	^ nodes at: aString ifAbsentPut: [
			  MMClassDiagramNode new
				  name: aString;
				  yourself ]
]

{ #category : 'controlling' }
MMClassDiagramRoassalBuilder >> ifVertical: aBlock ifHorizontal: anotherBlock [

	^ (#( TB TD BT ) includes: direction)
		  ifTrue: aBlock
		  ifFalse: anotherBlock
]

{ #category : 'initialization' }
MMClassDiagramRoassalBuilder >> initialize [

	super initialize.
	direction := #TD
]

{ #category : 'instance creation' }
MMClassDiagramRoassalBuilder >> newCPAPController [

	^ self
		  ifVertical: [ MMVerticalCPAPController new ]
		  ifHorizontal: [ MMHorizontalCPAPController new ]
]

{ #category : 'instance creation' }
MMClassDiagramRoassalBuilder >> newLabelForCardinality: aStringOrNil [

	^ aStringOrNil ifNotNil: [
			  RSLabel new
				  metricsProvider: RSPharoMetricsProvider new;
				  text: aStringOrNil;
				  fontSize: RSLabel defaultFontSize - 2;
				  color: Color darkGray;
				  yourself ]
]

{ #category : 'instance creation' }
MMClassDiagramRoassalBuilder >> newShapeForEdge: aMMClassDiagramEdge [

	| bezier |
	bezier := RSBezier new
		        model: aMMClassDiagramEdge;
		        color: Color black;
		        markerStart: (self newMarkerFor: aMMClassDiagramEdge head1);
		        markerEnd: (self newMarkerFor: aMMClassDiagramEdge head2);
		        yourself.
	aMMClassDiagramEdge linestyle = #dotted ifTrue: [ bezier dashed ].
	^ bezier
]

{ #category : 'instance creation' }
MMClassDiagramRoassalBuilder >> newShapeForNode: aMMClassDiagramNode [

	| classNameShapes attributeShapes methodShapes memberShapes rect y1 y2 |
	classNameShapes := Array streamContents: [ :stream |
			                   | label |
			                   aMMClassDiagramNode annotationsDo: [ :annotation |
					                   annotation ~= 'abstract' ifTrue: [
							                   stream nextPut: (RSLabel new
									                    text: '<<' , annotation , '>>';
									                    color: Color darkGray) ] ].
			                   label := RSLabel new
				                            text:
					                            (aMMClassDiagramNode label ifNil: [
							                             aMMClassDiagramNode name ]);
				                            color: Color black.
			                   (aMMClassDiagramNode includesAnnotation:
				                    'abstract') ifTrue: [ label italic ].
			                   label extent x < 100 ifTrue: [
				                   label extent: 100 @ label extent y ].
			                   stream nextPut: label ].
	RSVerticalLineLayout new
		alignCenter;
		on: classNameShapes.
	classNameShapes := classNameShapes asShapeFor: aMMClassDiagramNode.
	attributeShapes := aMMClassDiagramNode attributesCollect: [ :string |
			                   | text isAbstract isStatic label |
			                   text := string.
			                   (isAbstract := text includesSubstring:
				                                  '<<abstract>>') ifTrue: [
					                   | index |
					                   index := text indexOfSubCollection:
						                            '<<abstract>>'.
					                   text := ((text copyFrom: 1 to: index - 1)
					                            ,
					                            (text
						                             copyFrom:
						                             index + '<<abstract>>' size
						                             to: text size)) trim ].
			                   (isStatic := text includesSubstring:
				                                '<<static>>') ifTrue: [
					                   | index |
					                   index := text indexOfSubCollection:
						                            '<<static>>'.
					                   text := ((text copyFrom: 1 to: index - 1)
					                            ,
					                            (text
						                             copyFrom: index + '<<static>>' size
						                             to: text size)) trim ].
			                   label := RSLabel new
				                            text: text;
				                            color: Color darkGray.
			                   isAbstract ifTrue: [ label italic ].
			                   isStatic ifTrue: [ label underline ].
			                   label ].
	RSVerticalLineLayout new
		alignLeft;
		on: attributeShapes.
	attributeShapes := attributeShapes asShapeFor: aMMClassDiagramNode.
	methodShapes := aMMClassDiagramNode operationsCollect: [ :string |
			                | text isAbstract isStatic label |
			                text := string.
			                (isAbstract := text includesSubstring:
				                               '<<abstract>>') ifTrue: [
					                | index |
					                index := text indexOfSubCollection:
						                         '<<abstract>>'.
					                text := ((text copyFrom: 1 to: index - 1)
					                         ,
					                         (text
						                          copyFrom: index + '<<abstract>>' size
						                          to: text size)) trim ].
			                (isStatic := text includesSubstring: '<<static>>')
				                ifTrue: [
						                | index |
						                index := text indexOfSubCollection: '<<static>>'.
						                text := ((text copyFrom: 1 to: index - 1)
						                         ,
						                         (text
							                          copyFrom: index + '<<static>>' size
							                          to: text size)) trim ].
			                label := RSLabel new
				                         text: text;
				                         color: Color darkGray.
			                isAbstract ifTrue: [ label italic ].
			                isStatic ifTrue: [ label underline ].
			                label ].
	RSVerticalLineLayout new
		alignLeft;
		on: methodShapes.
	methodShapes := methodShapes asShapeFor: aMMClassDiagramNode.
	RSVerticalLineLayout new
		alignLeft;
		gapSize: 10;
		on: {
				attributeShapes.
				methodShapes }.
	memberShapes := {
		                attributeShapes.
		                methodShapes } asShapeFor: aMMClassDiagramNode.
	classNameShapes extent x < memberShapes extent x ifTrue: [
			classNameShapes extent:
				memberShapes extent x @ classNameShapes extent y ].
	RSVerticalLineLayout new
		alignLeft;
		gapSize: 10;
		on: {
				classNameShapes.
				memberShapes }.
	rect := {
		        classNameShapes.
		        memberShapes } asShape encompassingRectangle.
	y1 := classNameShapes encompassingRectangle bottom + 5.
	y2 := y1 + attributeShapes encompassingRectangle height + 10.

	^ {
		  (RSBox new
			   extent: rect extent + (10 @ 6);
			   color: Color white;
			   borderColor: Color black;
			   borderWidth: 1).
		  (RSLine new
			   startPoint: rect extent x / -2 - 5 @ y1;
			   endPoint: rect extent x / 2 + 5 @ y1).
		  (RSLine new
			   startPoint: rect extent x / -2 - 5 @ y2;
			   endPoint: rect extent x / 2 + 5 @ y2).
		  classNameShapes.
		  memberShapes } asShapeFor: aMMClassDiagramNode
]

{ #category : 'rendering' }
MMClassDiagramRoassalBuilder >> newTreeLayouter [

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

{ #category : 'rendering' }
MMClassDiagramRoassalBuilder >> renderLinksIn: aRSCanvas [

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
								controlPointsController: (self newCPAPController t: 0.5).
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
							aRSCanvas addShape: label ].
					(self newLabelForCardinality: bezier model cardinality1)
						ifNotNil: [ :label |
								label position:
									(self cardinalityLabelPositionFor: label in: bezier atT: 0.0).
								aRSCanvas addShape: label ].
					(self newLabelForCardinality: bezier model cardinality2)
						ifNotNil: [ :label |
								label position:
									(self cardinalityLabelPositionFor: label in: bezier atT: 1.0).
								aRSCanvas addShape: label ] ] ]
]

{ #category : 'accessing' }
MMClassDiagramRoassalBuilder >> treeEdges [

	| knownNodes |
	knownNodes := Set new: nodes size.
	^ Array streamContents: [ :stream |
			  ((edges select: [ :edge | edge treeEdgePriority notNil ])
				   asSortedCollection: #treeEdgePriority ascending) do: [ :edge |
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
