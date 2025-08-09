Class {
	#name : 'MMClassDiagramSolidLink',
	#superclass : 'MMClassDiagramEdge',
	#category : 'Micromaid-ClassDiagram-AST',
	#package : 'Micromaid-ClassDiagram',
	#tag : 'AST'
}

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
