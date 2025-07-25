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
