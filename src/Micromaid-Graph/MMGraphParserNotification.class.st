"
I am a notification from the MMGraphParser that tells the builder that the parser encounterd corresponding kind of AST node.
"
Class {
	#name : 'MMGraphParserNotification',
	#superclass : 'Notification',
	#instVars : [
		'payload'
	],
	#category : 'Micromaid-Graph',
	#package : 'Micromaid-Graph'
}

{ #category : 'instance creation' }
MMGraphParserNotification class >> signal: anObject [

	^ (self with: anObject) signal
]

{ #category : 'instance creation' }
MMGraphParserNotification class >> with: anObject [

	^ self new
		  payload: anObject;
		  yourself
]

{ #category : 'building' }
MMGraphParserNotification >> applyToBuilder: aMMGraphBuilder [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
MMGraphParserNotification >> payload [

	^ payload
]

{ #category : 'accessing' }
MMGraphParserNotification >> payload: anObject [

	payload := anObject
]
