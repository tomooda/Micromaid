Class {
	#name : 'MMGraphEdgeNotification',
	#superclass : 'Notification',
	#instVars : [
		'edge'
	],
	#category : 'Micromaid-Graph',
	#package : 'Micromaid-Graph'
}

{ #category : 'accessing' }
MMGraphEdgeNotification >> edge [

	^ edge
]

{ #category : 'accessing' }
MMGraphEdgeNotification >> edge: aMMGraphEdge [

	edge := aMMGraphEdge
]

{ #category : 'signaling' }
MMGraphEdgeNotification >> signal: aMMGraphEdge [

	edge := aMMGraphEdge.
	^ self signal
]
