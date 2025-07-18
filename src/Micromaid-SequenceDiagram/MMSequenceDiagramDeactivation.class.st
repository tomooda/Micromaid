Class {
	#name : 'MMSequenceDiagramDeactivation',
	#superclass : 'MMEntity',
	#instVars : [
		'name'
	],
	#category : 'Micromaid-SequenceDiagram-AST',
	#package : 'Micromaid-SequenceDiagram',
	#tag : 'AST'
}

{ #category : 'building' }
MMSequenceDiagramDeactivation >> applyToBuilder: aMMSequenceDiagramRoassalBuilder [

	aMMSequenceDiagramRoassalBuilder addDeactivation: self
]

{ #category : 'accessing' }
MMSequenceDiagramDeactivation >> name [

	^ name
]

{ #category : 'accessing' }
MMSequenceDiagramDeactivation >> name: aString [

	name := aString
]
