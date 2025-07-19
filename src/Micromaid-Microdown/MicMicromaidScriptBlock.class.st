"
I am a block containing a mermaid script.

A script showing my visitors:
```language=text
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
Gives:
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
	#name : 'MicMicromaidScriptBlock',
	#superclass : 'MicScriptBlock',
	#category : 'Micromaid-Microdown',
	#package : 'Micromaid-Microdown'
}

{ #category : 'accessing' }
MicMicromaidScriptBlock class >> tag [

	^ #mermaid
]

{ #category : 'visiting' }
MicMicromaidScriptBlock >> accept: aVisitor [
	aVisitor visitMicromaidScript: self 
]
