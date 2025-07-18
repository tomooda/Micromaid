"
I am an AST node that represent a  node in various shapes and labels  in a Micromaid script.
"
Class {
	#name : 'MMGraphNode',
	#superclass : 'MMNode',
	#instVars : [
		'shape'
	],
	#category : 'Micromaid-Graph-AST',
	#package : 'Micromaid-Graph',
	#tag : 'AST'
}

{ #category : 'initialization' }
MMGraphNode >> initialize [

	super initialize.
	shape := #rect
]

{ #category : 'accessing' }
MMGraphNode >> shape [

	^ shape
]

{ #category : 'accessing' }
MMGraphNode >> shape: aSymbol [

	shape := aSymbol
]
