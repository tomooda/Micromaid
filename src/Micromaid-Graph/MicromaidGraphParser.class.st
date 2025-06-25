Class {
	#name : 'MicromaidGraphParser',
	#superclass : 'PP2CompositeNode',
	#category : 'Micromaid-Graph',
	#package : 'Micromaid-Graph'
}

{ #category : 'parsing' }
MicromaidGraphParser >> edge [

	^ self normalEdge
]

{ #category : 'parsing' }
MicromaidGraphParser >> graph [

	^ self edge
]

{ #category : 'parsing' }
MicromaidGraphParser >> head1 [

	^ '-' asPParser ==> [ :str | #none ]
	  / ('<' asPParser ==> [ :str | #arrowhead ])
	  / ('o' asPParser ==> [ :str | #circle ])
	  / ('x' asPParser ==> [ :str | #cross ])
]

{ #category : 'parsing' }
MicromaidGraphParser >> head2 [

	^ '-' asPParser ==> [ :str | #none ]
	  / ('>' asPParser ==> [ :str | #arrowhead ])
	  / ('o' asPParser ==> [ :str | #circle ])
	  / ('x' asPParser ==> [ :str | #cross ])
]

{ #category : 'parsing' }
MicromaidGraphParser >> linkLabel [

	^ $| asPParser , ($| asPParser not , #any asPParser) star flatten
	  , $| asPParser ==> #second
]

{ #category : 'parsing' }
MicromaidGraphParser >> nodeName [

	^ (#letter asPParser / #digit asPParser) plus flatten
]

{ #category : 'parsing' }
MicromaidGraphParser >> normalEdge [

	^ self head1 , '-' asPParser
	  ,
		  (' ' asPParser
		   , (' --' asPParser not , #any asPParser) star flatten
		   , ' --' asPParser ==> #second) optional , $- asPParser star
	  , self head2 , self linkLabel optional ==> [ :array |
		  MMGraphEdge new
			  label: (array third ifNil: [ array sixth ]);
			  head1: array first;
			  head2: array fifth;
			  line: #normal;
			  length: array fourth size + 1;
			  yourself ]
]

{ #category : 'parsing' }
MicromaidGraphParser >> rectNode [

	^ self nodeName
	  , ($[ asPParser , ($] asPParser not , #any asPParser) star flatten
		   , $] asPParser ==> #second) optional ==> [ :pair |
		  MMGraphNode new
			  name: pair first;
			  label: (pair second ifNil: [ pair first ]);
			  yourself ]
]

{ #category : 'accessing' }
MicromaidGraphParser >> start [

	^ self graph
]
