Class {
	#name : 'MMClassDiagramRealization',
	#superclass : 'MMClassDiagramEdge',
	#category : 'Micromaid-ClassDiagram-AST',
	#package : 'Micromaid-ClassDiagram',
	#tag : 'AST'
}

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
