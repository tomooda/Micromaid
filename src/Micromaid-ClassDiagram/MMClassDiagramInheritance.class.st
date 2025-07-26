Class {
	#name : 'MMClassDiagramInheritance',
	#superclass : 'MMClassDiagramEdge',
	#category : 'Micromaid-ClassDiagram-AST',
	#package : 'Micromaid-ClassDiagram',
	#tag : 'AST'
}

{ #category : 'building' }
MMClassDiagramInheritance >> applyToBuilder: aMMClassDiagramRoassalBuilder [

	aMMClassDiagramRoassalBuilder ensureClassNamed: node1.
	aMMClassDiagramRoassalBuilder ensureClassNamed: node2.
	super applyToBuilder: aMMClassDiagramRoassalBuilder
]

{ #category : 'accessing' }
MMClassDiagramInheritance >> head1 [

	^ #inheritance
]

{ #category : 'accessing' }
MMClassDiagramInheritance >> head2 [

	^ #none
]

{ #category : 'accessing' }
MMClassDiagramInheritance >> linestyle [

	^ #solid
]

{ #category : 'testing' }
MMClassDiagramInheritance >> treeEdgePriority [

	^ 0
]
