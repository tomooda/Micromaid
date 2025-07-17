Class {
	#name : 'MMSequenceDiagramParserTest',
	#superclass : 'TestCase',
	#instVars : [
		'parser'
	],
	#category : 'Micromaid-SequenceDiagram-Tests',
	#package : 'Micromaid-SequenceDiagram',
	#tag : 'Tests'
}

{ #category : 'utilities' }
MMSequenceDiagramParserTest >> arrayFromMessage: aMMSequenceDiagramMessage [

	^ {
		  aMMSequenceDiagramMessage head1.
		  aMMSequenceDiagramMessage linestyle.
		  aMMSequenceDiagramMessage head2.
		  aMMSequenceDiagramMessage label }
]

{ #category : 'running' }
MMSequenceDiagramParserTest >> setUp [

	parser := MMSequenceDiagramParser new
]

{ #category : 'tests' }
MMSequenceDiagramParserTest >> testActor [

	| actor |
	actor := (parser actor parse: '	actor A') first.
	self assert: actor isMMActor.
	self assert: actor name equals: 'A'.
	self assert: actor label equals: 'A'.
	actor := (parser actor parse: 'actor A as Alpha') first.
	self assert: actor isMMActor.
	self assert: actor name equals: 'A'.
	self assert: actor label equals: 'Alpha'
]

{ #category : 'tests' }
MMSequenceDiagramParserTest >> testDiagram [

	| diagram |
	diagram := parser diagram parse: 'sequenceDiagram
	actor T as Tomo
	participant P as Pharo
	T ->> P : 3 + 4
	p -->> T : 7'.
	self assert: diagram entities size equals: 8.
	
]

{ #category : 'tests' }
MMSequenceDiagramParserTest >> testLink [

	self
		assert: (self arrayFromMessage: (parser link parse: '->'))
		equals: #( none normal none '' ).
	self
		assert: (self arrayFromMessage: (parser link parse: '-->'))
		equals: #( none dotted none '' ).
	self
		assert: (self arrayFromMessage: (parser link parse: '->>'))
		equals: #( none normal arrowhead '' ).
	self
		assert: (self arrayFromMessage: (parser link parse: '-->>'))
		equals: #( none dotted arrowhead '' ).
	self
		assert: (self arrayFromMessage: (parser link parse: '<<->>'))
		equals: #( arrowhead normal arrowhead '' ).
	self
		assert: (self arrayFromMessage: (parser link parse: '<<-->>'))
		equals: #( arrowhead dotted arrowhead '' ).
	self
		assert: (self arrayFromMessage: (parser link parse: '-x'))
		equals: #( none normal cross '' ).
	self
		assert: (self arrayFromMessage: (parser link parse: '--x'))
		equals: #( none dotted cross '' ).
	self
		assert: (self arrayFromMessage: (parser link parse: '-)'))
		equals: #( none normal wedgehead '' ).
	self
		assert: (self arrayFromMessage: (parser link parse: '--)'))
		equals: #( none dotted wedgehead '' )
]

{ #category : 'tests' }
MMSequenceDiagramParserTest >> testMessage [

	| triple sender receiver message |
	triple := parser message parse: '	A ->> B : Hello'.
	sender := triple first.
	receiver := triple second.
	message := triple third.
	self assert: sender name equals: 'A'.
	self assert: receiver name equals: 'B'.
	self assert: message node1 equals: 'A'.
	self assert: message node2 equals: 'B'.
	self assert: message label equals: 'Hello'
]

{ #category : 'tests' }
MMSequenceDiagramParserTest >> testParticipant [

	| participant |
	participant := (parser participant parse: '	participant A') first.
	self deny: participant isMMActor.
	self assert: participant name equals: 'A'.
	self assert: participant label equals: 'A'.
	participant := (parser participant parse: 'participant A as Alpha') first.
	self deny: participant isMMActor.
	self assert: participant name equals: 'A'.
	self assert: participant label equals: 'Alpha'
]
