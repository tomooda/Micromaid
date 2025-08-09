Class {
	#name : 'MMClassDiagramInverseEdge',
	#superclass : 'MMClassDiagramEdge',
	#instVars : [
		'baseEdge'
	],
	#category : 'Micromaid-ClassDiagram-Tests',
	#package : 'Micromaid-ClassDiagram',
	#tag : 'Tests'
}

{ #category : 'accessing' }
MMClassDiagramInverseEdge >> baseEdge [

	^ baseEdge
]

{ #category : 'accessing' }
MMClassDiagramInverseEdge >> baseEdge: aMMClassDiagramEdge [

	baseEdge := aMMClassDiagramEdge.
	label := aMMClassDiagramEdge label.
	node1 := aMMClassDiagramEdge node2.
	node2 := aMMClassDiagramEdge node1.
	cardinality1 := aMMClassDiagramEdge cardinality2.
	cardinality2 := aMMClassDiagramEdge cardinality1
]

{ #category : 'accessing' }
MMClassDiagramInverseEdge >> head1 [

	^ baseEdge head2
]

{ #category : 'accessing' }
MMClassDiagramInverseEdge >> head2 [

	^ baseEdge head1
]

{ #category : 'accessing' }
MMClassDiagramInverseEdge >> linestyle [

	^ baseEdge linestyle
]

{ #category : 'accessing' }
MMClassDiagramInverseEdge >> treeEdgePriority [

	^ baseEdge treeEdgePriority
]
