Class {
	#name : 'MMGraphNodeNotification',
	#superclass : 'Notification',
	#instVars : [
		'node'
	],
	#category : 'Micromaid-Graph',
	#package : 'Micromaid-Graph'
}

{ #category : 'accessing' }
MMGraphNodeNotification >> node [

	^ node
]

{ #category : 'accessing' }
MMGraphNodeNotification >> node: aMMGraphNode [

	node := aMMGraphNode
]

{ #category : 'signaling' }
MMGraphNodeNotification >> signal: aMMGraphNode [

	node := aMMGraphNode.
	^ self signal
]
