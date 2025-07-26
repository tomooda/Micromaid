Class {
	#name : 'MMClassDiagramSolidLink',
	#superclass : 'MMClassDiagramEdge',
	#category : 'Micromaid-ClassDiagram-AST',
	#package : 'Micromaid-ClassDiagram',
	#tag : 'AST'
}

{ #category : 'building' }
MMClassDiagramSolidLink >> applyToBuilder: aMMClassDiagramRoassalBuilder [

	aMMClassDiagramRoassalBuilder ensureClassNamed: node1.
	aMMClassDiagramRoassalBuilder ensureClassNamed: node2.
	super applyToBuilder: aMMClassDiagramRoassalBuilder
]

{ #category : 'accessing' }
MMClassDiagramSolidLink >> head1 [

	^ #none
]

{ #category : 'accessing' }
MMClassDiagramSolidLink >> head2 [

	^ #none
]

{ #category : 'accessing' }
MMClassDiagramSolidLink >> linestyle [

	^ #solid
]

{ #category : 'testing' }
MMClassDiagramSolidLink >> treeEdgePriority [

	^ 40
]
