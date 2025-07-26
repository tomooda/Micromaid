Class {
	#name : 'MMClassDiagramDashedLink',
	#superclass : 'MMClassDiagramEdge',
	#category : 'Micromaid-ClassDiagram-AST',
	#package : 'Micromaid-ClassDiagram',
	#tag : 'AST'
}

{ #category : 'building' }
MMClassDiagramDashedLink >> applyToBuilder: aMMClassDiagramRoassalBuilder [

	aMMClassDiagramRoassalBuilder ensureClassNamed: node1.
	aMMClassDiagramRoassalBuilder ensureClassNamed: node2.
	super applyToBuilder: aMMClassDiagramRoassalBuilder
]

{ #category : 'accessing' }
MMClassDiagramDashedLink >> head1 [

	^ #none
]

{ #category : 'accessing' }
MMClassDiagramDashedLink >> head2 [

	^ #none
]

{ #category : 'accessing' }
MMClassDiagramDashedLink >> linestyle [

	^ #dotted
]

{ #category : 'testing' }
MMClassDiagramDashedLink >> treeEdgePriority [

	^ 60
]
