Class {
	#name : 'MMClassDiagramDashedLink',
	#superclass : 'MMClassDiagramEdge',
	#category : 'Micromaid-ClassDiagram-AST',
	#package : 'Micromaid-ClassDiagram',
	#tag : 'AST'
}

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
