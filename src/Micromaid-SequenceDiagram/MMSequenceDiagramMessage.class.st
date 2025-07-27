Class {
	#name : 'MMSequenceDiagramMessage',
	#superclass : 'MMEdge',
	#instVars : [
		'linestyle',
		'head1',
		'head2'
	],
	#category : 'Micromaid-SequenceDiagram-AST',
	#package : 'Micromaid-SequenceDiagram',
	#tag : 'AST'
}

{ #category : 'accessing' }
MMSequenceDiagramMessage >> head1 [

	^ head1
]

{ #category : 'accessing' }
MMSequenceDiagramMessage >> head1: aSymbol [

	head1 := aSymbol asSymbol
]

{ #category : 'accessing' }
MMSequenceDiagramMessage >> head2 [

	^ head2
]

{ #category : 'accessing' }
MMSequenceDiagramMessage >> head2: aSymbol [

	head2 := aSymbol asSymbol
]

{ #category : 'initialization' }
MMSequenceDiagramMessage >> initialize [

	super initialize.
	head1 := #none.
	head2 := #arrowhead.
	linestyle := #solid.
	label := ''
]

{ #category : 'accessing' }
MMSequenceDiagramMessage >> linestyle [

	^ linestyle
]

{ #category : 'accessing' }
MMSequenceDiagramMessage >> linestyle: aSymbol [

	linestyle := aSymbol asSymbol
]
