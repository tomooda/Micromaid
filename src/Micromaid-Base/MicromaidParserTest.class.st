Class {
	#name : 'MicromaidParserTest',
	#superclass : 'TestCase',
	#instVars : [
		'parser'
	],
	#category : 'Micromaid-Base-AST',
	#package : 'Micromaid-Base',
	#tag : 'AST'
}

{ #category : 'running' }
MicromaidParserTest >> setUp [

	super setUp.
	parser := MicromaidParser newStartingAt: #yourself
]

{ #category : 'tests' }
MicromaidParserTest >> testAny [

	self assert: (parser any star parse: 'f#111;o;bar#35;buzz quuux#') equals: 'foo;bar#buzz quuux#' asOrderedCollection
]

{ #category : 'tests' }
MicromaidParserTest >> testNewline [

	self assert: (parser newline parse: String lf) equals: nil.
	self assert: (parser newline parse: '') equals: nil.
	self assert: (parser newline parse: String space , String tab) equals: nil.
	self assert: (parser newline parse: 'abc') isPetit2Failure
]
