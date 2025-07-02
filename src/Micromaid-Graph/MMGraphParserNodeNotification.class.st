"
I'm signaled when a MMGraphParser successfully parses a node.
"
Class {
	#name : 'MMGraphParserNodeNotification',
	#superclass : 'MMGraphParserNotification',
	#category : 'Micromaid-Graph',
	#package : 'Micromaid-Graph'
}

{ #category : 'building' }
MMGraphParserNodeNotification >> applyToBuilder: aMMGraphBuilder [

	payload ifNotNil: [ payload applyToBuilder: aMMGraphBuilder ]
]
