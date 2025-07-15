Class {
	#name : 'MMGraphVerticalCPAPController',
	#superclass : 'MMGraphCPAPController',
	#category : 'Micromaid-Graph-Roassal',
	#package : 'Micromaid-Graph',
	#tag : 'Roassal'
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
