"
I am an AST of sequence diagram.
I can draw a sequence diagram.
For example, a simple interaction in web browsing can be drawn as follows.

```text
 ```mermaid
sequenceDiagram
	actor User
	participant Browser
	participant Server
	participant  Server2 as External Server
	
	User ->> Browser : open URL
	Browser ->>+ Server : GET request 1
	Server -->>- Browser : response 1
	Browser ->>+ Server : GET request 2
	Browser ->>+ Server : GET request 3
	Browser ->>+ Server2 : GET request 4
	Server -->>- Browser : response 3
	Server -->>- Browser : response 2
	Server2 -->>- Browser : response 4
	Browser ->> User : render the page
 ```
```

```mermaid
sequenceDiagram
	actor User
	participant Browser
	participant Server
	participant  Server2 as External Server
	
	User ->> Browser : open URL
	Browser ->>+ Server : GET request 1
	Server -->>- Browser : response 1
	Browser ->>+ Server : GET request 2
	Browser ->>+ Server : GET request 3
	Browser ->>+ Server2 : GET request 4
	Server -->>- Browser : response 3
	Server -->>- Browser : response 2
	Server2 -->>- Browser : response 4
	Browser ->> User : render the page
```
"
Class {
	#name : 'MMSequenceDiagram',
	#superclass : 'MMDiagram',
	#category : 'Micromaid-SequenceDiagram-AST',
	#package : 'Micromaid-SequenceDiagram',
	#tag : 'AST'
}

{ #category : 'class access' }
MMSequenceDiagram >> roassalBuilderClass [

	^ MMSequenceDiagramRoassalBuilder
]
