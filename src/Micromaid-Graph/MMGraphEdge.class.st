"
I am an AST node that represent an edge in a Micromaid script.
"
Class {
	#name : 'MMGraphEdge',
	#superclass : 'MMEdge',
	#instVars : [
		'head1',
		'head2',
		'line',
		'length'
	],
	#category : 'Micromaid-Graph-AST',
	#package : 'Micromaid-Graph',
	#tag : 'AST'
}

{ #category : 'accessing' }
MMGraphEdge >> head1 [

	^ head1
]

{ #category : 'accessing' }
MMGraphEdge >> head1: aSymbol [

	head1 := aSymbol
]

{ #category : 'accessing' }
MMGraphEdge >> head2 [

	^ head2
]

{ #category : 'accessing' }
MMGraphEdge >> head2: aSymbol [

	head2 := aSymbol
]

{ #category : 'initialization' }
MMGraphEdge >> initialize [

	super initialize.
	line := #normal.
	head1 := #none.
	head2 := #none
]

{ #category : 'accessing' }
MMGraphEdge >> length [

	^ length
]

{ #category : 'accessing' }
MMGraphEdge >> length: anInteger [

	length := anInteger
]

{ #category : 'accessing' }
MMGraphEdge >> line [

	^ line
]

{ #category : 'accessing' }
MMGraphEdge >> line: aSymbol [

	line := aSymbol
]
