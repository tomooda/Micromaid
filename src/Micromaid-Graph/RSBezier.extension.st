Extension { #name : 'RSBezier' }

{ #category : '*Micromaid-Graph' }
RSBezier >> atT: aNumber [

	| c b a via1 via2 start end cp |
	cp := controlPoints.
	cp size < 3 ifTrue: [ ^ nil ].
	start := cp first.
	via1 := cp second.
	via2 := cp third.
	end := cp size = 3
		       ifTrue: [ via2 ]
		       ifFalse: [ cp fourth ].
	c := 3 * (via1 - start).
	b := 3 * (via2 - via1) - c.
	a := end - start - c - b.

	^ a * (aNumber raisedTo: 3) + (b * (aNumber * aNumber))
	  + (c * aNumber) + start
]
