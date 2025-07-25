Class {
	#name : 'MMEntity',
	#superclass : 'Object',
	#category : 'Micromaid-Base-AST',
	#package : 'Micromaid-Base',
	#tag : 'AST'
}

{ #category : 'building' }
MMEntity >> applyToBuilder: aMMRoassalBuilder [

	^ self subclassResponsibility
]
