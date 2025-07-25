Class {
	#name : 'MMClassDiagramBeginClass',
	#superclass : 'MMEntity',
	#instVars : [
		'name',
		'label',
		'annotations'
	],
	#category : 'Micromaid-ClassDiagram-AST',
	#package : 'Micromaid-ClassDiagram',
	#tag : 'AST'
}

{ #category : 'accessing' }
MMClassDiagramBeginClass >> annotations [

	^ annotations
]

{ #category : 'accessing' }
MMClassDiagramBeginClass >> annotations: anArrayOfString [

	annotations := anArrayOfString asArray
]

{ #category : 'building' }
MMClassDiagramBeginClass >> applyToBuilder: aMMClassDiagramRoassalBuilder [

	aMMClassDiagramRoassalBuilder beginClass: name
]

{ #category : 'accessing' }
MMClassDiagramBeginClass >> label [

	^ label
]

{ #category : 'accessing' }
MMClassDiagramBeginClass >> label: aString [

	label := aString
]

{ #category : 'accessing' }
MMClassDiagramBeginClass >> name [

	^ name
]

{ #category : 'accessing' }
MMClassDiagramBeginClass >> name: aString [

	name := aString
]
