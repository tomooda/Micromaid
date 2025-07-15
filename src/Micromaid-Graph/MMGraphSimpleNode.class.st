"
I am an AST node that represent a simple node, which consists of just an ID,  in a Micromaid script.
"
Class {
	#name : 'MMGraphSimpleNode',
	#superclass : 'MMSimpleNode',
	#category : 'Micromaid-Graph-AST',
	#package : 'Micromaid-Graph',
	#tag : 'AST'
}

{ #category : 'accessing' }
MMGraphSimpleNode >> shape [

	^ #rect
]
