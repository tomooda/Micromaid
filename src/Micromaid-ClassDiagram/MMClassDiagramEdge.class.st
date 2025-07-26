Class {
	#name : 'MMClassDiagramEdge',
	#superclass : 'MMEdge',
	#category : 'Micromaid-ClassDiagram-AST',
	#package : 'Micromaid-ClassDiagram',
	#tag : 'AST'
}

{ #category : 'accessing' }
MMClassDiagramEdge >> head1 [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
MMClassDiagramEdge >> head2 [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
MMClassDiagramEdge >> linestyle [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
MMClassDiagramEdge >> treeEdgePriority [
	"less number, higher priority. nil for never"

	^ self subclassResponsibility
]
