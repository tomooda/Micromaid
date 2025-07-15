Class {
	#name : 'MMGraphHorizontalCPAPController',
	#superclass : 'MMGraphCPAPController',
	#category : 'Micromaid-Graph-Roassal',
	#package : 'Micromaid-Graph',
	#tag : 'Roassal'
}

{ #category : 'hooks' }
MMGraphHorizontalCPAPController >> controlPointsFrom: from to: to [

	| mid |
	mid := from * (1 - self t) + (to * self t).
	^ Array
		  with: from
		  with: mid x @ from y
		  with: mid x @ to y
		  with: to
]
