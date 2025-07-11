Class {
	#name : 'MMGraphVerticalCPAPController',
	#superclass : 'MMGraphCPAPController',
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
