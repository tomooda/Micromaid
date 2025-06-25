Class {
	#name : 'MMGraphNode',
	#superclass : 'Object',
	#instVars : [
		'name',
		'label',
		'shape'
	],
	#category : 'Micromaid-Graph',
	#package : 'Micromaid-Graph'
}

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
MMGraphNode >> name [

	^ name
]

{ #category : 'accessing' }
MMGraphNode >> name: aString [

	name := aString
]

{ #category : 'accessing' }
MMGraphNode >> shape [

	^ shape
]

{ #category : 'accessing' }
MMGraphNode >> shape: aSymbol [

	shape := aSymbol
]
