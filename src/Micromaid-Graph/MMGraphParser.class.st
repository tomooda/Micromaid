"
I parse a Micromaid script emitting notifications of encountered AST nodes.
"
Class {
	#name : 'MMGraphParser',
	#superclass : 'PP2CompositeNode',
	#category : 'Micromaid-Graph',
	#package : 'Micromaid-Graph'
}

{ #category : 'parsing' }
MMGraphParser >> direction [

	^ 'TB' asPParser / 'TD' asPParser / 'BT' asPParser / 'RL' asPParser
	  / 'LR' asPParser ==> [ :str |
		  MMGraphParserDirectionNotification signal: str asSymbol.
		  str asSymbol ]
]

{ #category : 'parsing' }
MMGraphParser >> edgeLabel [

	^ $| asPParser , ($| asPParser not , #any asPParser) star flatten
	  , $| asPParser ==> #second
]

{ #category : 'parsing' }
MMGraphParser >> graph [

	^ 'graph' asPParser / 'flowchart' asPParser
	  , self direction trimBlanks , #newline asPParser , self line star
]

{ #category : 'parsing' }
MMGraphParser >> head1 [

	^ '-' asPParser ==> [ :str | #none ]
	  / ('<' asPParser ==> [ :str | #arrowhead ])
	  / ('o' asPParser ==> [ :str | #circle ])
	  / ('x' asPParser ==> [ :str | #cross ])
]

{ #category : 'parsing' }
MMGraphParser >> head2 [

	^ '-' asPParser ==> [ :str | #none ]
	  / ('>' asPParser ==> [ :str | #arrowhead ])
	  / ('o' asPParser ==> [ :str | #circle ])
	  / ('x' asPParser ==> [ :str | #cross ])
]

{ #category : 'parsing' }
MMGraphParser >> line [

	^ self node trimBlanks , (self link , self node trimBlanks) optional
	  , (#newline asPParser / #eoi asPParser) ==> [ :triple |
		  | node1 |
		  node1 := triple first.
		  node1 notify.
		  triple second ifNil: [ { node1 } ] ifNotNil: [ :edgeAndNode |
				  | edge node2 |
				  edge := edgeAndNode first.
				  node2 := edgeAndNode second.
				  edge
					  node1: node1 name;
					  node2: node2 name.
				  node2 notify.
				  edge notify.
				  {
					  node1.
					  node2.
					  edge } ] ]
]

{ #category : 'parsing' }
MMGraphParser >> link [

	^ self normalLink
]

{ #category : 'parsing' }
MMGraphParser >> node [

	^ self stadiumNode / self roundedRectNode / self rhombusNode
	  / self subroutineNode / self rectNode
]

{ #category : 'parsing' }
MMGraphParser >> nodeName [

	^ (#letter asPParser / #digit asPParser) plus flatten
]

{ #category : 'parsing' }
MMGraphParser >> normalLink [

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

{ #category : 'parsing' }
MMGraphParser >> rectNode [

	^ self nodeName
	  , ($[ asPParser , ($] asPParser not , #any asPParser) star flatten
		   , $] asPParser ==> #second) optional ==> [ :pair |
		  pair second
			  ifNil: [
					  MMGraphSimpleNode new
						  name: pair first;
						  yourself ]
			  ifNotNil: [
					  MMGraphNode new
						  name: pair first;
						  label: (pair second ifNil: [ pair first ]);
						  shape: #rect;
						  yourself ] ]
]

{ #category : 'parsing' }
MMGraphParser >> rhombusNode [

	^ self nodeName
	  , (${ asPParser , ($} asPParser not , #any asPParser) star flatten
		   , $} asPParser ==> #second) ==> [ :pair |
		  MMGraphNode new
			  name: pair first;
			  label: pair second;
			  shape: #rhombus;
			  yourself ]
]

{ #category : 'parsing' }
MMGraphParser >> roundedRectNode [

	^ self nodeName
	  , ($( asPParser , ($) asPParser not , #any asPParser) star flatten
		   , $) asPParser ==> #second) ==> [ :pair |
		  MMGraphNode new
			  name: pair first;
			  label: pair second;
			  shape: #roundedRect;
			  yourself ]
]

{ #category : 'parsing' }
MMGraphParser >> stadiumNode [

	^ self nodeName
	  ,
		  ('([' asPParser
		   , ('])' asPParser not , #any asPParser) star flatten
		   , '])' asPParser ==> #second) ==> [ :pair |
		  MMGraphNode new
			  name: pair first;
			  label: pair second;
			  shape: #stadium;
			  yourself ]
]

{ #category : 'accessing' }
MMGraphParser >> start [

	^ self graph
]

{ #category : 'parsing' }
MMGraphParser >> subroutineNode [

	^ self nodeName
	  ,
		  ('[[' asPParser
		   , (']]' asPParser not , #any asPParser) star flatten
		   , ']]' asPParser ==> #second) ==> [ :pair |
		  MMGraphNode new
			  name: pair first;
			  label: pair second;
			  shape: #subroutine;
			  yourself ]
]
