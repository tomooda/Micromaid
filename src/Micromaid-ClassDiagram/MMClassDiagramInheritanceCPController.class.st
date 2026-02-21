Class {
	#name : 'MMClassDiagramInheritanceCPController',
	#superclass : 'RSAbstractCPController',
	#category : 'Micromaid-ClassDiagram-Roassal',
	#package : 'Micromaid-ClassDiagram',
	#tag : 'Roassal'
}

{ #category : 'hooks' }
MMClassDiagramInheritanceCPController >> controlPointsFor: aLine [

	| from to |
	from := self startingPointOf: aLine.
	to := self endingPointOf: aLine.
	^ Array
		  with: from + (0.0 @ 12.0)
		  with: from + (0.0 @ 52.0)
		  with: to - (0.0 @ 40.0)
		  with: to
]

{ #category : 'public - hooks' }
MMClassDiagramInheritanceCPController >> endingPointOf: aLine [

	| node incomingLines i n |
	node := aLine to.
	incomingLines := node incomingLines select: [ :line |
			                 (line model isKindOf: MMClassDiagramEdge) and: [
				                 line model isInheritance ] ].
	i := incomingLines indexOf: aLine.
	n := incomingLines size + 1.
	^ node encompassingRectangle topLeft
	  +
		  (node encompassingRectangle width asFloat * i asFloat / n asFloat
		   @ 0.0)
]

{ #category : 'public - hooks' }
MMClassDiagramInheritanceCPController >> startingPointOf: aLine [

	"| node outgoingLines i n |
	node := aLine from.
	outgoingLines := node outgoingLines select: [ :line |
			                 (line model isKindOf: MMClassDiagramEdge) and: [
				                 line model isInheritance ] ].
	i := outgoingLines indexOf: aLine.
	n := outgoingLines size + 1.
	^ node encompassingRectangle bottomLeft
	  +
		  (node encompassingRectangle width asFloat * i asFloat / n asFloat
		   @ 0.0)"
	^ aLine from encompassingRectangle bottomCenter
]
