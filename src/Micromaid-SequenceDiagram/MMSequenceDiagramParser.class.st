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

	^ self participant / self actor / self message , self newline
	  ==> #first
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

	^ self nodeName trimBlanks , self link , self nodeName trimBlanks
	  , (':' asPParser trimBlanks
		   , (self newline not , #any asPParser) plus flatten ==> #second)
	  ==> [ :quartet |
			  {
				  (MMSequenceDiagramSimpleParticipant new
					   name: quartet first;
					   yourself).
				  (MMSequenceDiagramSimpleParticipant new
					   name: quartet third;
					   yourself).
				  (quartet second
					   node1: quartet first;
					   node2: quartet third;
					   label: quartet fourth;
					   yourself) } ]
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
