Extension { #name : 'String' }

{ #category : '*Micromaid-Base' }
String >> openMicromaid [

	^ self openMicromaidWithTitle: 'Micromaid'
]

{ #category : '*Micromaid-Base' }
String >> openMicromaidWithTitle: aString [

	^ (MicromaidParser parse: self) ifNotNil: [ :diagram |
		  diagram openWithTitle: aString ]
]
