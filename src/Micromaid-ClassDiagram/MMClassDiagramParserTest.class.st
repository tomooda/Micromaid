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
MMClassDiagramParserTest >> testAggregation [

	(parser arrow parse: 'Object o-- Quuux') in: [ :aggregation |
			self assert: aggregation isPetit2Success.
			self
				assert: aggregation class name
				equals: #MMClassDiagramAggregation.
			self assert: aggregation node1 equals: 'Object'.
			self assert: aggregation node2 equals: 'Quuux'.
			self assert: aggregation cardinality1 isNil.
			self assert: aggregation cardinality2 isNil.
			self assert: aggregation label isNil ].
	(parser arrow parse: 'Object "1" o-- "many" Quuux : Blah') in: [
			:aggregation |
			self assert: aggregation isPetit2Success.
			self
				assert: aggregation class name
				equals: #MMClassDiagramAggregation.
			self assert: aggregation node1 equals: 'Object'.
			self assert: aggregation node2 equals: 'Quuux'.
			self assert: aggregation cardinality1 equals: '1'.
			self assert: aggregation cardinality2 equals: 'many'.
			self assert: aggregation label equals: 'Blah' ].
	(parser arrow parse: 'Quuux --o Object') in: [ :aggregation |
			self assert: aggregation isPetit2Success.
			self
				assert: aggregation class name
				equals: #MMClassDiagramAggregation.
			self assert: aggregation node1 equals: 'Object'.
			self assert: aggregation node2 equals: 'Quuux'.
			self assert: aggregation cardinality1 isNil.
			self assert: aggregation cardinality2 isNil.
			self assert: aggregation label isNil ].
	(parser arrow parse: 'Quuux "1" --o "many" Object:Blah') in: [
			:aggregation |
			self assert: aggregation isPetit2Success.
			self
				assert: aggregation class name
				equals: #MMClassDiagramAggregation.
			self assert: aggregation node1 equals: 'Object'.
			self assert: aggregation node2 equals: 'Quuux'.
			self assert: aggregation cardinality1 equals: 'many'.
			self assert: aggregation cardinality2 equals: '1'.
			self assert: aggregation label equals: 'Blah' ]
]

{ #category : 'tests' }
MMClassDiagramParserTest >> testAssociation [

	(parser arrow parse: 'Object <-- Quuux') in: [ :association |
			self assert: association isPetit2Success.
			self
				assert: association class name
				equals: #MMClassDiagramAssociation.
			self assert: association node1 equals: 'Object'.
			self assert: association node2 equals: 'Quuux'.
			self assert: association cardinality1 isNil.
			self assert: association cardinality2 isNil.
			self assert: association label isNil ].
	(parser arrow parse: 'Object "1" <-- "many" Quuux : Blah') in: [ :association |
			self assert: association isPetit2Success.
			self
				assert: association class name
				equals: #MMClassDiagramAssociation.
			self assert: association node1 equals: 'Object'.
			self assert: association node2 equals: 'Quuux'.
			self assert: association cardinality1 equals: '1'.
			self assert: association cardinality2 equals: 'many'.
			self assert: association label equals: 'Blah' ].
	(parser arrow parse: 'Quuux --> Object') in: [ :association |
			self assert: association isPetit2Success.
			self
				assert: association class name
				equals: #MMClassDiagramAssociation.
			self assert: association node1 equals: 'Object'.
			self assert: association node2 equals: 'Quuux'.
			self assert: association cardinality1 isNil.
			self assert: association cardinality2 isNil.
			self assert: association label isNil ].
	(parser arrow parse: 'Quuux  "many" --> "1" Object:Blah') in: [ :association |
			self assert: association isPetit2Success.
			self
				assert: association class name
				equals: #MMClassDiagramAssociation.
			self assert: association node1 equals: 'Object'.
			self assert: association node2 equals: 'Quuux'.
			self assert: association cardinality1 equals: '1'.
			self assert: association cardinality2 equals: 'many'.
			self assert: association label equals: 'Blah' ]
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
MMClassDiagramParserTest >> testComposition [

	(parser arrow parse: 'Object *-- Quuux') in: [ :composition |
			self assert: composition isPetit2Success.
			self
				assert: composition class name
				equals: #MMClassDiagramComposition.
			self assert: composition node1 equals: 'Object'.
			self assert: composition node2 equals: 'Quuux'.
			self assert: composition cardinality1 isNil.
			self assert: composition cardinality2 isNil.
			self assert: composition label isNil ].
	(parser arrow parse: 'Object "1" *-- "many" Quuux : Blah') in: [ :composition |
			self assert: composition isPetit2Success.
			self
				assert: composition class name
				equals: #MMClassDiagramComposition.
			self assert: composition node1 equals: 'Object'.
			self assert: composition node2 equals: 'Quuux'.
			self assert: composition cardinality1 equals: '1'.
			self assert: composition cardinality2 equals: 'many'.
			self assert: composition label equals: 'Blah' ].
	(parser arrow parse: 'Quuux --* Object') in: [ :composition |
			self assert: composition isPetit2Success.
			self
				assert: composition class name
				equals: #MMClassDiagramComposition.
			self assert: composition node1 equals: 'Object'.
			self assert: composition node2 equals: 'Quuux'.
			self assert: composition cardinality1 isNil.
			self assert: composition cardinality2 isNil.
			self assert: composition label isNil ].
	(parser arrow parse: 'Quuux "many" --* "1" Object:Blah') in: [ :composition |
			self assert: composition isPetit2Success.
			self
				assert: composition class name
				equals: #MMClassDiagramComposition.
			self assert: composition node1 equals: 'Object'.
			self assert: composition node2 equals: 'Quuux'.
			self assert: composition cardinality1 equals: '1'.
			self assert: composition cardinality2 equals: 'many'.
			self assert: composition label equals: 'Blah' ]
]

{ #category : 'tests' }
MMClassDiagramParserTest >> testDashedLink [

	(parser arrow parse: 'Object .. Quuux') in: [ :solidLink |
			self assert: solidLink isPetit2Success.
			self assert: solidLink class name equals: #MMClassDiagramDashedLink.
			self assert: solidLink node1 equals: 'Object'.
			self assert: solidLink node2 equals: 'Quuux'.
			self assert: solidLink cardinality1 isNil.
			self assert: solidLink cardinality2 isNil.
			self assert: solidLink label isNil ].
	(parser arrow parse: 'Object "1" .. "many" Quuux : Blah') in: [ :solidLink |
			self assert: solidLink isPetit2Success.
			self assert: solidLink class name equals: #MMClassDiagramDashedLink.
			self assert: solidLink node1 equals: 'Object'.
			self assert: solidLink node2 equals: 'Quuux'.
			self assert: solidLink cardinality1 equals: '1'.
			self assert: solidLink cardinality2 equals: 'many'.
			self assert: solidLink label equals: 'Blah' ]
]

{ #category : 'tests' }
MMClassDiagramParserTest >> testDependency [

	(parser arrow parse: 'Object <.. Quuux') in: [ :dependency |
			self assert: dependency isPetit2Success.
			self
				assert: dependency class name
				equals: #MMClassDiagramDependency.
			self assert: dependency node1 equals: 'Object'.
			self assert: dependency node2 equals: 'Quuux'.
			self assert: dependency cardinality1 isNil.
			self assert: dependency cardinality2 isNil.
			self assert: dependency label isNil ].
	(parser arrow parse: 'Object "1" <.. "many" Quuux : Blah') in: [ :dependency |
			self assert: dependency isPetit2Success.
			self
				assert: dependency class name
				equals: #MMClassDiagramDependency.
			self assert: dependency node1 equals: 'Object'.
			self assert: dependency node2 equals: 'Quuux'.
			self assert: dependency cardinality1 equals: '1'.
			self assert: dependency cardinality2 equals: 'many'.
			self assert: dependency label equals: 'Blah' ].
	(parser arrow parse: 'Quuux ..> Object') in: [ :dependency |
			self assert: dependency isPetit2Success.
			self
				assert: dependency class name
				equals: #MMClassDiagramDependency.
			self assert: dependency node1 equals: 'Object'.
			self assert: dependency node2 equals: 'Quuux'.
			self assert: dependency cardinality1 isNil.
			self assert: dependency cardinality2 isNil.
			self assert: dependency label isNil ].
	(parser arrow parse: 'Quuux "many" ..> "1" Object:Blah') in: [ :dependency |
			self assert: dependency isPetit2Success.
			self
				assert: dependency class name
				equals: #MMClassDiagramDependency.
			self assert: dependency node1 equals: 'Object'.
			self assert: dependency node2 equals: 'Quuux'.
			self assert: dependency cardinality1 equals: '1'.
			self assert: dependency cardinality2 equals: 'many'.
			self assert: dependency label equals: 'Blah' ]
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

	(parser arrow parse: 'Object <|-- Quuux') in: [ :inheritance |
			self assert: inheritance isPetit2Success.
			self
				assert: inheritance class name
				equals: #MMClassDiagramInheritance.
			self assert: inheritance node1 equals: 'Object'.
			self assert: inheritance node2 equals: 'Quuux'.
			self assert: inheritance label isNil ].
	(parser arrow parse: 'Object <|-- Quuux : Blah') in: [ :inheritance |
			self assert: inheritance isPetit2Success.
			self
				assert: inheritance class name
				equals: #MMClassDiagramInheritance.
			self assert: inheritance node1 equals: 'Object'.
			self assert: inheritance node2 equals: 'Quuux'.
			self assert: inheritance label equals: 'Blah' ].
	(parser arrow parse: 'Quuux --|> Object') in: [ :inheritance |
			self assert: inheritance isPetit2Success.
			self
				assert: inheritance class name
				equals: #MMClassDiagramInheritance.
			self assert: inheritance node1 equals: 'Object'.
			self assert: inheritance node2 equals: 'Quuux'.
			self assert: inheritance label isNil ].
	(parser arrow parse: 'Quuux --|> Object:Blah') in: [ :inheritance |
			self assert: inheritance isPetit2Success.
			self
				assert: inheritance class name
				equals: #MMClassDiagramInheritance.
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
		equals: 'quuux'.
	self
		assert: (parser memberLine parse: '      <<annotated>> quuux    ') name
		equals: '<<annotated>> quuux'
]

{ #category : 'tests' }
MMClassDiagramParserTest >> testRealization [

	(parser arrow parse: 'Object <|.. Quuux') in: [ :realization |
			self assert: realization isPetit2Success.
			self
				assert: realization class name
				equals: #MMClassDiagramRealization.
			self assert: realization node1 equals: 'Object'.
			self assert: realization node2 equals: 'Quuux'.
			self assert: realization cardinality1 isNil.
			self assert: realization cardinality2 isNil.
			self assert: realization label isNil ].
	(parser arrow parse: 'Object "1" <|.. "many" Quuux : Blah') in: [ :realization |
			self assert: realization isPetit2Success.
			self
				assert: realization class name
				equals: #MMClassDiagramRealization.
			self assert: realization node1 equals: 'Object'.
			self assert: realization node2 equals: 'Quuux'.
			self assert: realization cardinality1 equals: '1'.
			self assert: realization cardinality2 equals: 'many'.
			self assert: realization label equals: 'Blah' ].
	(parser arrow parse: 'Quuux ..|> Object') in: [ :realization |
			self assert: realization isPetit2Success.
			self
				assert: realization class name
				equals: #MMClassDiagramRealization.
			self assert: realization node1 equals: 'Object'.
			self assert: realization node2 equals: 'Quuux'.
			self assert: realization cardinality1 isNil.
			self assert: realization cardinality2 isNil.
			self assert: realization label isNil ].
	(parser arrow parse: 'Quuux "many" ..|> "1" Object:Blah') in: [ :realization |
			self assert: realization isPetit2Success.
			self
				assert: realization class name
				equals: #MMClassDiagramRealization.
			self assert: realization node1 equals: 'Object'.
			self assert: realization node2 equals: 'Quuux'.
			self assert: realization cardinality1 equals: '1'.
			self assert: realization cardinality2 equals: 'many'.
			self assert: realization label equals: 'Blah' ]
]

{ #category : 'tests' }
MMClassDiagramParserTest >> testSolidLink [

	(parser arrow parse: 'Object -- Quuux') in: [ :solidLink |
			self assert: solidLink isPetit2Success.
			self assert: solidLink class name equals: #MMClassDiagramSolidLink.
			self assert: solidLink node1 equals: 'Object'.
			self assert: solidLink node2 equals: 'Quuux'.
			self assert: solidLink cardinality1 isNil.
			self assert: solidLink cardinality2 isNil.
			self assert: solidLink label isNil ].
	(parser arrow parse: 'Object "1" -- "many" Quuux : Blah') in: [
			:solidLink |
			self assert: solidLink isPetit2Success.
			self assert: solidLink class name equals: #MMClassDiagramSolidLink.
			self assert: solidLink node1 equals: 'Object'.
			self assert: solidLink node2 equals: 'Quuux'.
			self assert: solidLink cardinality1 equals: '1'.
			self assert: solidLink cardinality2 equals: 'many'.
			self assert: solidLink label equals: 'Blah' ]
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
