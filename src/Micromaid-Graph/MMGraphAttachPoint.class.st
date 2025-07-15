"
I am an attach point that binds a node and an edge.
The actual end point is computed based on the line between the both nodes and the shape of the node.
For example, if the node is a diamond shape, the endpoint will be on either edge of the diamond.
This class is necessary because the border attachment in the Roassal library places the end point on the encompassing rectangle rather than the shape itself.

"
Class {
	#name : 'MMGraphAttachPoint',
	#superclass : 'RSBorderAttachPoint',
	#category : 'Micromaid-Graph-Roassal',
	#package : 'Micromaid-Graph',
	#tag : 'Roassal'
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
		  aSource encompassingRectangle center ]
]

{ #category : 'public - hooks' }
MMGraphAttachPoint >> geometriesFor: aRSShape edge: aLine do: aBlock [

	aRSShape isComposite
		ifTrue: [
				aRSShape children do: [ :shape |
					self geometriesFor: shape edge: aLine do: aBlock ] ]
		ifFalse: [
				(aRSShape isKindOf: RSBoundingShape) ifTrue: [
					aBlock value: (self geometryFor: aRSShape edge: aLine) ] ]
]
