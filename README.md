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

## Supported diagrams

Subsets of the following diagrams from mermaid are supported in Micromaid.

* [flowchart/graph](https://mermaid.js.org/syntax/flowchart.html)
  
  <img width="230" height="243" alt="REPL" src="https://github.com/user-attachments/assets/219400ff-6469-4004-930c-b9d641e55850" />

* [state diagram](https://mermaid.js.org/syntax/stateDiagram.html)
  
  <img width="324" height="369" alt="2-stroke" src="https://github.com/user-attachments/assets/202b3c24-2990-46a4-8de2-1c4cf4f96514" />

* [sequence diagram](https://mermaid.js.org/syntax/sequenceDiagram.html)
  
  <img width="423" height="581" alt="web-browsing" src="https://github.com/user-attachments/assets/01aa0e67-6140-49d7-a1da-9608754bcb56" />
