Class {
	#name : 'MMVerticalCPAPController',
	#superclass : 'MMCPAPController',
	#category : 'Micromaid-Base-Roassal',
	#package : 'Micromaid-Base',
	#tag : 'Roassal'
}

{ #category : 'hooks' }
MMVerticalCPAPController >> controlPointsFrom: from to: to [

	| mid |
	mid := from * (1 - self t) + (to * self t).
	^ Array
		  with: from
		  with: from x @ mid y
		  with: to x @ mid y
		  with: to
]
