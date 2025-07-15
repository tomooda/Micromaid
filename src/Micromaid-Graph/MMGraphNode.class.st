"
I am an AST node that represent a  node in various shapes and labels  in a Micromaid script.
"
Class {
	#name : 'MMGraphNode',
	#superclass : 'MMGraphSimpleNode',
	#instVars : [
		'label',
		'shape'
	],
	#category : 'Micromaid-Graph-AST',
	#package : 'Micromaid-Graph',
	#tag : 'AST'
}

{ #category : 'building' }
MMGraphNode >> applyToBuilder: aMMGraphBuilder [

	aMMGraphBuilder addNode: self
]

{ #category : 'initialization' }
MMGraphNode >> initialize [

	super initialize.
	shape := #rect
]

{ #category : 'accessing' }
MMGraphNode >> label [

	^ label
]

{ #category : 'accessing' }
MMGraphNode >> label: aString [

	label := aString
]

{ #category : 'accessing' }
MMGraphNode >> shape [

	^ shape
]

{ #category : 'accessing' }
MMGraphNode >> shape: aSymbol [

	shape := aSymbol
]
