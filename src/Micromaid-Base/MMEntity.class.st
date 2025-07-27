"
I am an abstract class that represents an AST node of each line (or statement) in Micromaid scripts.
Micromaid statements can be roughly categorized into three gropups: nodes, edges, and directives.

My subclass should implement the `applyToBuilder:` method.
My instances are stored in a `MMDiagram` and a `MMRoassalBuilder` will dispatch the method in order.
"
Class {
	#name : 'MMEntity',
	#superclass : 'Object',
	#category : 'Micromaid-Base-AST',
	#package : 'Micromaid-Base',
	#tag : 'AST'
}

{ #category : 'building' }
MMEntity >> applyToBuilder: aMMRoassalBuilder [

	^ self subclassResponsibility
]
