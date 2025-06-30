Class {
	#name : 'MMGraphAttachPoint',
	#superclass : 'RSBorderAttachPoint',
	#category : 'Micromaid-Graph',
	#package : 'Micromaid-Graph'
}

{ #category : 'public - hooks' }
MMGraphAttachPoint >> basicPointFrom: fromShape to: toShape of: aLine offset: aNumber [
	| source target line shift res vector unit |
	source := self geometryFor: fromShape edge: aLine.
	target := self geometryFor: toShape edge: aLine.
	shift := self offsetNormalFor: aLine.
	line := GLine through: source center and: target center.
	vector := line v2 asPoint - line v1 asPoint.
	vector := vector x @ vector y.
	unit := vector / (vector r max: 1).
	shift := vector normal * shift.
	aLine from = toShape
		ifTrue: [ shift := shift * -1 ].
	line := GLine
		through: source center asPoint + shift
		and: target center asPoint + shift.
	res := self borderPointFrom: fromShape to: target via: line edge: aLine.
	^ res asPoint + (unit * aNumber)
]

{ #category : 'public - hooks' }
MMGraphAttachPoint >> borderPointFrom: aSource to: aTarget via: line edge: aLine [

	^ ((Array streamContents: [ :stream |
			    self
				    geometriesFor: aSource
				    edge: aLine
				    do: [ :geometry |
				    stream nextPutAll: (line intersectionsWith: geometry) ] ])
		   detectMin: [ :p | p asPoint distanceTo: line v2 ]) ifNil: [
		  aSource center ]
]

{ #category : 'public - hooks' }
MMGraphAttachPoint >> geometriesFor: aRSShape edge: aLine do: aBlock [

	aRSShape isComposite
		ifTrue: [
				aRSShape children do: [ :shape |
					self geometriesFor: shape edge: aLine do: aBlock ] ]
		ifFalse: [ aBlock value: (self geometryFor: aRSShape edge: aLine) ]
]
