Extension { #name : 'GEllipse' }

{ #category : '*Micromaid-Graph' }
GEllipse >> rsScaleWith: anAthensAffineTransform [
	| m |
	m := anAthensAffineTransform.
	^ self class
		center: (m transform: center)
		vertex: (m transform: vertex)
		coVertex: (m transform: coVertex)
]
