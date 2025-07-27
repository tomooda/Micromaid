Class {
	#name : 'MMClassDiagramClass',
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
MMClassDiagramClass >> annotations [

	^ annotations
]

{ #category : 'accessing' }
MMClassDiagramClass >> annotations: anArrayOfString [

	annotations := anArrayOfString asArray
]

{ #category : 'building' }
MMClassDiagramClass >> applyToBuilder: aMMRoassalBuilder [

	| node |
	node := aMMRoassalBuilder ensureClassNamed: name.
	label ifNotNil: [ node label: label ].
	annotations do: [ :annotation | node addAnnotation: annotation ]
]

{ #category : 'initialization' }
MMClassDiagramClass >> initialize [

	super initialize.
	annotations := Array new
]

{ #category : 'accessing' }
MMClassDiagramClass >> label [

	^ label
]

{ #category : 'accessing' }
MMClassDiagramClass >> label: aString [

	label := aString
]

{ #category : 'accessing' }
MMClassDiagramClass >> name [

	^ name
]

{ #category : 'accessing' }
MMClassDiagramClass >> name: aString [

	name := aString
]
