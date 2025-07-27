"
This package provides Flowchart-like directed graphs like the below.

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
	#name : 'ManifestMicromaidGraph',
	#superclass : 'PackageManifest',
	#category : 'Micromaid-Graph-Manifest',
	#package : 'Micromaid-Graph',
	#tag : 'Manifest'
}
