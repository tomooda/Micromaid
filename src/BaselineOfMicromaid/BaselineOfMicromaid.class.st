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
				package: 'Micromaid-Graph'
				with: [ spec requires: #( 'PetitParser2Core' ) ];
				package: 'Micromaid-Spec'
				with: [ spec requires: #( 'Micromaid-Graph' ) ];
				package: 'Micromaid-Tests'
				with: [ spec requires: #( 'Micromaid-Graph' ) ].
			spec
				group: 'default'
				with: #( 'Micromaid-Graph' 'Micromaid-Tests' ) ]
]
