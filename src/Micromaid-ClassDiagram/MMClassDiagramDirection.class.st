Class {
	#name : 'MMClassDiagramDirection',
	#superclass : 'MMEntity',
	#instVars : [
		'direction'
	],
	#category : 'Micromaid-ClassDiagram-AST',
	#package : 'Micromaid-ClassDiagram',
	#tag : 'AST'
}

{ #category : 'building' }
MMClassDiagramDirection >> applyToBuilder: aMMClassDiagramRoassalBuilder [

	aMMClassDiagramRoassalBuilder direction: direction
]

{ #category : 'accessing' }
MMClassDiagramDirection >> direction [

	^ direction
]

{ #category : 'accessing' }
MMClassDiagramDirection >> direction: aSymbol [

	direction := aSymbol
]
