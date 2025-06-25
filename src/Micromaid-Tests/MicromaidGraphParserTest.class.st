Class {
	#name : 'MicromaidGraphParserTest',
	#superclass : 'TestCase',
	#instVars : [
		'parser'
	],
	#category : 'Micromaid-Tests',
	#package : 'Micromaid-Tests'
}

{ #category : 'running' }
MicromaidGraphParserTest >> setUp [

	super setUp.
	parser := MicromaidGraphParser new
]

{ #category : 'tests' }
MicromaidGraphParserTest >> testHead1 [

	| head1 |
	head1 := parser head1 end.
	self assert: (head1 parse: '-') equals: #none.
	self assert: (head1 parse: '<') equals: #arrowhead.
	self assert: (head1 parse: 'o') equals: #circle.
	self assert: (head1 parse: 'x') equals: #cross.
	self assert: (head1 parse: '>') isPetit2Failure
]

{ #category : 'tests' }
MicromaidGraphParserTest >> testHead2 [

	| head2 |
	head2 := parser head2 end.
	self assert: (head2 parse: '-') equals: #none.
	self assert: (head2 parse: '>') equals: #arrowhead.
	self assert: (head2 parse: 'o') equals: #circle.
	self assert: (head2 parse: 'x') equals: #cross.
	self assert: (head2 parse: '<') isPetit2Failure
]

{ #category : 'tests' }
MicromaidGraphParserTest >> testNormalEdge [

	| edge |
	edge := parser normalEdge end parse: '-->'.
	self assert: edge label equals: nil.
	self assert: edge line equals: #normal.
	self assert: edge head1 equals: #none.
	self assert: edge head2 equals: #arrowhead.
	self assert: edge length equals: 1.
	edge := parser normalEdge end parse: '---->'.
	self assert: edge label equals: nil.
	self assert: edge line equals: #normal.
	self assert: edge head1 equals: #none.
	self assert: edge head2 equals: #arrowhead.
	self assert: edge length equals: 3.
	edge := parser normalEdge end parse: '-- foo --->'.
	self assert: edge label equals: 'foo'.
	self assert: edge line equals: #normal.
	self assert: edge head1 equals: #none.
	self assert: edge head2 equals: #arrowhead.
	self assert: edge length equals: 2.
	edge := parser normalEdge end parse: '--->|foo|'.
	self assert: edge label equals: 'foo'.
	self assert: edge line equals: #normal.
	self assert: edge head1 equals: #none.
	self assert: edge head2 equals: #arrowhead.
	self assert: edge length equals: 2
]

{ #category : 'tests' }
MicromaidGraphParserTest >> testRectNode [

	| rectNode |
	rectNode := parser rectNode end parse: 'A'.
	self assert: rectNode name equals: 'A'.
	self assert: rectNode label equals: 'A'.
	self assert: rectNode shape equals: #rect.
	rectNode := parser rectNode end parse: 'A[foo]'.
	self assert: rectNode name equals: 'A'.
	self assert: rectNode label equals: 'foo'.
	self assert: rectNode shape equals: #rect
]
