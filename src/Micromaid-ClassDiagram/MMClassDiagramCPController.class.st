Class {
	#name : 'MMClassDiagramCPController',
	#superclass : 'RSAbstractCPController',
	#category : 'Micromaid-ClassDiagram-Roassal',
	#package : 'Micromaid-ClassDiagram',
	#tag : 'Roassal'
}

{ #category : 'public - hooks' }
MMClassDiagramCPController >> controlPointsFor: aLine [

	| x1 x2 x3 x4 y12 y34 |
	aLine to encompassingRectangle right
	< aLine from encompassingRectangle left
		ifTrue: [
				x1 := aLine from encompassingRectangle left.
				x2 := x1 - 80.0 ]
		ifFalse: [
				x1 := aLine from encompassingRectangle right.
				x2 := x1 + 80.0 ].
	aLine from encompassingRectangle right
	< aLine to encompassingRectangle left
		ifTrue: [
				x4 := aLine to encompassingRectangle left.
				x3 := x4 - 80.0 ]
		ifFalse: [
				x4 := aLine to encompassingRectangle right.
				x3 := x4 + 80.0 ].
	y12 := self startingYOf: aLine.
	y34 := self endingYOf: aLine.
	^ {
		  (x1 @ y12).
		  (x2 @ y12).
		  (x3 @ y34).
		  (x4 @ y34) }
]

{ #category : 'public - hooks' }
MMClassDiagramCPController >> endingYOf: aLine [

	| node lines i n |
	node := aLine to.
	lines := Array streamContents: [ :stream |
			         node connectedLines do: [ :line |
					         ((line model isKindOf: MMClassDiagramEdge) and: [
						          line model isInheritance not ]) ifTrue: [
							         line from == node ifTrue: [ stream nextPut: line ].
							         line to == node ifTrue: [ stream nextPut: line ] ] ] ].
	i := lines indexOf: aLine.
	n := lines size + 1.
	aLine from == aLine to ifTrue: [ i := i + 1 ].
	^ node encompassingRectangle height asFloat * i asFloat / n asFloat
	  + node encompassingRectangle top
]

{ #category : 'public - hooks' }
MMClassDiagramCPController >> startingYOf: aLine [

	| node lines i n |
	node := aLine from.
	lines := Array streamContents: [ :stream |
			         node connectedLines do: [ :line |
					         ((line model isKindOf: MMClassDiagramEdge) and: [
						          line model isInheritance not ]) ifTrue: [
							         line from == node ifTrue: [ stream nextPut: line ].
							         line to == node ifTrue: [ stream nextPut: line ] ] ] ].
	i := lines indexOf: aLine.
	n := lines size + 1.
	^ node encompassingRectangle height asFloat * i asFloat / n asFloat
	  + node encompassingRectangle top
]
