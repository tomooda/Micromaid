Class {
	#name : 'MMGraphParserDirectionNotification',
	#superclass : 'MMGraphParserNotification',
	#category : 'Micromaid-Graph',
	#package : 'Micromaid-Graph'
}

{ #category : 'building' }
MMGraphParserDirectionNotification >> applyToBuilder: aMMGraphBuilder [

	payload ifNotNil: [ aMMGraphBuilder direction: payload ]
]
