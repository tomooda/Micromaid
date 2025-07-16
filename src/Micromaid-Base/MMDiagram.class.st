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
MMDiagram >> entities: anArrayOfMMGraphNodeOrMMGraphEdge [

	entities := anArrayOfMMGraphNodeOrMMGraphEdge
]

{ #category : 'enumerating' }
MMDiagram >> entitiesDo: aBlock [

	entities do: aBlock
]

{ #category : 'accessing' }
MMDiagram >> roassalBuilder [

	| builder |
	builder := self roassalBuilderClass new.
	self entitiesDo: [ :nodeOrEdge | nodeOrEdge applyToBuilder: builder ].
	^ builder
]

{ #category : 'class access' }
MMDiagram >> roassalBuilderClass [

	^ self subclassResponsibility
]
