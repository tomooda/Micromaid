Class {
	#name : 'MMClassDiagramRealization',
	#superclass : 'MMClassDiagramEdge',
	#category : 'Micromaid-ClassDiagram-AST',
	#package : 'Micromaid-ClassDiagram',
	#tag : 'AST'
}

{ #category : 'building' }
MMClassDiagramRealization >> applyToBuilder: aMMClassDiagramRoassalBuilder [

	aMMClassDiagramRoassalBuilder ensureClassNamed: node1.
	aMMClassDiagramRoassalBuilder ensureClassNamed: node2.
	super applyToBuilder: aMMClassDiagramRoassalBuilder
]

{ #category : 'accessing' }
MMClassDiagramRealization >> head1 [

	^ #inheritance
]

{ #category : 'accessing' }
MMClassDiagramRealization >> head2 [

	^ #none
]

{ #category : 'accessing' }
MMClassDiagramRealization >> linestyle [

	^ #dotted
]

{ #category : 'testing' }
MMClassDiagramRealization >> treeEdgePriority [

	^ 50
]
