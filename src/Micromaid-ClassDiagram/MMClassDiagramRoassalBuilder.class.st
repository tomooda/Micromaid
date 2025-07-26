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
MMClassDiagramRoassalBuilder class >> exampleClassDiagram [

	| diagram |
	diagram := MMClassDiagramParser new parse: 'classDiagram
	class Foo["My Foo"] <<abstract>>
	Foo : bar
	Foo : baaaaaar
	class Baz["My Baz"] { 
		<<concrete>>
		<<service>>
		%% methods
		char
		quuux
	}
	Foo <|-- Baz'.
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
	classNameShapes := (aMMClassDiagramNode annotationsCollect: [
		                    :annotation |
		                    Color darkGray -> ('<<' , annotation , '>>') ])
	                   , { (Color black
		                    ->
		                    (aMMClassDiagramNode label ifNil: [
			                     aMMClassDiagramNode name ])) } collect: [
			                   :assoc |
			                   | label |
			                   label := RSLabel new
				                            text: assoc value;
				                            color: assoc key.
			                   label extent x < 100 ifTrue: [
				                   label extent: 100 @ label extent y ].
			                   label ].
	RSVerticalLineLayout new
		alignCenter;
		on: classNameShapes.
	classNameShapes := classNameShapes asShapeFor: aMMClassDiagramNode.
	attributeShapes := aMMClassDiagramNode attributesCollect: [ :string |
			                   RSLabel new
				                   text: string;
				                   color: Color darkGray ].
	RSVerticalLineLayout new
		alignLeft;
		on: attributeShapes.
	attributeShapes := attributeShapes asShapeFor: aMMClassDiagramNode.
	methodShapes := aMMClassDiagramNode operationsCollect: [ :string |
			                RSLabel new
				                text: string;
				                color: Color darkGray ].
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

{ #category : 'accessing' }
MMClassDiagramRoassalBuilder >> treeEdges [

	| knownNodes |
	knownNodes := Set new: nodes size.

	^ Array streamContents: [ :stream |
			  ((edges select: [ :edge | edge treeEdgePriority notNil ])
				   asSortedCollection: #treeEdgePriority ascending) do: [ :edge |
					  | node2 |
					  node2 := edge node2.
					  (knownNodes includes: node2) ifFalse: [
							  knownNodes
								  add: edge node1;
								  add: node2.
							  stream nextPut: edge ] ] ]
]
