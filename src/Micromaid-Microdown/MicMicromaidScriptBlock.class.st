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
 
You can also specify the extent of the image like

```language=text
 ```mermaid|extent=100@150
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
```mermaid|extent=100@150
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
