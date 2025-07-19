"
I am an AST of flowchart/graph script.
I can draw a flowchart or a DAG with various kinds of nodes and directed edges.
For example, a simple flowchart of a REPL interpreter can be dawn by the following script.
```text
 ```mermaid
flowchart TD
R[Read]
E[Eval]
P[Print]
A([Init]) --> R
R -->  E
E -->|quit| Q([quit])
E --> P
P --> R
 ```
```

```mermaid
flowchart TD
R[Read]
E[Eval]
P[Print]
A([Init]) --> R
R -->  E
E -->|quit| Q([quit])
E --> P
P --> R
```
"
Class {
	#name : 'MMGraph',
	#superclass : 'MMDiagram',
	#instVars : [
		'direction'
	],
	#category : 'Micromaid-Graph-AST',
	#package : 'Micromaid-Graph',
	#tag : 'AST'
}

{ #category : 'accessing' }
MMGraph >> direction [

	^ direction
]

{ #category : 'accessing' }
MMGraph >> direction: aSymbol [

	direction := aSymbol asSymbol
]

{ #category : 'enumerating' }
MMGraph >> directionDo: aBlock [

	direction ifNotNil: aBlock
]

{ #category : 'accessing' }
MMGraph >> roassalBuilder [

	| builder |
	builder := super roassalBuilder.
	self directionDo: [ :dir | builder direction: dir ].
	^ builder
]

{ #category : 'class access' }
MMGraph >> roassalBuilderClass [

	^ MMGraphRoassalBuilder
]
