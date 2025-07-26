Class {
	#name : 'MMClassDiagramAssociation',
	#superclass : 'MMClassDiagramEdge',
	#category : 'Micromaid-ClassDiagram-AST',
	#package : 'Micromaid-ClassDiagram',
	#tag : 'AST'
}

{ #category : 'building' }
MMClassDiagramAssociation >> applyToBuilder: aMMClassDiagramRoassalBuilder [

	aMMClassDiagramRoassalBuilder ensureClassNamed: node1.
	aMMClassDiagramRoassalBuilder ensureClassNamed: node2.
	super applyToBuilder: aMMClassDiagramRoassalBuilder
]

{ #category : 'accessing' }
MMClassDiagramAssociation >> head1 [

	^ #wedgehead
]

{ #category : 'accessing' }
MMClassDiagramAssociation >> head2 [

	^ #none
]

{ #category : 'accessing' }
MMClassDiagramAssociation >> linestyle [

	^ #solid
]

{ #category : 'testing' }
MMClassDiagramAssociation >> treeEdgePriority [

	^ 30
]
