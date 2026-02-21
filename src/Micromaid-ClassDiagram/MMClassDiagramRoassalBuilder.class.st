Class {
	#name : 'MMClassDiagramRoassalBuilder',
	#superclass : 'MMRoassalBuilder',
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
	Array <.. Set : hash table
	Array <.. OrderedCollection : internal containter
	'.
	diagram roassalBuilder build
		zoomToFit;
		@ RSCanvasController;
		openWithTitle: self class name , ' class >>' , thisContext selector
]

{ #category : 'examples' }
MMClassDiagramRoassalBuilder class >> exampleCons [

	| diagram |
	diagram := MMClassDiagramParser new parse: 'classDiagram
	class Cons {
		car : Object
	}
	Cons *-- Cons : cdr'.
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

{ #category : 'accessing' }
MMClassDiagramRoassalBuilder >> horizontalMargin [

	^ 70
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
MMClassDiagramRoassalBuilder >> newCPController [

	^ MMClassDiagramCPController new
]

{ #category : 'instance creation' }
MMClassDiagramRoassalBuilder >> newCPControllerForInheritance [

	^ MMClassDiagramInheritanceCPController new
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
MMClassDiagramRoassalBuilder >> newMarkerFor: aSymbol [

	aSymbol = #inheritance ifTrue: [
			^ (RSPolygon new
				   points: {
						   (-12 @ 0).
						   (0 @ -12).
						   (12 @ 0) };
				   color: Color white;
				   borderColor: Color black;
				   borderWidth: 1;
				   asMarker) offset: -6 ].
	^ super newMarkerFor: aSymbol
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
MMClassDiagramRoassalBuilder >> renderClass: aMicroUMLClassNode left: left top: top subclasses: aDictionary in: aRSCanvas [

	| right bottom shape |
	right := left.
	bottom := top.
	shape := self newShapeForNode: aMicroUMLClassNode.
	shape translateBy: left @ top - shape encompassingRectangle topLeft
		+ (self horizontalMargin @ self verticalMargin).
	right := right max:
		         shape encompassingRectangle right + self horizontalMargin.
	bottom := bottom max:
		          shape encompassingRectangle bottom + self verticalMargin.
	aRSCanvas
		add: shape;
		addNode: shape.
	aDictionary
		at: aMicroUMLClassNode name
		ifPresent: [ :subclassNames |
				| subclassLeft |
				subclassLeft := left.
				subclassNames do: [ :subclassName |
						nodes at: subclassName ifPresent: [ :subclassNode |
								subclassLeft := self
									                renderClass: subclassNode
									                left: subclassLeft
									                top: bottom
									                subclasses: aDictionary
									                in: aRSCanvas ] ].
				right := right max: subclassLeft ].
	shape translateTo:
		left + right * 0.5 - (shape encompassingRectangle width * 0.5)
		@ shape encompassingRectangle center y.
	^ right
]

{ #category : 'rendering' }
MMClassDiagramRoassalBuilder >> renderClassesIn: aRSCanvas [

	| nonRoots subclasses left |
	nonRoots := Set new.
	subclasses := OrderedDictionary new.
	edges do: [ :edge |
			edge isInheritance ifTrue: [
					| superclassName subclassName |
					superclassName := edge node1.
					subclassName := edge node2.
					(subclasses
						 at: superclassName
						 ifAbsentPut: [ OrderedCollection new ]) add: subclassName.
					nonRoots add: subclassName ] ].

	left := 0.0.
	nodes keysDo: [ :className |
			(nonRoots includes: className) ifFalse: [
					nodes at: className ifPresent: [ :classNode |
							left := self
								        renderClass: classNode
								        left: left
								        top: 0.0
								        subclasses: subclasses
								        in: aRSCanvas ] ] ]
]

{ #category : 'rendering' }
MMClassDiagramRoassalBuilder >> renderIn: aRSCanvas [

	self renderClassesIn: aRSCanvas.
	self renderLinksIn: aRSCanvas
]

{ #category : 'rendering' }
MMClassDiagramRoassalBuilder >> renderLinksIn: aRSCanvas [

	edges do: [ :edge |
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
								from: from;
								to: to;
								controlPointsController: (edge isInheritance
										 ifTrue: [ self newCPControllerForInheritance ]
										 ifFalse: [ self newCPController ]).
							aRSCanvas add: line ] ] ].
	aRSCanvas edges do: [ :bezier |
			bezier model isMMEdge ifTrue: [
					(self newLabelForEdge: bezier model) ifNotNil: [ :label |
							label position: (bezier atT: 0.5).
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
MMClassDiagramRoassalBuilder >> verticalMargin [

	^ 30
]
