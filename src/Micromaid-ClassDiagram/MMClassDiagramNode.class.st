Class {
	#name : 'MMClassDiagramNode',
	#superclass : 'MMNode',
	#instVars : [
		'annotations',
		'attributes',
		'operations'
	],
	#category : 'Micromaid-ClassDiagram-Roassal',
	#package : 'Micromaid-ClassDiagram',
	#tag : 'Roassal'
}

{ #category : 'adding' }
MMClassDiagramNode >> addAnnotation: aString [

	annotations add: aString.
	^ aString
]

{ #category : 'adding' }
MMClassDiagramNode >> addAttribute: aString [

	attributes add: aString.
	^ aString
]

{ #category : 'adding' }
MMClassDiagramNode >> addOperation: aString [

	operations add: aString.
	^ aString
]

{ #category : 'accessing' }
MMClassDiagramNode >> annotations [

	^ annotations asArray
]

{ #category : 'accessing' }
MMClassDiagramNode >> annotations: anArrayOfString [

	annotations := anArrayOfString asOrderedCollection
]

{ #category : 'building' }
MMClassDiagramNode >> applyToBuilder: aMMGraphBuilder [

	
]

{ #category : 'accessing' }
MMClassDiagramNode >> attributes [

	^ attributes asArray
]

{ #category : 'accessing' }
MMClassDiagramNode >> attributes: anArrayOfString [

	attributes := anArrayOfString asOrderedCollection
]

{ #category : 'initialization' }
MMClassDiagramNode >> initialize [

	super initialize.
	annotations := OrderedCollection new.
	attributes := OrderedCollection new.
	operations := OrderedCollection new
]

{ #category : 'accessing' }
MMClassDiagramNode >> name: aString [

	super name: aString.
	label ifNotNil: [ label := aString ]
]

{ #category : 'accessing' }
MMClassDiagramNode >> operations [

	^ operations asArray
]

{ #category : 'accessing' }
MMClassDiagramNode >> operations: anArrayOfString [

	operations := anArrayOfString asOrderedCollection
]
