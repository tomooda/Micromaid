# Micromaid
Micromaid is a small subset of [Mermaid](https://mermaid.live/) for Pharo 13 and later.

## Viewいんg mermaid diagrams embedded in markdown documents on Pharo

The following is the REPL flowchart embedded as a mermaid script.

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

On Pharo, you can view this document like the below.


## Embedding micromaid diagrams in Microdown documents

You can embed a micromaid script in [Microdown](https://github.com/pillar-markup/Microdown) documents, including class comments.
For example, if your class has a comment as below,

```text
I am a REPL interpreter.
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
you'll have the following presentation on the browser.
<img width="650" height="547" alt="class-comment" src="https://github.com/user-attachments/assets/c2b6e307-7a81-4bed-ac0c-06e415180b26" />
