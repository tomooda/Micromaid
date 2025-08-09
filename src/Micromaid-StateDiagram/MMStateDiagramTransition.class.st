Class {
	#name : 'MMStateDiagramTransition',
	#superclass : 'MMEdge',
	#instVars : [
		'head1',
		'head2'
	],
	#category : 'Micromaid-StateDiagram-AST',
	#package : 'Micromaid-StateDiagram',
	#tag : 'AST'
}

{ #category : 'accessing' }
MMStateDiagramTransition >> head1 [

	^ head1
]

{ #category : 'accessing' }
MMStateDiagramTransition >> head1: aSymbolOrNil [

	head1 := aSymbolOrNil
]

{ #category : 'accessing' }
MMStateDiagramTransition >> head2 [

	^ head2
]

{ #category : 'accessing' }
MMStateDiagramTransition >> head2: aSymbolOrNil [

	head2 := aSymbolOrNil
]

{ #category : 'initialization' }
MMStateDiagramTransition >> initialize [

	super initialize.
	head2 := #arrowhead
]

{ #category : 'accessing' }
MMStateDiagramTransition >> inversed [

	^ self copy
		  node1: node2;
		  node2: node1;
		  head1: head2;
		  head2: head1;
		  yourself
]
