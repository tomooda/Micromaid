"
This package provides class diagram to Micromaid, like the below.
```mermaid
classDiagram
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
```
"
Class {
	#name : 'ManifestMicromaidClassDiagram',
	#superclass : 'PackageManifest',
	#category : 'Micromaid-ClassDiagram-Manifest',
	#package : 'Micromaid-ClassDiagram',
	#tag : 'Manifest'
}
