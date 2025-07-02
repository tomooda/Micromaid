"
I'm signaled when a MMGraphParser successfully parses an edge.
"
Class {
	#name : 'MMGraphParserEdgeNotification',
	#superclass : 'MMGraphParserNotification',
	#category : 'Micromaid-Graph',
	#package : 'Micromaid-Graph'
}

{ #category : 'building' }
MMGraphParserEdgeNotification >> applyToBuilder: aMMGraphBuilder [

	payload ifNotNil: [ payload applyToBuilder: aMMGraphBuilder ]
]
