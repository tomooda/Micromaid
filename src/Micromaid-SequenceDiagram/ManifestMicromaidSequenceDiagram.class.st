"
This package provides sequence diagrams like below.

```mermaid
sequenceDiagram
	actor User
	participant Browser
	participant Server
	participant  Server2 as External Server
	
	User ->> Browser : open URL
	Browser ->>+ Server : GET request 1
	Server -->>- Browser : response 1
	Browser ->>+ Server : GET request 2
	Browser ->>+ Server : GET request 3
	Browser ->>+ Server2 : GET request 4
	Server -->>- Browser : response 3
	Server -->>- Browser : response 2
	Server2 -->>- Browser : response 4
	Browser ->> User : render the page
	```
"
Class {
	#name : 'ManifestMicromaidSequenceDiagram',
	#superclass : 'PackageManifest',
	#category : 'Micromaid-SequenceDiagram-Manifest',
	#package : 'Micromaid-SequenceDiagram',
	#tag : 'Manifest'
}
