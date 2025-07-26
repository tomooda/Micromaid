Class {
	#name : 'MMClassDiagramEdge',
	#superclass : 'MMEdge',
	#instVars : [
		'cardinality1',
		'cardinality2'
	],
	#category : 'Micromaid-ClassDiagram-AST',
	#package : 'Micromaid-ClassDiagram',
	#tag : 'AST'
}

{ #category : 'accessing' }
MMClassDiagramEdge >> cardinality1 [

	^ cardinality1
]

{ #category : 'accessing' }
MMClassDiagramEdge >> cardinality1: aStringOrNil [

	cardinality1 := aStringOrNil
]

{ #category : 'accessing' }
MMClassDiagramEdge >> cardinality2 [

	^ cardinality2
]

{ #category : 'accessing' }
MMClassDiagramEdge >> cardinality2: aStringOrNil [

	cardinality2 := aStringOrNil
]

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
