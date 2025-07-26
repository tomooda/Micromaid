"
I am an abstract class that represents an AST node for node reference in Micromaid scripts.

I implement the `applyToBuilder:` method that adds myself to a roassal builder as a node if there's no other node with the same name in the builder.
Micromaid script often references node names before their details are defined.
If the builder already has a node with the same name, I will do nothing.
"
Class {
	#name : 'MMSimpleNode',
	#superclass : 'MMEntity',
	#instVars : [
		'name'
	],
	#category : 'Micromaid-Base-AST',
	#package : 'Micromaid-Base',
	#tag : 'AST'
}

{ #category : 'testing' }
MMSimpleNode class >> isAbstract [

	^ self = MMSimpleNode
]

{ #category : 'building' }
MMSimpleNode >> applyToBuilder: aMMRoassalBuilder [

	aMMRoassalBuilder addSimpleNode: self
]

{ #category : 'testing' }
MMSimpleNode >> isMMNode [

	^ true
]

{ #category : 'accessing' }
MMSimpleNode >> label [

	^ name
]

{ #category : 'accessing' }
MMSimpleNode >> name [

	^ name
]

{ #category : 'accessing' }
MMSimpleNode >> name: aString [

	name := aString
]
