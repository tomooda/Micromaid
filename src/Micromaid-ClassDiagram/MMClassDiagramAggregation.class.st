Class {
	#name : 'MMClassDiagramAggregation',
	#superclass : 'MMClassDiagramEdge',
	#category : 'Micromaid-ClassDiagram-AST',
	#package : 'Micromaid-ClassDiagram',
	#tag : 'AST'
}

{ #category : 'accessing' }
MMClassDiagramAggregation >> head1 [

	^ #composition
]

{ #category : 'accessing' }
MMClassDiagramAggregation >> head2 [

	^ #none
]

{ #category : 'accessing' }
MMClassDiagramAggregation >> linestyle [

	^ #solid
]

{ #category : 'testing' }
MMClassDiagramAggregation >> treeEdgePriority [

	^ 20
]
