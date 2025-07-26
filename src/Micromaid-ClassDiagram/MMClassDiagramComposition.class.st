Class {
	#name : 'MMClassDiagramComposition',
	#superclass : 'MMClassDiagramEdge',
	#category : 'Micromaid-ClassDiagram-AST',
	#package : 'Micromaid-ClassDiagram',
	#tag : 'AST'
}

{ #category : 'building' }
MMClassDiagramComposition >> applyToBuilder: aMMClassDiagramRoassalBuilder [

	aMMClassDiagramRoassalBuilder ensureClassNamed: node1.
	aMMClassDiagramRoassalBuilder ensureClassNamed: node2.
	super applyToBuilder: aMMClassDiagramRoassalBuilder
]

{ #category : 'accessing' }
MMClassDiagramComposition >> head1 [

	^ #aggregation
]

{ #category : 'accessing' }
MMClassDiagramComposition >> head2 [

	^ #none
]

{ #category : 'accessing' }
MMClassDiagramComposition >> linestyle [

	^ #solid
]

{ #category : 'testing' }
MMClassDiagramComposition >> treeEdgePriority [

	^ 10
]
