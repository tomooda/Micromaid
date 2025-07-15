"
I parse a Micromaid script emitting notifications of encountered AST nodes.
"
Class {
	#name : 'MMGraphParser',
	#superclass : 'MicromaidParser',
	#category : 'Micromaid-Graph-AST',
	#package : 'Micromaid-Graph',
	#tag : 'AST'
}

{ #category : 'testing' }
MMGraphParser class >> accepts: aString [

	^ ('flowchart' asPParser / 'graph' asPParser , #blank asPParser
		   parse: aString) isPetit2Success
]

{ #category : 'parsing-shapes' }
MMGraphParser >> asymmetricNode [

	^ self nodeName
	  , ($> asPParser , ($] asPParser not , #any asPParser) star flatten
		   , $] asPParser ==> #second) ==> [ :pair |
		  MMGraphNode new
			  name: pair first;
			  label: pair second;
			  shape: #asymmetric;
			  yourself ]
]

{ #category : 'parsing-shapes' }
MMGraphParser >> circleNode [

	^ self nodeName
	  ,
		  ('((' asPParser
		   , ('))' asPParser not , #any asPParser) star flatten
		   , '))' asPParser ==> #second) ==> [ :pair |
		  MMGraphNode new
			  name: pair first;
			  label: pair second;
			  shape: #circle;
			  yourself ]
]

{ #category : 'parsing-shapes' }
MMGraphParser >> cylinderNode [

	^ self nodeName
	  ,
		  ('[(' asPParser
		   , (')]' asPParser not , #any asPParser) star flatten
		   , ')]' asPParser ==> #second) ==> [ :pair |
		  MMGraphNode new
			  name: pair first;
			  label: pair second;
			  shape: #cylinder;
			  yourself ]
]

{ #category : 'parsing' }
MMGraphParser >> diagram [

	^ 'graph' asPParser / 'flowchart' asPParser
	  , self direction trimBlanks , #newline asPParser , self line star
	  ==> [ :quartet |
			  MMGraph new
				  direction: quartet second;
				  entities: (Array streamContents: [ :stream |
							   quartet fourth do: [ :entities |
									   stream nextPutAll: entities ] ]);
				  yourself ]
]

{ #category : 'parsing' }
MMGraphParser >> direction [

	^ 'TB' asPParser / 'TD' asPParser / 'BT' asPParser / 'RL' asPParser
	  / 'LR' asPParser ==> [ :str | str asSymbol ]
]

{ #category : 'parsing-shapes' }
MMGraphParser >> doubleCircleNode [

	^ self nodeName
	  ,
		  ('(((' asPParser
		   , (')))' asPParser not , #any asPParser) star flatten
		   , ')))' asPParser ==> #second) ==> [ :pair |
		  MMGraphNode new
			  name: pair first;
			  label: pair second;
			  shape: #doubleCircle;
			  yourself ]
]

{ #category : 'parsing' }
MMGraphParser >> edgeLabel [

	^ $| asPParser , ($| asPParser not , #any asPParser) star flatten
	  , $| asPParser ==> #second
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

{ #category : 'parsing-shapes' }
MMGraphParser >> hexagonNode [

	^ self nodeName
	  ,
		  ('{{' asPParser
		   , ('}}' asPParser not , #any asPParser) star flatten
		   , '}}' asPParser ==> #second) ==> [ :pair |
		  MMGraphNode new
			  name: pair first;
			  label: pair second;
			  shape: #hexagon;
			  yourself ]
]

{ #category : 'parsing' }
MMGraphParser >> line [

	^ self node trimBlanks , (self link , self node trimBlanks) optional
	  , (#newline asPParser / #eoi asPParser) ==> [ :triple |
		  | node1 |
		  node1 := triple first.
		  triple second ifNil: [ { node1 } ] ifNotNil: [ :edgeAndNode |
				  | edge node2 |
				  edge := edgeAndNode first.
				  node2 := edgeAndNode second.
				  edge
					  node1: node1 name;
					  node2: node2 name.
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

	^ self stadiumNode / self cylinderNode / self doubleCircleNode
	  / self circleNode / self roundedRectNode / self hexagonNode
	  / self rhombusNode / self parallelogramNode
	  / self parallelogramAltNode / self trapezoidNode
	  / self trapezoidAltNode / self subroutineNode / self asymmetricNode
	  / self rectNode
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

{ #category : 'parsing-shapes' }
MMGraphParser >> parallelogramAltNode [

	^ self nodeName
	  ,
		  ('[\' asPParser
		   , ('\]' asPParser not , #any asPParser) star flatten
		   , '\]' asPParser ==> #second) ==> [ :pair |
		  MMGraphNode new
			  name: pair first;
			  label: pair second;
			  shape: #parallelogramAlt;
			  yourself ]
]

{ #category : 'parsing-shapes' }
MMGraphParser >> parallelogramNode [

	^ self nodeName
	  ,
		  ('[/' asPParser
		   , ('/]' asPParser not , #any asPParser) star flatten
		   , '/]' asPParser ==> #second) ==> [ :pair |
		  MMGraphNode new
			  name: pair first;
			  label: pair second;
			  shape: #parallelogram;
			  yourself ]
]

{ #category : 'parsing-shapes' }
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

{ #category : 'parsing-shapes' }
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

{ #category : 'parsing-shapes' }
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

{ #category : 'parsing-shapes' }
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

	^ self diagram
]

{ #category : 'parsing-shapes' }
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

{ #category : 'parsing-shapes' }
MMGraphParser >> trapezoidAltNode [

	^ self nodeName
	  ,
		  ('[\' asPParser
		   , ('/]' asPParser not , #any asPParser) star flatten
		   , '/]' asPParser ==> #second) ==> [ :pair |
		  MMGraphNode new
			  name: pair first;
			  label: pair second;
			  shape: #trapezoidAlt;
			  yourself ]
]

{ #category : 'parsing-shapes' }
MMGraphParser >> trapezoidNode [

	^ self nodeName
	  ,
		  ('[/' asPParser
		   , ('\]' asPParser not , #any asPParser) star flatten
		   , '\]' asPParser ==> #second) ==> [ :pair |
		  MMGraphNode new
			  name: pair first;
			  label: pair second;
			  shape: #trapezoid;
			  yourself ]
]
