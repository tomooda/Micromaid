Class {
	#name : 'MMMermaidInkClient',
	#superclass : 'Object',
	#instVars : [
		'baseUrl'
	],
	#category : 'Micromaid-Client',
	#package : 'Micromaid-Client'
}

{ #category : 'examples' }
MMMermaidInkClient class >> exampleCollection [

	(self imageFrom: 'classDiagram
	class Collection {
		<<abstract>>
		%% methods
		<<abstract>> size () : Integer
		<<abstract>> do: (BlockClosure)
		collect: (BlockClosure)
	}
	class SequenceableCollection { 
		<<abstract>> 
		%% methods
		<<abstract>> at: (Integer) : Object
		<<abstract>> at:put: (Integer, Object) : Object
		do: (BlockClosure)
	}
	class Array {
		<<variable>>
		%% methods
		<<primitive>> at: (Integer) : Object
		<<primitive>> at:put: (Integer, Object) : Object
		<<primitive>> size () : Integer
	}
	class OrderedCollection {
		array : Array
		firstIndex : Integer
		lastIndex : Integer
		%% methods
		at: (Integer) : Object
		at:put: (Integer, Object) : Object
		size () : Integer
		- compact ()
	}
	class Set { 
		tally : Integer
		array : Array
		%% methods
		size () : Integer
		do: (BlockClosure)
		-rehash ()
	}
	Collection <|-- SequenceableCollection
	SequenceableCollection <|-- Array
	SequenceableCollection <|-- OrderedCollection
	Collection <|-- Set
	Array <.. OrderedCollection : internal containter
	Array <.. Set : hash table') asPresenter
		autoScale: true;
		open
]

{ #category : 'utilities' }
MMMermaidInkClient class >> imageFrom: aString [

	^ self new imageFrom: aString
]

{ #category : 'instance creation' }
MMMermaidInkClient class >> mermaidInk [

	^ self new
]

{ #category : 'utilities' }
MMMermaidInkClient class >> svgFrom: aString [

	^ self new svgFrom: aString
]

{ #category : 'accessing' }
MMMermaidInkClient >> baseUrl [

	^ baseUrl ifNil: [ baseUrl := self defaultBaseUrl ]
]

{ #category : 'accessing' }
MMMermaidInkClient >> baseUrl: aZnUrl [

	baseUrl := aZnUrl asZnUrl
]

{ #category : 'defaults' }
MMMermaidInkClient >> defaultBaseUrl [

	^ 'https://mermaid.ink/' asZnUrl
]

{ #category : 'accessing' }
MMMermaidInkClient >> imageFrom: aString [

	^ ZnEasy getPng:
		  (self baseUrl / 'img' / (self pakoEncode: aString trim)
			   withQuery: 'type' -> 'png')
]

{ #category : 'encoding - decoding' }
MMMermaidInkClient >> pakoEncode: aString [

	| json zipped pako |
	json := STONJSON toString: { ('code' -> aString) } asDictionary.
	zipped := ByteArray streamContents: [ :stream |
			          (ZLibWriteStream on: stream)
				          nextPutAll: json utf8Encoded;
				          close ].
	pako := zipped base64Encoded.
	pako := pako copyReplaceAll: '/' with: '_'.
	pako := pako copyReplaceAll: '+' with: '-'.
	[ pako last = $= ] whileTrue: [ pako := pako allButLast ].
	^ 'pako:' , pako
]

{ #category : 'accessing' }
MMMermaidInkClient >> svgFrom: aString [

	^ (ZnEasy get: self baseUrl / 'svg' / (self pakoEncode: aString))
		  contents
]
