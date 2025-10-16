Class {
	#name : 'MMSequenceDiagramNote',
	#superclass : 'MMEntity',
	#instVars : [
		'label',
		'position',
		'actors'
	],
	#category : 'Micromaid-SequenceDiagram-AST',
	#package : 'Micromaid-SequenceDiagram',
	#tag : 'AST'
}

{ #category : 'accessing' }
MMSequenceDiagramNote >> actors [

	^ actors
]

{ #category : 'accessing' }
MMSequenceDiagramNote >> actors: anArrayOfString [

	actors := anArrayOfString
]

{ #category : 'building' }
MMSequenceDiagramNote >> applyToBuilder: aMMSequenceDiagramRoassalBuilder [

	aMMSequenceDiagramRoassalBuilder addNote: self
]

{ #category : 'controlling' }
MMSequenceDiagramNote >> ifLeft: leftBlock ifRight: rightBlock ifOver: overBlock [

	position = #left ifTrue: [ ^ leftBlock cull: actors first ].
	position = #right ifTrue: [ ^ rightBlock cull: actors first ].
	^ overBlock cull: actors
]

{ #category : 'initialization' }
MMSequenceDiagramNote >> initialize [

	super initialize.
	label := ''.
	position := #over.
	actors := Array new
]

{ #category : 'accessing' }
MMSequenceDiagramNote >> label [

	^ label
]

{ #category : 'accessing' }
MMSequenceDiagramNote >> label: aString [

	label := aString
]

{ #category : 'accessing' }
MMSequenceDiagramNote >> leftOf: aString [

	position := #left.
	actors := { aString }
]

{ #category : 'accessing' }
MMSequenceDiagramNote >> over: anArrayOfString [

	position := #over.
	actors := anArrayOfString
]

{ #category : 'accessing' }
MMSequenceDiagramNote >> position [

	^ position
]

{ #category : 'accessing' }
MMSequenceDiagramNote >> position: aSymbol [

	position := aSymbol
]

{ #category : 'accessing' }
MMSequenceDiagramNote >> rightOf: aString [

	position := #right.
	actors := { aString }
]
