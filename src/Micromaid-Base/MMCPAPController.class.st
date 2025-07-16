"
I provide control points of bezier curve so that the crank can be ajustable by the *t* parameter.
"
Class {
	#name : 'MMCPAPController',
	#superclass : 'RSAbstractCPAPController',
	#instVars : [
		't'
	],
	#category : 'Micromaid-Base-Roassal',
	#package : 'Micromaid-Base',
	#tag : 'Roassal'
}

{ #category : 'testing' }
MMCPAPController class >> isAbstract [

	^ self = MMCPAPController
]

{ #category : 'accessing' }
MMCPAPController >> labelT [

	^ t = (1 / 2)
		  ifTrue: [ 1 / 2 ]
		  ifFalse: [
				  t > (1 / 2)
					  ifTrue: [ (4 * t) reciprocal ]
					  ifFalse: [ 1 - (4 * (1 - t)) reciprocal ] ]
]

{ #category : 'accessing' }
MMCPAPController >> t [

	^ t ifNil: [ 1 / 2 ]
]

{ #category : 'accessing' }
MMCPAPController >> t: aNumber [

	t := aNumber
]
