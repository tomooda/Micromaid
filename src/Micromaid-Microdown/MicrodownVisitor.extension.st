Extension { #name : 'MicrodownVisitor' }

{ #category : '*Micromaid-Microdown' }
MicrodownVisitor >> visitMicromaidScript: aSlide [

	^ aSlide children collect: [ :each | self visit: each ]
]
