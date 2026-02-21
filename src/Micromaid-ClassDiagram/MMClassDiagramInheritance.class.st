Class {
	#name : 'MMClassDiagramInheritance',
	#superclass : 'MMClassDiagramEdge',
	#category : 'Micromaid-ClassDiagram-AST',
	#package : 'Micromaid-ClassDiagram',
	#tag : 'AST'
}

{ #category : 'accessing' }
MMClassDiagramInheritance >> head1 [

	^ #inheritance
]

{ #category : 'accessing' }
MMClassDiagramInheritance >> head2 [

	^ #none
]

{ #category : 'testing' }
MMClassDiagramInheritance >> isInheritance [

	^ true
]

{ #category : 'accessing' }
MMClassDiagramInheritance >> linestyle [

	^ #solid
]

{ #category : 'testing' }
MMClassDiagramInheritance >> treeEdgePriority [

	^ 0
]
