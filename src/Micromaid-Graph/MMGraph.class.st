Class {
	#name : 'MMGraph',
	#superclass : 'MMDiagram',
	#instVars : [
		'direction'
	],
	#category : 'Micromaid-Graph-AST',
	#package : 'Micromaid-Graph',
	#tag : 'AST'
}

{ #category : 'accessing' }
MMGraph >> direction [

	^ direction
]

{ #category : 'accessing' }
MMGraph >> direction: aSymbol [

	direction := aSymbol asSymbol
]

{ #category : 'enumerating' }
MMGraph >> directionDo: aBlock [

	direction ifNotNil: aBlock
]

{ #category : 'accessing' }
MMGraph >> roassalBuilder [

	| builder |
	builder := self roassalBuilderClass new.
	self directionDo: [:dir | builder direction: dir ].
	self entitiesDo: [ :nodeOrEdge | nodeOrEdge applyToBuilder: builder ].
	^ builder
]

{ #category : 'class access' }
MMGraph >> roassalBuilderClass [

	^ MMGraphRoassalBuilder
]
