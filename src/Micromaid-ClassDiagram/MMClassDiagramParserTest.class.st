Class {
	#name : 'MMClassDiagramParserTest',
	#superclass : 'TestCase',
	#instVars : [
		'parser'
	],
	#category : 'Micromaid-ClassDiagram-Tests',
	#package : 'Micromaid-ClassDiagram',
	#tag : 'Tests'
}

{ #category : 'running' }
MMClassDiagramParserTest >> setUp [

	parser := MMClassDiagramParser new
]

{ #category : 'tests' }
MMClassDiagramParserTest >> testBeginAttributes [

	self
		assert: (parser beginAttributes parse: '%% attributes') className
		equals: #MMClassDiagramBeginAttributes.
	self
		assert: (parser beginAttributes parse: '%% variables') className
		equals: #MMClassDiagramBeginAttributes.
	self assert:
		(parser beginAttributes parse: '%% quuux') isPetit2Failure
]

{ #category : 'tests' }
MMClassDiagramParserTest >> testBeginClass [

	(parser beginClass end parse: 'class Quuux {') in: [ :classDecl |
			self assert: classDecl isPetit2Success.
			self assert: classDecl name equals: 'Quuux'.
			self assert: classDecl label isNil ].
	(parser beginClass end parse: 'class Quuux ["Foo Bar Baz"] {') in: [
			:classDecl |
			self assert: classDecl isPetit2Success.
			self assert: classDecl name equals: 'Quuux'.
			self assert: classDecl label equals: 'Foo Bar Baz' ].
	(parser beginClass end parse:
		 'class Quuux <<foo>> <<bar>> <<baz>> <<quuux>> {') in: [ :classDecl |
			self assert: classDecl isPetit2Success.
			self assert: classDecl name equals: 'Quuux'.
			self
				assert: classDecl annotations
				equals: #( 'foo' 'bar' 'baz' 'quuux' ).
			self assert: classDecl label isNil ].
	(parser beginClass end parse:
		 'class Quuux ["Foo Bar"] <<baz>> <<quuux>> {') in: [ :classDecl |
			self assert: classDecl isPetit2Success.
			self assert: classDecl name equals: 'Quuux'.
			self assert: classDecl label equals: 'Foo Bar'.
			self assert: classDecl annotations equals: #( 'baz' 'quuux' ) ]
]

{ #category : 'tests' }
MMClassDiagramParserTest >> testBeginOperations [

	self
		assert: (parser beginOperations parse: '%% operations') className
		equals: #MMClassDiagramBeginOperations.
	self
		assert: (parser beginOperations parse: '%% methods') className
		equals: #MMClassDiagramBeginOperations.
	self assert:
		(parser beginOperations parse: '%% quuux') isPetit2Failure
]

{ #category : 'tests' }
MMClassDiagramParserTest >> testClassDeclaration [

	(parser classDeclaration parse: 'class Quuux') in: [ :classDecl |
			self assert: classDecl isPetit2Success.
			self assert: classDecl name equals: 'Quuux'.
			self assert: classDecl label isNil ].
	(parser classDeclaration parse: 'class Quuux ["Foo Bar Baz"]') in: [
			:classDecl |
			self assert: classDecl isPetit2Success.
			self assert: classDecl name equals: 'Quuux'.
			self assert: classDecl label equals: 'Foo Bar Baz' ].
	(parser classDeclaration parse:
		 'class Quuux <<foo>> <<bar>> <<baz>> <<quuux>>') in: [ :classDecl |
			self assert: classDecl isPetit2Success.
			self assert: classDecl name equals: 'Quuux'.
			self
				assert: classDecl annotations
				equals: #( 'foo' 'bar' 'baz' 'quuux' ).
			self assert: classDecl label isNil ].
	(parser classDeclaration parse:
		 'class Quuux ["Foo Bar"] <<baz>> <<quuux>> ') in: [ :classDecl |
			self assert: classDecl isPetit2Success.
			self assert: classDecl name equals: 'Quuux'.
			self assert: classDecl label equals: 'Foo Bar'.
			self assert: classDecl annotations equals: #( 'baz' 'quuux' ) ]
]

{ #category : 'tests' }
MMClassDiagramParserTest >> testClassDefinition [

	(parser classDefinition parse: '	class Foo {
		<<abstract>>
		%% attributes
		x : Integer
		y : Integer
		%% operations
		distanceFrom:
	}') in: [ :array |
			self assert: array isPetit2Success.
			self assert: array size equals: 8.
			self assert: array first name equals: 'Foo'.
			self assert: array second annotation equals: 'abstract'.
			self
				assert: array third class name
				equals: #MMClassDiagramBeginAttributes.
			self assert: array fourth name equals: 'x : Integer'.
			self assert: array fifth name equals: 'y : Integer'.
			self
				assert: array sixth class name
				equals: #MMClassDiagramBeginOperations.
			self assert: array seventh name equals: 'distanceFrom:'.
			self
				assert: array eighth class name
				equals: #MMClassDiagramEndClass ]
]

{ #category : 'tests' }
MMClassDiagramParserTest >> testDiagram [

	(parser diagram end parse: 'classDiagram
	direction LR
	class Foo
	Foo : bar
	class Baz {
		%% methods
		quux
	}
	Foo <|-- Baz') in: [ :diagram |
			self assert: diagram entities first direction equals: #LR.
			self assert: diagram entities second name equals: 'Foo'.
			self
				assert: diagram entities eighth class name
				equals: #MMClassDiagramInheritance ]
]

{ #category : 'tests' }
MMClassDiagramParserTest >> testDirection [

	self
		assert: (parser direction end parse: 'direction TD') direction
		equals: 'TD'.
	self
		assert: (parser direction end parse: 'direction TB') direction
		equals: 'TB'.
	self
		assert: (parser direction end parse: 'direction BT') direction
		equals: 'BT'.
	self
		assert: (parser direction end parse: 'direction LR') direction
		equals: 'LR'.
	self
		assert: (parser direction end parse: 'direction RL') direction
		equals: 'RL'.
	self assert:
		(parser direction end parse: 'direction TL') isPetit2Failure
]

{ #category : 'tests' }
MMClassDiagramParserTest >> testEndClass [

	self assert: (parser endClass parse: '    }') isPetit2Success
]

{ #category : 'tests' }
MMClassDiagramParserTest >> testHeader [

	self assert: (parser header parse: 'classDiagram') isPetit2Success.
	self assert: (parser header parse: 'stateDiagram') isPetit2Failure
]

{ #category : 'tests' }
MMClassDiagramParserTest >> testInheritance [

	(parser inheritance parse: 'Object <|-- Quuux') in: [ :inheritance |
			self assert: inheritance isPetit2Success.
			self assert: inheritance node1 equals: 'Object'.
			self assert: inheritance node2 equals: 'Quuux'.
			self assert: inheritance label isNil ].
	(parser inheritance parse: 'Object <|-- Quuux : Blah') in: [
			:inheritance |
			self assert: inheritance isPetit2Success.
			self assert: inheritance node1 equals: 'Object'.
			self assert: inheritance node2 equals: 'Quuux'.
			self assert: inheritance label equals: 'Blah' ].
	(parser inheritance parse: 'Quuux --|> Object') in: [ :inheritance |
			self assert: inheritance isPetit2Success.
			self assert: inheritance node1 equals: 'Object'.
			self assert: inheritance node2 equals: 'Quuux'.
			self assert: inheritance label isNil ].
	(parser inheritance parse: 'Quuux --|> Object:Blah') in: [
			:inheritance |
			self assert: inheritance isPetit2Success.
			self assert: inheritance node1 equals: 'Object'.
			self assert: inheritance node2 equals: 'Quuux'.
			self assert: inheritance label equals: 'Blah' ]
]

{ #category : 'tests' }
MMClassDiagramParserTest >> testLineInClass [

	(parser lineInClass parse: '	<<abstract>>') in: [ :line |
		self assert: line class name equals: #MMClassDiagramAnnotation ].
	(parser lineInClass parse: '	foo bar baz quuux') in: [ :line |
		self assert: line class name equals: #MMClassDiagramMember ].
	(parser lineInClass parse: '	%% methods') in: [ :line |
		self assert: line class name equals: #MMClassDiagramBeginOperations ].
	(parser lineInClass parse: '	%% attributes') in: [ :line |
		self assert: line class name equals: #MMClassDiagramBeginAttributes ].
	(parser lineInClass parse: '	}') in: [ :line |
		self assert: line isPetit2Failure ]
]

{ #category : 'tests' }
MMClassDiagramParserTest >> testMemberDeclaration [

	(parser memberDeclaration parse: 'Foo : quuux') in: [ :memberDecl |
			self assert: memberDecl isPetit2Success.
			self assert: memberDecl name equals: 'quuux'.
			self assert: memberDecl node equals: 'Foo' ].
	(parser memberDeclaration parse: 'Foo : quuux()') in: [ :memberDecl |
			self assert: memberDecl isPetit2Success.
			self assert: memberDecl name equals: 'quuux()'.
			self assert: memberDecl node equals: 'Foo' ]
]

{ #category : 'tests' }
MMClassDiagramParserTest >> testMemberLine [

	self
		assert: (parser memberLine parse: '      quuux    ') name
		equals: 'quuux'
]

{ #category : 'tests' }
MMClassDiagramParserTest >> testStatement [

	self
		assert: (parser statement end parse: '%% attributes') className
		equals: #MMClassDiagramBeginAttributes.
	self
		assert: (parser statement end parse: '%% operations') className
		equals: #MMClassDiagramBeginOperations.
	self
		assert: (parser statement end parse: 'direction TD') className
		equals: #MMClassDiagramDirection.
	self
		assert: (parser statement end parse: 'Foo <|-- Quuux') className
		equals: #MMClassDiagramInheritance.
	self
		assert: (parser statement end parse: 'Foo : quuux') className
		equals: #MMClassDiagramMember.
	self
		assert: (parser statement end parse: 'class Foo {
	foo
	bar
	%% methods
	+quuux
	}') last class name
		equals: #MMClassDiagramEndClass.
	self
		assert: (parser statement end parse: 'class Foo["Quuux"]') className
		equals: #MMClassDiagramClass
]
