"
I am an AST node that represent a simple node, which consists of just an ID,  in a Micromaid script.
"
Class {
	#name : 'MMGraphSimpleNode',
	#superclass : 'Object',
	#traits : 'TMMGraphEntity',
	#classTraits : 'TMMGraphEntity classTrait',
	#instVars : [
		'name'
	],
	#category : 'Micromaid-Graph',
	#package : 'Micromaid-Graph'
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

{ #category : 'class access' }
MMGraphSimpleNode >> notificationClass [

	^ MMGraphParserNodeNotification
]

{ #category : 'accessing' }
MMGraphSimpleNode >> shape [

	^ #rect
]
