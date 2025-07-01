# Micromaid
A simple Mermaid-like chart generator for Pharo
You can draw something like this.

![micromaid-REPL](https://github.com/user-attachments/assets/0c4ef391-9ef8-4a38-bdd8-aee92574a953)

BTW, Mermaid will render it like the below.

```mermaid
flowchart TD
R[Read]
E[[Eval]]
P[Print]
Init([initialization])-->R
R-->E
E-->P
E-->|quit|Quit([finalize and quit])
P-->R
EVAL([Eval])-->MAGIC(COMPLEX MAGIC!)
```

The source is

```
flowchart TD
R[Read]
E[[Eval]]
P[Print]
Init([initialization])-->R
R-->E
E-->P
E-->|quit|Quit([finalize and quit])
P-->R
EVAL([Eval])-->MAGIC(COMPLEX MAGIC!)
```
