Class {
	#name : 'MMStateDiagramParserTest',
	#superclass : 'TestCase',
	#instVars : [
		'parser'
	],
	#category : 'Micromaid-StateDiagram-Tests',
	#package : 'Micromaid-StateDiagram',
	#tag : 'Tests'
}

{ #category : 'running' }
MMStateDiagramParserTest >> setUp [

	parser := MMStateDiagramParser new
]

{ #category : 'running' }
MMStateDiagramParserTest >> testArrow [

	self assert: (parser arrow parse: '-->') isPetit2Success
]

{ #category : 'running' }
MMStateDiagramParserTest >> testDiagram [

	| diagram |
	diagram := parser diagram parse: 'stateDiagram
	state "Foo" as foo
	bar : Bar
	[*] --> foo
	foo --> [*] : sometimes'.
	self assert: diagram isPetit2Success.
	self assert: diagram entities first isMMNode.
	self assert: diagram entities first name equals: 'foo'.
	self assert: diagram entities first label equals: 'Foo'.
	self assert: diagram entities second isMMNode.
	self assert: diagram entities second name equals: 'bar'.
	self assert: diagram entities second label equals: 'Bar'.

	self assert: diagram entities third isStartState.
	self assert: diagram entities fourth isMMNode.
	self assert: diagram entities fourth name equals: 'foo'.
	self assert: diagram entities fifth isMMEdge.
	self assert: diagram entities fifth node1 equals: '[Start]'.
	self assert: diagram entities fifth node2 equals: 'foo'.

	self assert: diagram entities sixth isMMNode.
	self assert: diagram entities sixth name equals: 'foo'.
	self assert: diagram entities seventh isStopState.
	self assert: diagram entities eighth isMMEdge.
	self assert: diagram entities eighth node1 equals: 'foo'.
	self assert: diagram entities eighth node2 equals: '[Stop]'.
	self assert: diagram entities eighth label equals: 'sometimes'
]

{ #category : 'running' }
MMStateDiagramParserTest >> testHeader [

	self assert: (parser header parse: 'stateDiagram') isPetit2Success.
	self assert: (parser header parse: 'stateDiagram-v2') isPetit2Success.
	self assert:
		(parser header parse: 'stateDiagram-somethingelse') isPetit2Failure
]

{ #category : 'running' }
MMStateDiagramParserTest >> testLine [

	self assert: (parser stateAs parse: '	state "Foo" as foo') isPetit2Success
]

{ #category : 'running' }
MMStateDiagramParserTest >> testSimpleState [

	| state |
	state := parser simpleState parse: 'foo'.
	self assert: state isPetit2Success.
	self assert: state name equals: 'foo'.
	self assert: state label equals: 'foo'
]

{ #category : 'running' }
MMStateDiagramParserTest >> testStartState [

	| state |
	state := parser startState parse: '[*]'.
	self assert: state isPetit2Success.
	self assert: state name equals: '[Start]'.
	self assert: state isStartState
]

{ #category : 'running' }
MMStateDiagramParserTest >> testStateAs [

	| state |
	state := parser stateAs parse: 'state "foo bar baz" as quuux'.
	self assert: state isPetit2Success.
	self assert: state name equals: 'quuux'.
	self assert: state label equals: 'foo bar baz'
]

{ #category : 'running' }
MMStateDiagramParserTest >> testStateWithLabel [

	| state |
	state := parser stateWithLabel parse: 'quuux : foo bar baz'.
	self assert: state isPetit2Success.
	self assert: state name equals: 'quuux'.
	self assert: state label equals: 'foo bar baz'
]

{ #category : 'running' }
MMStateDiagramParserTest >> testStopState [

	| state |
	state := parser stopState parse: '[*]'.
	self assert: state isPetit2Success.
	self assert: state name equals: '[Stop]'.
	self assert: state isStopState
]

{ #category : 'running' }
MMStateDiagramParserTest >> testTransition [

	| transition |
	transition := parser transition parse: '[*] --> foo'.
	self assert: transition isPetit2Success.
	self assert: transition first isStartState.
	self assert: transition first name equals: transition third node1.
	self assert: transition second name equals: transition third node2.
	self assert: transition third node1 equals: '[Start]'.
	self assert: transition third node2 equals: 'foo'.
	self assert: transition third label isNil.
	transition := parser transition parse: 'foo --> bar : baz'.
	self assert: transition isPetit2Success.
	self assert: transition first name equals: transition third node1.
	self assert: transition second name equals: transition third node2.
	self assert: transition third node1 equals: 'foo'.
	self assert: transition third node2 equals: 'bar'.
	self assert: transition third label equals: 'baz'.
	transition := parser transition parse: 'foo --> [*]'.
	self assert: transition isPetit2Success.
	self assert: transition second isStopState.
	self assert: transition first name equals: transition third node1.
	self assert: transition second name equals: transition third node2.
	self assert: transition third node1 equals: 'foo'.
	self assert: transition third node2 equals: '[Stop]'.
	self assert: transition third label isNil
]
