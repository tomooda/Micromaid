Class {
	#name : 'MMClassDiagramMember',
	#superclass : 'MMEntity',
	#instVars : [
		'name',
		'node'
	],
	#category : 'Micromaid-ClassDiagram-AST',
	#package : 'Micromaid-ClassDiagram',
	#tag : 'AST'
}

{ #category : 'building' }
MMClassDiagramMember >> applyToBuilder: aMMClassDiagramRoassalBuilder [

	aMMClassDiagramRoassalBuilder addMember: name to: node
]

{ #category : 'accessing' }
MMClassDiagramMember >> name [

	^ name
]

{ #category : 'accessing' }
MMClassDiagramMember >> name: aString [

	name := aString
]

{ #category : 'accessing' }
MMClassDiagramMember >> node [

	^ node
]

{ #category : 'accessing' }
MMClassDiagramMember >> node: aString [

	node := aString
]
