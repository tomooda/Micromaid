Class {
	#name : 'MMSequenceDiagramActivation',
	#superclass : 'MMEntity',
	#instVars : [
		'name'
	],
	#category : 'Micromaid-SequenceDiagram-AST',
	#package : 'Micromaid-SequenceDiagram',
	#tag : 'AST'
}

{ #category : 'building' }
MMSequenceDiagramActivation >> applyToBuilder: aMMSequenceDiagramRoassalBuilder [

	^ aMMSequenceDiagramRoassalBuilder addActivation: self
]

{ #category : 'accessing' }
MMSequenceDiagramActivation >> name [

	^ name
]

{ #category : 'accessing' }
MMSequenceDiagramActivation >> name: aString [

	name := aString
]
