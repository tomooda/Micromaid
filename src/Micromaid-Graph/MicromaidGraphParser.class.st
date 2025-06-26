Class {
	#name : 'MicromaidGraphParser',
	#superclass : 'PP2CompositeNode',
	#category : 'Micromaid-Graph',
	#package : 'Micromaid-Graph'
}

{ #category : 'parsing' }
MicromaidGraphParser >> edgeLabel [

	^ $| asPParser , ($| asPParser not , #any asPParser) star flatten
	  , $| asPParser ==> #second
]

{ #category : 'parsing' }
MicromaidGraphParser >> graph [

	^ self link
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
MicromaidGraphParser >> line [

	^ self node trimBlanks , (self link , self node trimBlanks) optional
	  , (#newline asPParser / #eoi asPParser) ==> [ :triple |
		  | node1 |
		  node1 := triple first.
		  self notifyNode: node1.
		  triple second ifNil: [ { node1 } ] ifNotNil: [ :edgeAndNode |
				  | edge node2 |
				  edge := edgeAndNode first.
				  node2 := edgeAndNode second.
				  edge
					  node1: node1 name;
					  node2: node2 name.
				  self
					  notifyNode: node2;
					  notifyEdge: edge.
				  {
					  node1.
					  node2.
					  edge } ] ]
]

{ #category : 'parsing' }
MicromaidGraphParser >> link [

	^ self normalLink
]

{ #category : 'parsing' }
MicromaidGraphParser >> node [

	^ self rectNode
]

{ #category : 'parsing' }
MicromaidGraphParser >> nodeName [

	^ (#letter asPParser / #digit asPParser) plus flatten
]

{ #category : 'parsing' }
MicromaidGraphParser >> normalLink [

	^ self head1 , '-' asPParser
	  ,
		  (' ' asPParser
		   , (' --' asPParser not , #any asPParser) star flatten
		   , ' --' asPParser ==> #second) optional , $- asPParser star
	  , self head2 , self edgeLabel optional ==> [ :array |
		  MMGraphEdge new
			  label: (array third ifNil: [ array sixth ]);
			  head1: array first;
			  head2: array fifth;
			  line: #normal;
			  length: array fourth size + 1;
			  yourself ]
]

{ #category : 'notifying' }
MicromaidGraphParser >> notifyEdge: aMMGraphEdge [

	^ MMGraphEdgeNotification signal: aMMGraphEdge
]

{ #category : 'notifying' }
MicromaidGraphParser >> notifyNode: aMMGraphNode [

	^ MMGraphNodeNotification signal: aMMGraphNode
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
