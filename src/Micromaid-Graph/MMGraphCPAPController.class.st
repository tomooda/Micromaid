Class {
	#name : 'MMGraphCPAPController',
	#superclass : 'RSAbstractCPAPController',
	#instVars : [
		't'
	],
	#category : 'Micromaid-Graph',
	#package : 'Micromaid-Graph'
}

{ #category : 'accessing' }
MMGraphCPAPController >> labelT [

	^ t = (1 / 2)
		  ifTrue: [ 1 / 2 ]
		  ifFalse: [
				  t > (1 / 2)
					  ifTrue: [ (4 * t) reciprocal ]
					  ifFalse: [ 1 - (4 * (1 - t)) reciprocal ] ]
]

{ #category : 'accessing' }
MMGraphCPAPController >> t [

	^ t ifNil: [ 1 / 2 ]
]

{ #category : 'accessing' }
MMGraphCPAPController >> t: aNumber [

	t := aNumber
]
