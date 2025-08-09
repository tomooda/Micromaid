Extension { #name : 'String' }

{ #category : '*Micromaid-Base' }
String >> openMicromaid [

	^ self openMicromaidWithTitle: 'Micromaid'
]

{ #category : '*Micromaid-Base' }
String >> openMicromaidBuilderWith: aBlock title: aString [

	^ (MicromaidParser parse: self) ifNotNil: [ :diagram |
		  diagram roassalBuilderWith: aBlock openWithTitle: aString ]
]

{ #category : '*Micromaid-Base' }
String >> openMicromaidWithTitle: aString [

	^ self openMicromaidBuilderWith: [ :builder |  ] title: aString
]
