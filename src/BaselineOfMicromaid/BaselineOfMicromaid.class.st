Class {
	#name : 'BaselineOfMicromaid',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfMicromaid',
	#package : 'BaselineOfMicromaid'
}

{ #category : 'baselines' }
BaselineOfMicromaid >> baseline: spec [

	<baseline>
	spec
		baseline: 'PetitParser2Core'
		with: [ spec repository: 'github://kursjan/petitparser2:master' ].
	spec for: #common do: [
			spec
				package: 'Micromaid-Base'
				with: [ spec requires: #( 'PetitParser2Core' ) ];
				package: 'Micromaid-Graph'
				with: [ spec requires: #( 'Micromaid-Base' ) ];
				package: 'Micromaid-StateDiagram'
				with: [ spec requires: #( 'Micromaid-Base' ) ];
				package: 'Micromaid-Spec'
				with: [ spec requires: #( 'Micromaid-Base' ) ].
			spec
				group: 'default'
				with:
				#( 'Micromaid-Base' 'Micromaid-Graph' 'Micromaid-StateDiagram''Micromaid-Spec' ) ]
]
