Class {
	#name : 'MMClassDiagramRoassalBuilder',
	#superclass : 'MMRoassalBuilder',
	#traits : 'MMTDagRoassalBuilder',
	#classTraits : 'MMTDagRoassalBuilder classTrait',
	#instVars : [
		'defaultClass',
		'enforcesOperation'
	],
	#category : 'Micromaid-ClassDiagram-Roassal',
	#package : 'Micromaid-ClassDiagram',
	#tag : 'Roassal'
}

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
MMClassDiagramRoassalBuilder >> beginClass: aString [

	self ensureClassNamed: aString.
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

{ #category : 'operations' }
MMClassDiagramRoassalBuilder >> endClass [

	self enforcesOperation: false.
	self defaultClass: nil
]

{ #category : 'testing' }
MMClassDiagramRoassalBuilder >> enforcesOperation [

	^ enforcesOperation
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
