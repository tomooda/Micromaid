# Micromaid
Micromaid is a small subset of [Mermaid](https://mermaid.live/) for Pharo 13 and later.

## Viewing mermaid diagrams embedded in markdown documents on Pharo

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

<img width="678" height="600" alt="document-browser" src="https://github.com/user-attachments/assets/fb8cb987-50f9-4432-886d-1bf0634c405b" />

## Embedding micromaid diagrams in Microdown documents

You can embed a micromaid script in [Microdown](https://github.com/pillar-markup/Microdown) documents, including class comments.
For example, if your class has a comment as below,

````text
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
````
you'll have the following presentation on the browser.

<img width="650" height="547" alt="class-comment" src="https://github.com/user-attachments/assets/c2b6e307-7a81-4bed-ac0c-06e415180b26" />

## Authoring Micromaid/Mermaid scripts with Spec UI

`MicromaidLiveEditorPresenter` provides the following UI for live authoring.

<img width="817" height="487" alt="live-authoring" src="https://github.com/user-attachments/assets/0497f4f0-b3b4-4eb9-aba1-afb446476ef1" />

The diagram on the right will be update as you type in the left source pane.
