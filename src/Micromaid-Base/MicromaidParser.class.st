Class {
	#name : 'MicromaidParser',
	#superclass : 'PP2CompositeNode',
	#category : 'Micromaid-Base-AST',
	#package : 'Micromaid-Base',
	#tag : 'AST'
}

{ #category : 'testing' }
MicromaidParser class >> accepts: aString [

	^ self subclassResponsibility
]

{ #category : 'examples' }
MicromaidParser class >> exampleFlowchart [

	(MicromaidParser parse: 'flowchart TD
R[Read]
E[Eval]
P[Print]
A([Init]) --> R
R -->  E
E -->|quit| Q([quit])
E --> P
P --> R
') roassalBuilder ifNotNil: [ :builder |
			builder build
				zoomToFit;
				open ]
]

{ #category : 'examples' }
MicromaidParser class >> exampleGraph [

	(MicromaidParser parse: 'graph TD
    A[Christmas] -->|Get money| B(Go shopping)
    B --> C{Let me think}
    C -->|One| D[Laptop]
    C -->|Two| E[iPhone]
    C -->|Three| F[Car]
    G([stadium スタジアム])
    H[[subroutine サブルーチン]]
    G x-o|cross and circle heads| H') roassalBuilder ifNotNil: [
			:builder |
			builder build
				zoomToFit;
				open ]
]

{ #category : 'testing' }
MicromaidParser class >> isAbstract [

	^ self = MicromaidParser
]

{ #category : 'parsing' }
MicromaidParser class >> parse: aString [

	self allSubclassesDo: [ :subclass |
			(subclass isAbstract not and: [ subclass accepts: aString ])
				ifTrue: [
						| ast |
						ast := subclass new parse: aString.
						ast isPetit2Success ifTrue: [ ^ ast ] ] ].
	^ nil
]

{ #category : 'accessing' }
MicromaidParser >> diagram [

	^ self subclassResponsibility
]

{ #category : 'instance creation' }
MicromaidParser >> newline [

	^ #newline asPParser trimBlanks star , #eoi asPParser trimBlanks
	  / #newline asPParser trimBlanks plus ==> [ :array | nil ]
]

{ #category : 'parsing' }
MicromaidParser >> nodeName [

	^ (#letter asPParser , (#letter asPParser / #digit asPParser) star)
		  flatten trimBlanks
]

{ #category : 'accessing' }
MicromaidParser >> start [

	^ self diagram
]
