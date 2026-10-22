Extension { #name : 'PP2Node' }

{ #category : '*Micromaid-Base' }
PP2Node >> string [

	^ self ==> [ :result |
		  (result isCollection and: [ result isString not ])
			  ifTrue: [ String withAll: (result flattened select: #isCharacter) ]
			  ifFalse: [ result ] ]
]
