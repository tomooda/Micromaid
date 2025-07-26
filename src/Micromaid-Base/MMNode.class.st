"
I am an abstract class that represents an AST node for node definition in Micromaid scripts.

I implement the `applyToBuilder:` method that adds myself to a roassal builder as a node.
Micromaid script often references node names before their details are defined.
If the builder already has a node with the same name, I will overwrite them because I represent the detailed definition.
"
Class {
	#name : 'MMNode',
	#superclass : 'MMEntity',
	#instVars : [
		'label',
		'name'
	],
	#category : 'Micromaid-Base-AST',
	#package : 'Micromaid-Base',
	#tag : 'AST'
}

{ #category : 'testing' }
MMNode class >> isAbstract [

	^ self = MMNode
]

{ #category : 'building' }
MMNode >> applyToBuilder: aMMRoassalBuilder [

	aMMRoassalBuilder addNode: self
]

{ #category : 'testing' }
MMNode >> isMMNode [

	^ true
]

{ #category : 'accessing' }
MMNode >> label [

	^ label
]

{ #category : 'accessing' }
MMNode >> label: aString [

	label := aString
]

{ #category : 'accessing' }
MMNode >> name [

	^ name
]

{ #category : 'accessing' }
MMNode >> name: aString [

	name := aString
]
