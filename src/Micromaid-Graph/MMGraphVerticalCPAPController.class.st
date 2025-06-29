Class {
	#name : 'MMGraphVerticalCPAPController',
	#superclass : 'RSAbstractCPAPController',
	#instVars : [
		't'
	],
	#category : 'Micromaid-Graph',
	#package : 'Micromaid-Graph'
}

{ #category : 'hooks' }
MMGraphVerticalCPAPController >> controlPointsFrom: from to: to [

	| mid |
	mid := from * (1 - self t) + (to * self t).
	^ Array
		  with: from
		  with: from x @ mid y
		  with: to x @ mid y
		  with: to
]

{ #category : 'accessing' }
MMGraphVerticalCPAPController >> labelT [

	^ t = (1 / 2)
		  ifTrue: [ 1 / 2 ]
		  ifFalse: [
				  t > (1 / 2)
					  ifTrue: [ (4 * t) reciprocal ]
					  ifFalse: [ 1 - (4 * (1 - t)) reciprocal ] ]
]

{ #category : 'accessing' }
MMGraphVerticalCPAPController >> t [

	^ t ifNil: [ 1 / 2 ]
]

{ #category : 'accessing' }
MMGraphVerticalCPAPController >> t: aNumber [

	t := aNumber
]
