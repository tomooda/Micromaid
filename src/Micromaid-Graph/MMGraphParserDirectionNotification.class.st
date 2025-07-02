"
I'm signaled when a MMGraphParser successfully parses a direction of the diagram.
"
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
