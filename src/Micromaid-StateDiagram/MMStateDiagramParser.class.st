Class {
	#name : 'MMStateDiagramParser',
	#superclass : 'MicromaidParser',
	#category : 'Micromaid-StateDiagram-AST',
	#package : 'Micromaid-StateDiagram',
	#tag : 'AST'
}

{ #category : 'testing' }
MMStateDiagramParser class >> accepts: aString [

	^ ('stateDiagram' asPParser , '-v2' asPParser optional parse: aString)
		  isPetit2Success
]

{ #category : 'parsing' }
MMStateDiagramParser >> arrow [

	^ '-->' asPParser trimBlanks
]

{ #category : 'parsing' }
MMStateDiagramParser >> diagram [

	^ self header , self line star ==> [ :pair |
		  MMStateDiagram new
			  entities: (Array streamContents: [ :stream |
						   pair second do: [ :entities | stream nextPutAll: entities ] ]);
			  yourself ]
]

{ #category : 'parsing' }
MMStateDiagramParser >> header [

	^ ('stateDiagram' asPParser , '-v2' asPParser optional) flatten
		  trimBlanks , self newline ==> #first
]

{ #category : 'parsing' }
MMStateDiagramParser >> line [

	^ self transition / (self state ==> [ :s | { s } ]) , self newline
	  ==> #first
]

{ #category : 'parsing' }
MMStateDiagramParser >> simpleState [

	^ self nodeName trimBlanks ==> [ :name |
		  MMStateDiagramSimpleState new
			  name: name;
			  yourself ]
]

{ #category : 'parsing' }
MMStateDiagramParser >> startState [

	^ '[*]' asPParser trimBlanks
	  ==> [ :star | MMStateDiagramStartState new ]
]

{ #category : 'parsing' }
MMStateDiagramParser >> state [

	^ self stateAs / self stateWithLabel / self simpleState
]

{ #category : 'parsing' }
MMStateDiagramParser >> stateAs [

	^ 'state' asPParser trimBlanks , $" asPParser
	  , ($" asPParser not , #any asPParser) star flatten , $" asPParser
	  , 'as' asPParser trimBlanks , self nodeName ==> [ :array |
		  MMStateDiagramState new
			  label: array third;
			  name: array sixth;
			  yourself ]
]

{ #category : 'parsing' }
MMStateDiagramParser >> stateWithLabel [

	^ self nodeName trimBlanks , $: asPParser trimBlanks
	  ,
		  ((#newline asPParser / #eoi asPParser) not , #any asPParser) plus
			  flatten ==> [ :triple |
		  MMStateDiagramState new
			  name: triple first;
			  label: triple third;
			  yourself ]
]

{ #category : 'parsing' }
MMStateDiagramParser >> stopState [

	^ '[*]' asPParser trimBlanks
	  ==> [ :star | MMStateDiagramStopState new ]
]

{ #category : 'parsing' }
MMStateDiagramParser >> transition [

	^ self simpleState / self startState , self arrow
	  , (self simpleState / self stopState) , ($: asPParser trimBlanks
	   ,
		   ((#newline asPParser / #eoi asPParser) not , #any asPParser) star
			   flatten ==> #second) optional ==> [ :quartet |
		  {
			  quartet first.
			  quartet third.
			  (MMStateDiagramTransition new
				   node1: quartet first name;
				   node2: quartet third name;
				   label: quartet fourth;
				   yourself) } ]
]
