Trait {
	#name : 'TMMGraphEntity',
	#category : 'Micromaid-Graph',
	#package : 'Micromaid-Graph'
}

{ #category : 'converting' }
TMMGraphEntity >> asNotification [

	^ self notificationClass with: self
]

{ #category : 'class access' }
TMMGraphEntity >> notificationClass [

	^ self subclassResponsibility
]

{ #category : 'notifying' }
TMMGraphEntity >> notify [

	^ self asNotification signal
]
