"
I am an AST of state diagram.
I can draw a state diagram.
For example, a simple explanation of 2-stroke engines can be drawn as follows.

```text
 ```mermaid
stateDiagram
state ""Intake/scavenging"" as A
state ""Exhaust"" as B
state ""Compression"" as C
state ""Combustion"" as D
[*] --> A : kick start
A --> B
B --> C
C --> D
D --> A
C --> [*] : ignition off
 ```
```

```mermaid
stateDiagram
state ""Intake/scavenging"" as A
state ""Exhaust"" as B
state ""Compression"" as C
state ""Combustion"" as D
[*] --> A : kick start
A --> B
B --> C
C --> D
D --> A
C --> [*] : ignition off
```
"
Class {
	#name : 'MMStateDiagram',
	#superclass : 'MMDiagram',
	#category : 'Micromaid-StateDiagram-AST',
	#package : 'Micromaid-StateDiagram',
	#tag : 'AST'
}

{ #category : 'class access' }
MMStateDiagram >> roassalBuilderClass [

	^ MMStateDiagramRoassalBuilder
]
