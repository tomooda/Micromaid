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
MMSimpleNode >> applyToBuilder: aMMGraphBuilder [

	aMMGraphBuilder addSimpleNode: self
]

{ #category : 'testing' }
MMSimpleNode >> isMMNode [

	^ true
]

{ #category : 'testing' }
MMSimpleNode >> isStartState [

	^ false
]

{ #category : 'testing' }
MMSimpleNode >> isStopState [

	^ false
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
