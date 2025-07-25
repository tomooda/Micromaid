Class {
	#name : 'MMClassDiagramEdge',
	#superclass : 'MMEdge',
	#category : 'Micromaid-ClassDiagram-AST',
	#package : 'Micromaid-ClassDiagram',
	#tag : 'AST'
}

{ #category : 'testing' }
MMClassDiagramEdge >> isTreeEdge [

	^ self subclassResponsibility
]
