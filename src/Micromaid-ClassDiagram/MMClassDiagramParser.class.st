Class {
	#name : 'MMClassDiagramParser',
	#superclass : 'MicromaidParser',
	#category : 'Micromaid-ClassDiagram-AST',
	#package : 'Micromaid-ClassDiagram',
	#tag : 'AST'
}

{ #category : 'testing' }
MMClassDiagramParser class >> accepts: aString [

	^ ('classDiagram' asPParser parse: aString) isPetit2Success
]

{ #category : 'parsing - arrows' }
MMClassDiagramParser >> aggregation [

	^ self nodeName , 'o--' asPParser ==> #first , self nodeName
	  , ($: asPParser trimBlanks
		   , (self newline not , #any asPParser) star flatten ==> #second)
			  optional ==> [ :triple |
		  MMClassDiagramAggregation new
			  node1: triple first;
			  node2: triple second;
			  label: triple third;
			  yourself ]
	  / (self nodeName , '--o' asPParser ==> #first , self nodeName
		   , ($: asPParser trimBlanks
			    , (self newline not , #any asPParser) star flatten ==> #second)
				   optional ==> [ :triple |
			   MMClassDiagramAggregation new
				   node1: triple second;
				   node2: triple first;
				   label: triple third;
				   yourself ])
]

{ #category : 'parsing' }
MMClassDiagramParser >> annotation [

	^ '<<' asPParser trimBlanks
	  ,
	  (('>>' asPParser / self newline) not , #any asPParser) star flatten
	  , '>>' asPParser trimBlanks , self newline and ==> [ :triple |
	  MMClassDiagramAnnotation new annotation: triple second trim ]
]

{ #category : 'parsing - arrows' }
MMClassDiagramParser >> arrow [

	^ self inheritance / self composition / self aggregation
	  / self association / self dependency / self realization
	  / self solidLink / self dashedLink
]

{ #category : 'parsing - arrows' }
MMClassDiagramParser >> association [

	^ self nodeName , '<--' asPParser ==> #first , self nodeName
	  , ($: asPParser trimBlanks
		   , (self newline not , #any asPParser) star flatten ==> #second)
			  optional ==> [ :triple |
		  MMClassDiagramAssociation new
			  node1: triple first;
			  node2: triple second;
			  label: triple third;
			  yourself ]
	  / (self nodeName , '-->' asPParser ==> #first , self nodeName
		   , ($: asPParser trimBlanks
			    , (self newline not , #any asPParser) star flatten ==> #second)
				   optional ==> [ :triple |
			   MMClassDiagramAssociation new
				   node1: triple second;
				   node2: triple first;
				   label: triple third;
				   yourself ])
]

{ #category : 'parsing' }
MMClassDiagramParser >> beginAttributes [

	^ '%%' asPParser trimBlanks
	  , ('attributes' asPParser / 'variables' asPParser) trimBlanks
	  ==> [ :array | MMClassDiagramBeginAttributes new ]
]

{ #category : 'parsing' }
MMClassDiagramParser >> beginClass [

	^ 'class' asPParser trimBlanks , self nodeName ==> #second
	  ,
		  ('["' asPParser
		   , ('"]' asPParser not , #any asPParser) plus flatten
		   , '"]' asPParser ==> #second) optional
	  , ('<<' asPParser trimBlanks
		   , ('>>' asPParser not , #any asPParser) star flatten
		   , '>>' asPParser trimBlanks ==> [ :triple | triple second trim ])
			  star , ${ asPParser trimBlanks ==> [ :quartet |
		  MMClassDiagramBeginClass new
			  name: quartet first;
			  label: quartet second;
			  annotations: quartet third;
			  yourself ]
]

{ #category : 'parsing' }
MMClassDiagramParser >> beginOperations [

	^ '%%' asPParser trimBlanks
	  , ('operations' asPParser / 'methods' asPParser) trimBlanks
	  ==> [ :array | MMClassDiagramBeginOperations new ]
]

{ #category : 'parsing' }
MMClassDiagramParser >> classDeclaration [

	^ 'class' asPParser trimBlanks , self nodeName ==> #second
	  ,
		  ('["' asPParser
		   , ('"]' asPParser not , #any asPParser) plus flatten
		   , '"]' asPParser ==> #second) optional
	  , ('<<' asPParser trimBlanks
		   , ('>>' asPParser not , #any asPParser) star flatten
		   , '>>' asPParser trimBlanks ==> [ :triple | triple second trim ])
			  star ==> [ :triple |
		  MMClassDiagramClass new
			  name: triple first;
			  label: triple second;
			  annotations: triple third;
			  yourself ]
]

{ #category : 'parsing' }
MMClassDiagramParser >> classDefinition [

	^ self beginClass , self newline ==> #first , self lineInClass star
	  , self endClass
	  ==> [ :triple |
	  { triple first } , triple second , { triple third } ]
]

{ #category : 'parsing - arrows' }
MMClassDiagramParser >> composition [

	^ self nodeName , '*--' asPParser ==> #first , self nodeName
	  , ($: asPParser trimBlanks
		   , (self newline not , #any asPParser) star flatten ==> #second)
			  optional ==> [ :triple |
		  MMClassDiagramComposition new
			  node1: triple first;
			  node2: triple second;
			  label: triple third;
			  yourself ]
	  / (self nodeName , '--*' asPParser ==> #first , self nodeName
		   , ($: asPParser trimBlanks
			    , (self newline not , #any asPParser) star flatten ==> #second)
				   optional ==> [ :triple |
			   MMClassDiagramComposition new
				   node1: triple second;
				   node2: triple first;
				   label: triple third;
				   yourself ])
]

{ #category : 'parsing - arrows' }
MMClassDiagramParser >> dashedLink [

	^ self nodeName , '..' asPParser ==> #first , self nodeName
	  , ($: asPParser trimBlanks
		   , (self newline not , #any asPParser) star flatten ==> #second)
			  optional ==> [ :triple |
		  MMClassDiagramDashedLink new
			  node1: triple first;
			  node2: triple second;
			  label: triple third;
			  yourself ]
]

{ #category : 'parsing - arrows' }
MMClassDiagramParser >> dependency [

	^ self nodeName , '<..' asPParser ==> #first , self nodeName
	  , ($: asPParser trimBlanks
		   , (self newline not , #any asPParser) star flatten ==> #second)
			  optional ==> [ :triple |
		  MMClassDiagramDependency new
			  node1: triple first;
			  node2: triple second;
			  label: triple third;
			  yourself ]
	  / (self nodeName , '..>' asPParser ==> #first , self nodeName
		   , ($: asPParser trimBlanks
			    , (self newline not , #any asPParser) star flatten ==> #second)
				   optional ==> [ :triple |
			   MMClassDiagramDependency new
				   node1: triple second;
				   node2: triple first;
				   label: triple third;
				   yourself ])
]

{ #category : 'accessing' }
MMClassDiagramParser >> diagram [

	^ self header , (self statement , self newline ==> #first) star
	  ==> [ :pair |
	  MMClassDiagram new entities: pair second asArray flattened ]
]

{ #category : 'parsing' }
MMClassDiagramParser >> direction [

	^ 'direction' asPParser trimBlanks
	  ,
		  ('TD' asPParser / 'TB' asPParser / 'BT' asPParser / 'LR' asPParser
		   / 'RL' asPParser) trimBlanks
	  ==> [ :pair | MMClassDiagramDirection new direction: pair second ]
]

{ #category : 'parsing' }
MMClassDiagramParser >> endClass [

	^ $} asPParser trimBlanks
	  ==> [ :triple | MMClassDiagramEndClass new ]
]

{ #category : 'parsing' }
MMClassDiagramParser >> header [

	^ 'classDiagram' asPParser , self newline ==> #first
]

{ #category : 'parsing - arrows' }
MMClassDiagramParser >> inheritance [

	^ self nodeName , '<|--' asPParser ==> #first , self nodeName
	  , ($: asPParser trimBlanks
		   , (self newline not , #any asPParser) star flatten ==> #second)
			  optional ==> [ :triple |
		  MMClassDiagramInheritance new
			  node1: triple first;
			  node2: triple second;
			  label: triple third;
			  yourself ]
	  / (self nodeName , '--|>' asPParser ==> #first , self nodeName
		   , ($: asPParser trimBlanks
			    , (self newline not , #any asPParser) star flatten ==> #second)
				   optional ==> [ :triple |
			   MMClassDiagramInheritance new
				   node1: triple second;
				   node2: triple first;
				   label: triple third;
				   yourself ])
]

{ #category : 'parsing' }
MMClassDiagramParser >> lineInClass [

	^ self endClass not
	  , (self beginAttributes / self beginOperations / self annotation
		   / self memberLine) , self newline ==> #second
]

{ #category : 'parsing' }
MMClassDiagramParser >> memberDeclaration [

	^ self nodeName , $: asPParser trimBlanks ==> #first
	  , (self newline not , #any asPParser) star flatten ==> [ :pair |
		  MMClassDiagramMember new
			  node: pair first;
			  name: pair second;
			  yourself ]
]

{ #category : 'parsing' }
MMClassDiagramParser >> memberLine [

	^ (self newline not , #any asPParser) star flatten ==> [ :line |
		  MMClassDiagramMember new
			  name: line trim;
			  yourself ]
]

{ #category : 'parsing - arrows' }
MMClassDiagramParser >> realization [

	^ self nodeName , '<|..' asPParser ==> #first , self nodeName
	  , ($: asPParser trimBlanks
		   , (self newline not , #any asPParser) star flatten ==> #second)
			  optional ==> [ :triple |
		  MMClassDiagramRealization new
			  node1: triple first;
			  node2: triple second;
			  label: triple third;
			  yourself ]
	  / (self nodeName , '..|>' asPParser ==> #first , self nodeName
		   , ($: asPParser trimBlanks
			    , (self newline not , #any asPParser) star flatten ==> #second)
				   optional ==> [ :triple |
			   MMClassDiagramRealization new
				   node1: triple second;
				   node2: triple first;
				   label: triple third;
				   yourself ])
]

{ #category : 'parsing' }
MMClassDiagramParser >> skipLine [

	^ (self newline not , #any asPParser) star flatten
	  ==> [ :string | nil ]
]

{ #category : 'parsing - arrows' }
MMClassDiagramParser >> solidLink [

	^ self nodeName , '--' asPParser ==> #first , self nodeName
	  , ($: asPParser trimBlanks
		   , (self newline not , #any asPParser) star flatten ==> #second)
			  optional ==> [ :triple |
		  MMClassDiagramSolidLink new
			  node1: triple first;
			  node2: triple second;
			  label: triple third;
			  yourself ]
]

{ #category : 'parsing' }
MMClassDiagramParser >> statement [

	^ self beginAttributes / self beginOperations / self direction
	  / self arrow / self memberDeclaration / self classDefinition
	  / self classDeclaration
]
