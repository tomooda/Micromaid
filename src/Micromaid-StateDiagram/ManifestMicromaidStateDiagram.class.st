"
This package provides state diagram like below

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
	#name : 'ManifestMicromaidStateDiagram',
	#superclass : 'PackageManifest',
	#category : 'Micromaid-StateDiagram-Manifest',
	#package : 'Micromaid-StateDiagram',
	#tag : 'Manifest'
}
