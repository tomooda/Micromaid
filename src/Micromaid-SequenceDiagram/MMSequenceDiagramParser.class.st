Class {
	#name : 'MMSequenceDiagramParser',
	#superclass : 'MicromaidParser',
	#category : 'Micromaid-SequenceDiagram-AST',
	#package : 'Micromaid-SequenceDiagram',
	#tag : 'AST'
}

{ #category : 'testing' }
MMSequenceDiagramParser class >> accepts: aString [

	^ ('sequenceDiagram' asPParser parse: aString) isPetit2Success
]

{ #category : 'parsing' }
MMSequenceDiagramParser >> activation [

	^ 'activate' asPParser trimBlanks , self nodeName
	  ==> [ :pair | {MMSequenceDiagramActivation new name: pair second} ]
]

{ #category : 'parsing' }
MMSequenceDiagramParser >> actor [

	^ 'actor' asPParser trimBlanks , self nodeName ==> #second
	  , ('as' asPParser trimBlanks
		   , (self newline not , #any asPParser) star flatten ==> #second)
			  optional ==> [ :pair |
		  {MMSequenceDiagramActor new
	name: pair first;
	label: (pair second ifNil: [ pair first ]);
	yourself} ]
]

{ #category : 'parsing' }
MMSequenceDiagramParser >> deactivation [

	^ 'deactivate' asPParser trimBlanks , self nodeName
	  ==> [ :pair | {MMSequenceDiagramDeactivation new name: pair second}]
]

{ #category : 'accessing' }
MMSequenceDiagramParser >> diagram [

	^ self header , self line star ==> [ :pair |
		  MMSequenceDiagram new entities:
			  (Array streamContents: [ :stream |
				   pair second do: [ :entities | stream nextPutAll: entities ] ]) ]
]

{ #category : 'parsing' }
MMSequenceDiagramParser >> head1 [

	^ ('<<' asPParser ==> [ :str | #arrowhead ]) optional
	  ==> [ :sym | sym ifNil: [ #none ] ]
]

{ #category : 'parsing' }
MMSequenceDiagramParser >> head2 [

	^ '>>' asPParser ==> [ :str | #arrowhead ]
	  / ('>' asPParser ==> [ :str | #none ])
	  / ('x' asPParser ==> [ :str | #cross ])
	  / (')' asPParser ==> [ :str | #wedgehead ])
]

{ #category : 'accessing' }
MMSequenceDiagramParser >> header [

	^ 'sequenceDiagram' asPParser , self newline ==> #first
]

{ #category : 'accessing' }
MMSequenceDiagramParser >> line [

	^ self participant / self actor / self activation / self deactivation
	  / self message , self newline ==> #first
]

{ #category : 'parsing' }
MMSequenceDiagramParser >> linestyle [

	^ '--' asPParser ==> [ :str | #dotted ]
	  / ('-' asPParser ==> [ :str | #normal ])
]

{ #category : 'parsing' }
MMSequenceDiagramParser >> link [

	^ (self head1 , self linestyle , self head2 ==> [ :triple |
		   MMSequenceDiagramMessage new
			   head1: triple first;
			   linestyle: triple second;
			   head2: triple third;
			   yourself ]) trimBlanks
]

{ #category : 'parsing' }
MMSequenceDiagramParser >> message [

	^ self nodeName trimBlanks , self link
	  , ($+ asPParser / $- asPParser) trimBlanks optional
	  , self nodeName trimBlanks , (':' asPParser trimBlanks
	   , (self newline not , #any asPParser) plus flatten ==> #second)
	  ==> [ :array |
			  | sender message activation receiver label |
			  sender := array first.
			  message := array second.
			  activation := array third.
			  receiver := array fourth.
			  label := array fifth.
			  Array streamContents: [ :stream |
					  stream
						  nextPut: (MMSequenceDiagramSimpleParticipant new
								   name: sender;
								   yourself);
						  nextPut: (MMSequenceDiagramSimpleParticipant new
								   name: receiver;
								   yourself);
						  nextPut: (message
								   node1: sender;
								   node2: receiver;
								   label: label;
								   yourself).
					  activation = $+ ifTrue: [
						  stream nextPut:
							  (MMSequenceDiagramActivation new name: receiver) ].
					  activation = $- ifTrue: [
						  stream nextPut:
							  (MMSequenceDiagramDeactivation new name: sender) ] ] ]
]

{ #category : 'parsing' }
MMSequenceDiagramParser >> participant [

	^ 'participant' asPParser trimBlanks , self nodeName ==> #second
	  , ('as' asPParser trimBlanks
		   , (self newline not , #any asPParser) star flatten ==> #second)
			  optional ==> [ :pair |
		  {MMSequenceDiagramParticipant new
	name: pair first;
	label: (pair second ifNil: [ pair first ]);
	yourself} ]
]
