Class {
	#name : 'MMGraphParserTest',
	#superclass : 'TestCase',
	#instVars : [
		'parser'
	],
	#category : 'Micromaid-Graph-Tests',
	#package : 'Micromaid-Graph',
	#tag : 'Tests'
}

{ #category : 'asserting' }
MMGraphParserTest >> assertPetit2Success: anObject and: aBlock [

	self assert: anObject isPetit2Success.
	aBlock cull: anObject
]

{ #category : 'running' }
MMGraphParserTest >> setUp [

	super setUp.
	parser := MMGraphParser new
]

{ #category : 'tests' }
MMGraphParserTest >> testDiagram [

	| graph |
	graph := parser diagram end parse: 'flowchart TD
	Init[start]
	Init ---> Read
	Read ---> Eval
	Eval ---> Print
	Print ---> Read'.
	self assert: graph isPetit2Success.
	self assert: graph direction equals: #TD.
	self assert: graph entities size equals: 13
]

{ #category : 'tests' }
MMGraphParserTest >> testDirection [

	| direction |
	direction := parser direction end.
	#( 'TD' 'TB' 'BT' 'LR' 'RL' ) do: [ :dir |
		self assert: (direction parse: dir) equals: dir ]
]

{ #category : 'tests' }
MMGraphParserTest >> testHead1 [

	| head1 |
	head1 := parser head1 end.
	self
		assertPetit2Success: (head1 parse: '-')
		and: [ :head | self assert: head equals: #none ].
	self
		assertPetit2Success: (head1 parse: '<')
		and: [ :head | self assert: head equals: #arrowhead ].
	self
		assertPetit2Success: (head1 parse: 'o')
		and: [ :head | self assert: head equals: #circle ].
	self
		assertPetit2Success: (head1 parse: 'x')
		and: [ :head | self assert: head equals: #cross ].
	self assert: (head1 parse: '>') isPetit2Failure
]

{ #category : 'tests' }
MMGraphParserTest >> testHead2 [

	| head2 |
	head2 := parser head2 end.
	self
		assertPetit2Success: (head2 parse: '-')
		and: [ :head | self assert: head equals: #none ].
	self
		assertPetit2Success: (head2 parse: '>')
		and: [ :head | self assert: head equals: #arrowhead ].
	self
		assertPetit2Success: (head2 parse: 'o')
		and: [ :head | self assert: head equals: #circle ].
	self
		assertPetit2Success: (head2 parse: 'x')
		and: [ :head | self assert: head equals: #cross ].
	self assert: (head2 parse: '<') isPetit2Failure
]

{ #category : 'tests' }
MMGraphParserTest >> testLine [

	self
		assertPetit2Success: (parser line end parse: 'A')
		and: [ :line |
				self assert: line isArray.
				self assert: line size equals: 1.
				self assert: line first name equals: 'A'.
				self assert: line first label equals: 'A' ].
	self
		assertPetit2Success: (parser line end parse: 'A[node a]')
		and: [ :line |
				self assert: line isArray.
				self assert: line size equals: 1.
				self assert: line first name equals: 'A'.
				self assert: line first label equals: 'node a' ].
	self
		assertPetit2Success: (parser line end parse: 'A-->B')
		and: [ :line |
				self assert: line isArray.
				self assert: line size equals: 3.
				self assert: line first name equals: 'A'.
				self assert: line first label equals: 'A'.
				self assert: line second name equals: 'B'.
				self assert: line second label equals: 'B'.
				self assert: line third label equals: nil ].
	self
		assertPetit2Success:
		(parser line end parse: 'A[node a] -->|a to b| B[node b]')
		and: [ :line |
				self assert: line isArray.
				self assert: line size equals: 3.
				self assert: line first name equals: 'A'.
				self assert: line first label equals: 'node a'.
				self assert: line second name equals: 'B'.
				self assert: line second label equals: 'node b'.
				self assert: line third label equals: 'a to b' ].
	self
		assertPetit2Success: ((parser line , parser line) end parse: 'A
B')
		and: [ :lines |
				| nodes |
				self assert: lines isArray.
				self assert: lines size equals: 2.
				nodes := lines collect: #first.
				self assert: nodes first name equals: 'A'.
				self assert: nodes second name equals: 'B' ]
]

{ #category : 'tests' }
MMGraphParserTest >> testNormalLink [

	self
		assertPetit2Success: (parser normalLink end parse: '-->')
		and: [ :link |
				self assert: link isPetit2Success.
				self assert: link label equals: nil.
				self assert: link linestyle equals: #solid.
				self assert: link head1 equals: #none.
				self assert: link head2 equals: #arrowhead.
				self assert: link length equals: 1 ].
	self
		assertPetit2Success: (parser normalLink end parse: '---->')
		and: [ :link |
				self assert: link label equals: nil.
				self assert: link linestyle equals: #solid.
				self assert: link head1 equals: #none.
				self assert: link head2 equals: #arrowhead.
				self assert: link length equals: 3 ].
	self
		assertPetit2Success: (parser normalLink end parse: '-- foo --->')
		and: [ :link |
				self assert: link label equals: 'foo'.
				self assert: link linestyle equals: #solid.
				self assert: link head1 equals: #none.
				self assert: link head2 equals: #arrowhead.
				self assert: link length equals: 2 ].
	self
		assertPetit2Success: (parser normalLink end parse: '--->|foo|')
		and: [ :link |
				self assert: link label equals: 'foo'.
				self assert: link linestyle equals: #solid.
				self assert: link head1 equals: #none.
				self assert: link head2 equals: #arrowhead.
				self assert: link length equals: 2 ].
	self
		assertPetit2Success: (parser normalLink end parse: '---> |foo|')
		and: [ :link |
				self assert: link label equals: 'foo'.
				self assert: link linestyle equals: #solid.
				self assert: link head1 equals: #none.
				self assert: link head2 equals: #arrowhead.
				self assert: link length equals: 2 ]
]

{ #category : 'tests' }
MMGraphParserTest >> testRectNode [

	self
		assertPetit2Success: (parser rectNode end parse: 'A')
		and: [ :rectNode |
				self assert: rectNode isPetit2Success.
				self assert: rectNode name equals: 'A'.
				self assert: rectNode label equals: 'A'.
				self assert: rectNode shape equals: #rect ].
	self
		assertPetit2Success: (parser rectNode end parse: 'A[foo]')
		and: [ :rectNode |
				self assert: rectNode isPetit2Success.
				self assert: rectNode name equals: 'A'.
				self assert: rectNode label equals: 'foo'.
				self assert: rectNode shape equals: #rect ]
]

{ #category : 'tests' }
MMGraphParserTest >> testRoundedRectNode [

	self
		assertPetit2Success: (parser roundedRectNode end parse: 'A(foo)')
		and: [ :rectNode |
				self assert: rectNode isPetit2Success.
				self assert: rectNode name equals: 'A'.
				self assert: rectNode label equals: 'foo'.
				self assert: rectNode shape equals: #roundedRect ]
]
