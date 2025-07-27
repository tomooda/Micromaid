Class {
	#name : 'MMClassDiagramAnnotation',
	#superclass : 'MMEntity',
	#instVars : [
		'annotation'
	],
	#category : 'Micromaid-ClassDiagram-AST',
	#package : 'Micromaid-ClassDiagram',
	#tag : 'AST'
}

{ #category : 'accessing' }
MMClassDiagramAnnotation >> annotation [

	^ annotation
]

{ #category : 'accessing' }
MMClassDiagramAnnotation >> annotation: aString [

	annotation := aString
]

{ #category : 'building' }
MMClassDiagramAnnotation >> applyToBuilder: aMMRoassalBuilder [

	aMMRoassalBuilder addAnnotation: annotation
]
