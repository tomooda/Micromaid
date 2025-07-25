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
MMSequenceDiagramParserTest >> testActivation [

	| activation |
	activation := (parser activation parse: '	activate A') first.
	self assert: activation name equals: 'A'
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
MMSequenceDiagramParserTest >> testDeactivation [

	| deactivation |
	deactivation := (parser deactivation parse: '	deactivate A') first.
	self assert: deactivation name equals: 'A'
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
		equals: #( none solid none '' ).
	self
		assert: (self arrayFromMessage: (parser link parse: '-->'))
		equals: #( none dotted none '' ).
	self
		assert: (self arrayFromMessage: (parser link parse: '->>'))
		equals: #( none solid arrowhead '' ).
	self
		assert: (self arrayFromMessage: (parser link parse: '-->>'))
		equals: #( none dotted arrowhead '' ).
	self
		assert: (self arrayFromMessage: (parser link parse: '<<->>'))
		equals: #( arrowhead solid arrowhead '' ).
	self
		assert: (self arrayFromMessage: (parser link parse: '<<-->>'))
		equals: #( arrowhead dotted arrowhead '' ).
	self
		assert: (self arrayFromMessage: (parser link parse: '-x'))
		equals: #( none solid cross '' ).
	self
		assert: (self arrayFromMessage: (parser link parse: '--x'))
		equals: #( none dotted cross '' ).
	self
		assert: (self arrayFromMessage: (parser link parse: '-)'))
		equals: #( none solid wedgehead '' ).
	self
		assert: (self arrayFromMessage: (parser link parse: '--)'))
		equals: #( none dotted wedgehead '' )
]

{ #category : 'tests' }
MMSequenceDiagramParserTest >> testMessage [

	| array sender receiver message activation deactivation |
	array := parser message parse: '	A ->> B : Hello'.
	sender := array first.
	receiver := array second.
	message := array third.
	self assert: sender name equals: 'A'.
	self assert: receiver name equals: 'B'.
	self assert: message node1 equals: 'A'.
	self assert: message node2 equals: 'B'.
	self assert: message label equals: 'Hello'.
	array := parser message parse: '	A ->>+ B : Hello'.
	sender := array first.
	receiver := array second.
	message := array third.
	activation := array fourth.
	self assert: sender name equals: 'A'.
	self assert: receiver name equals: 'B'.
	self assert: message node1 equals: 'A'.
	self assert: message node2 equals: 'B'.
	self assert: message label equals: 'Hello'.
	self assert: activation name equals: 'B'.
	array := parser message parse: '	B -->>- A : Howdy'.
	sender := array first.
	receiver := array second.
	message := array third.
	deactivation := array fourth.
	self assert: sender name equals: 'B'.
	self assert: receiver name equals: 'A'.
	self assert: message node1 equals: 'B'.
	self assert: message node2 equals: 'A'.
	self assert: message label equals: 'Howdy'.
	self assert: deactivation name equals: 'B'
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
