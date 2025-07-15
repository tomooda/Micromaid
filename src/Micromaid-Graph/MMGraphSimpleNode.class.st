"
I am an AST node that represent a simple node, which consists of just an ID,  in a Micromaid script.
"
Class {
	#name : 'MMGraphSimpleNode',
	#superclass : 'MMNode',
	#instVars : [
		'name'
	],
	#category : 'Micromaid-Graph-AST',
	#package : 'Micromaid-Graph',
	#tag : 'AST'
}

{ #category : 'building' }
MMGraphSimpleNode >> applyToBuilder: aMMGraphBuilder [

	aMMGraphBuilder addSimpleNode: self
]

{ #category : 'accessing' }
MMGraphSimpleNode >> label [

	^ name
]

{ #category : 'accessing' }
MMGraphSimpleNode >> name [

	^ name
]

{ #category : 'accessing' }
MMGraphSimpleNode >> name: aString [

	name := aString
]

{ #category : 'accessing' }
MMGraphSimpleNode >> shape [

	^ #rect
]
