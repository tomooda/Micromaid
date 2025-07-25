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

{ #category : 'testing' }
MMClassDiagramInheritance >> isTreeEdge [

	^ true
]
