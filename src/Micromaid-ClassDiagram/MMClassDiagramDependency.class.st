Class {
	#name : 'MMClassDiagramDependency',
	#superclass : 'MMClassDiagramEdge',
	#category : 'Micromaid-ClassDiagram-AST',
	#package : 'Micromaid-ClassDiagram',
	#tag : 'AST'
}

{ #category : 'accessing' }
MMClassDiagramDependency >> head1 [

	^ #wedgehead
]

{ #category : 'accessing' }
MMClassDiagramDependency >> head2 [

	^ #none
]

{ #category : 'accessing' }
MMClassDiagramDependency >> linestyle [

	^ #dotted
]

{ #category : 'testing' }
MMClassDiagramDependency >> treeEdgePriority [

	^ 60
]
