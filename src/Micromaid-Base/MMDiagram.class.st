"
I am an abstract class of micromaid diagrams.
A concrete subclass of `MicromaidParser` should return my concrete subclass when the given script is successfully parsed.

## How to build instances of my concrete subclasses

Micromaid supports various diagram scripts.
They basically consist of statements.
I expect the parser to decompose the contents of the script into a series of statements, and store the AST nodes of the statements as entities.
The `diagram` method of the parser will tyically looks like the below.

```
diagram
	^ self header, (self line, self newline ==> #first) ==> [:pair | MMFooDiagram new entities: pair second]
```

## How to use instances of my concrete subclass

I provide `roassalBuilder` method that returns a roassal builder which responds to the `build` message.
My client code will look like the below.

```
diagram roassalBuilder build zoomToFit; @RSCanvasController; open
```
"
Class {
	#name : 'MMDiagram',
	#superclass : 'Object',
	#instVars : [
		'entities'
	],
	#category : 'Micromaid-Base-AST',
	#package : 'Micromaid-Base',
	#tag : 'AST'
}

{ #category : 'testing' }
MMDiagram class >> isAbstract [

	^ self = MMDiagram
]

{ #category : 'accessing' }
MMDiagram >> entities [

	^ entities
]

{ #category : 'accessing' }
MMDiagram >> entities: anArrayOfMMEntity [

	entities := anArrayOfMMEntity
]

{ #category : 'enumerating' }
MMDiagram >> entitiesDo: aBlock [

	entities do: aBlock
]

{ #category : 'accessing' }
MMDiagram >> open [

	^ self openWithTitle: 'Micromaid'
]

{ #category : 'accessing' }
MMDiagram >> openWithTitle: aString [

	| canvas |
	canvas := self roassalBuilder build.
	^ canvas
		  extent: canvas encompassingRectangle extent + (20 @ 20);
		  zoomToFit;
		  @ RSCanvasController;
		  openWithTitle: aString
]

{ #category : 'accessing' }
MMDiagram >> roassalBuilder [

	| builder |
	builder := self roassalBuilderClass new.
	self entitiesDo: [ :entity | entity applyToBuilder: builder ].
	^ builder
]

{ #category : 'class access' }
MMDiagram >> roassalBuilderClass [

	^ self subclassResponsibility
]
