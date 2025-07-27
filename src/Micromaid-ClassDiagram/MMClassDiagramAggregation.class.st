Class {
	#name : 'MMClassDiagramAggregation',
	#superclass : 'MMClassDiagramEdge',
	#category : 'Micromaid-ClassDiagram-AST',
	#package : 'Micromaid-ClassDiagram',
	#tag : 'AST'
}

{ #category : 'building' }
MMClassDiagramAggregation >> applyToBuilder: aMMClassDiagramRoassalBuilder [

	aMMClassDiagramRoassalBuilder ensureClassNamed: node1.
	aMMClassDiagramRoassalBuilder ensureClassNamed: node2.
	super applyToBuilder: aMMClassDiagramRoassalBuilder
]

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
