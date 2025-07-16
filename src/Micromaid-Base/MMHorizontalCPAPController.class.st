Class {
	#name : 'MMHorizontalCPAPController',
	#superclass : 'MMCPAPController',
	#category : 'Micromaid-Base-Roassal',
	#package : 'Micromaid-Base',
	#tag : 'Roassal'
}

{ #category : 'hooks' }
MMHorizontalCPAPController >> controlPointsFrom: from to: to [

	| mid |
	mid := from * (1 - self t) + (to * self t).
	^ Array
		  with: from
		  with: mid x @ from y
		  with: mid x @ to y
		  with: to
]
