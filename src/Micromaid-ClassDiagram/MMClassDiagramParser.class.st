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

	^ self nodeName , (self cardinality optional , 'o--' asPParser ==> #first) , self cardinality optional , self nodeName
	  , ($: asPParser trimBlanks , (newline not , any) star string ==> #second) optional ==> [ :quintet |
		  MMClassDiagramAggregation new
			  node1: quintet first;
			  cardinality1: quintet second;
			  cardinality2: quintet third;
			  node2: quintet fourth;
			  label: quintet fifth;
			  yourself ]
	  / (self nodeName , self cardinality optional , ('--o' asPParser , self cardinality optional ==> #second) , self nodeName
		   , ($: asPParser trimBlanks , (newline not , any) star string ==> #second) optional ==> [ :quintet |
			   MMClassDiagramAggregation new
				   node2: quintet first;
				   cardinality2: quintet second;
				   cardinality1: quintet third;
				   node1: quintet fourth;
				   label: quintet fifth;
				   yourself ])
]

{ #category : 'parsing' }
MMClassDiagramParser >> annotation [

	^ '<<' asPParser trimBlanks , (('>>' asPParser / newline) not , any) star string , '>>' asPParser trimBlanks , newline and
	  ==> [ :triple | MMClassDiagramAnnotation new annotation: triple second trim ]
]

{ #category : 'parsing - arrows' }
MMClassDiagramParser >> arrow [

	^ self inheritance / self composition / self aggregation
	  / self association / self dependency / self realization
	  / self solidLink / self dashedLink
]

{ #category : 'parsing - arrows' }
MMClassDiagramParser >> association [

	^ self nodeName , (self cardinality optional , '<--' asPParser ==> #first) , self cardinality optional , self nodeName
	  , ($: asPParser trimBlanks , (newline not , any) star string ==> #second) optional ==> [ :quintet |
		  MMClassDiagramAssociation new
			  node1: quintet first;
			  cardinality1: quintet second;
			  cardinality2: quintet third;
			  node2: quintet fourth;
			  label: quintet fifth;
			  yourself ]
	  / (self nodeName , (self cardinality optional , '-->' asPParser ==> #first) , self cardinality optional , self nodeName
		   , ($: asPParser trimBlanks , (newline not , any) star string ==> #second) optional ==> [ :quintet |
			   MMClassDiagramAssociation new
				   node2: quintet first;
				   cardinality2: quintet second;
				   cardinality1: quintet third;
				   node1: quintet fourth;
				   label: quintet fifth;
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
	  , ('["' asPParser , ('"]' asPParser not , any asPParser) plus string , '"]' asPParser ==> #second) optional
	  , ('<<' asPParser trimBlanks , ('>>' asPParser not , any asPParser) star string , '>>' asPParser trimBlanks
		   ==> [ :triple | triple second trim ]) star , ${ asPParser trimBlanks ==> [ :quartet |
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

{ #category : 'parsing - arrows' }
MMClassDiagramParser >> cardinality [

	^ $" asPParser trimBlanks , ($" asPParser not , any asPParser) star string , $" asPParser trimBlanks ==> #second
]

{ #category : 'parsing' }
MMClassDiagramParser >> classDeclaration [

	^ 'class' asPParser trimBlanks , self nodeName ==> #second
	  , ('["' asPParser , ('"]' asPParser not , any asPParser) plus string , '"]' asPParser ==> #second) optional
	  , ('<<' asPParser trimBlanks , ('>>' asPParser not , any asPParser) star string , '>>' asPParser trimBlanks
		   ==> [ :triple | triple second trim ]) star ==> [ :triple |
		  MMClassDiagramClass new
			  name: triple first;
			  label: triple second;
			  annotations: triple third;
			  yourself ]
]

{ #category : 'parsing' }
MMClassDiagramParser >> classDefinition [

	^ self beginClass , newline ==> #first , self lineInClass star , self endClass
	  ==> [ :triple | { triple first } , triple second , { triple third } ]
]

{ #category : 'parsing - arrows' }
MMClassDiagramParser >> composition [

	^ self nodeName , (self cardinality optional , '*--' asPParser ==> #first) , self cardinality optional , self nodeName
	  , ($: asPParser trimBlanks , (newline not , any) star string ==> #second) optional ==> [ :quintet |
		  MMClassDiagramComposition new
			  node1: quintet first;
			  cardinality1: quintet second;
			  cardinality2: quintet third;
			  node2: quintet fourth;
			  label: quintet fifth;
			  yourself ]
	  / (self nodeName , (self cardinality optional , '--*' asPParser ==> #first) , self cardinality optional , self nodeName
		   , ($: asPParser trimBlanks , (newline not , any) star string ==> #second) optional ==> [ :quintet |
			   MMClassDiagramComposition new
				   node2: quintet first;
				   cardinality2: quintet second;
				   cardinality1: quintet third;
				   node1: quintet fourth;
				   label: quintet fifth;
				   yourself ])
]

{ #category : 'parsing - arrows' }
MMClassDiagramParser >> dashedLink [

	^ self nodeName , (self cardinality optional , '..' asPParser ==> #first) , self cardinality optional , self nodeName
	  , ($: asPParser trimBlanks , (newline not , any) star string ==> #second) optional ==> [ :quintet |
		  MMClassDiagramDashedLink new
			  node1: quintet first;
			  cardinality1: quintet second;
			  cardinality2: quintet third;
			  node2: quintet fourth;
			  label: quintet fifth;
			  yourself ]
]

{ #category : 'parsing - arrows' }
MMClassDiagramParser >> dependency [

	^ self nodeName , (self cardinality optional , '<..' asPParser ==> #first) , self cardinality optional , self nodeName
	  , ($: asPParser trimBlanks , (newline not , any) star string ==> #second) optional ==> [ :quintet |
		  MMClassDiagramDependency new
			  node1: quintet first;
			  cardinality1: quintet second;
			  cardinality2: quintet third;
			  node2: quintet fourth;
			  label: quintet fifth;
			  yourself ]
	  / (self nodeName , (self cardinality optional , '..>' asPParser ==> #first) , self cardinality optional , self nodeName
		   , ($: asPParser trimBlanks , (newline not , any) star string ==> #second) optional ==> [ :quintet |
			   MMClassDiagramDependency new
				   node2: quintet first;
				   cardinality2: quintet second;
				   cardinality1: quintet third;
				   node1: quintet fourth;
				   label: quintet fifth;
				   yourself ])
]

{ #category : 'accessing' }
MMClassDiagramParser >> diagram [

	^ self header , (self statement , newline ==> #first) star
	  ==> [ :pair | MMClassDiagram new entities: pair second asArray flattened ]
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

	^ 'classDiagram' asPParser , newline ==> #first
]

{ #category : 'parsing - arrows' }
MMClassDiagramParser >> inheritance [

	^ self nodeName , (self cardinality optional , '<|--' asPParser ==> #first) , self cardinality optional , self nodeName
	  , ($: asPParser trimBlanks , (newline not , any asPParser) star string ==> #second) optional ==> [ :quintet |
		  MMClassDiagramInheritance new
			  node1: quintet first;
			  cardinality1: quintet second;
			  cardinality2: quintet third;
			  node2: quintet fourth;
			  label: quintet fifth;
			  yourself ]
	  / (self nodeName , (self cardinality optional , '--|>' asPParser ==> #first) , self cardinality optional , self nodeName
		   , ($: asPParser trimBlanks , (newline not , any asPParser) star string ==> #second) optional ==> [ :quintet |
			   MMClassDiagramInheritance new
				   node2: quintet first;
				   cardinality2: quintet second;
				   cardinality1: quintet third;
				   node1: quintet fourth;
				   label: quintet fifth;
				   yourself ])
]

{ #category : 'parsing' }
MMClassDiagramParser >> lineInClass [

	^ self endClass not , (self beginAttributes / self beginOperations / self annotation / self memberLine) , newline ==> #second
]

{ #category : 'parsing' }
MMClassDiagramParser >> memberDeclaration [

	^ self nodeName , $: asPParser trimBlanks ==> #first , (newline not , any) star string ==> [ :pair |
		  MMClassDiagramMember new
			  node: pair first;
			  name: pair second;
			  yourself ]
]

{ #category : 'parsing' }
MMClassDiagramParser >> memberLine [

	^ (newline not , any) star string ==> [ :line |
		  MMClassDiagramMember new
			  name: line trim;
			  yourself ]
]

{ #category : 'parsing - arrows' }
MMClassDiagramParser >> realization [

	^ self nodeName , (self cardinality optional , '<|..' asPParser ==> #first) , self cardinality optional , self nodeName
	  , ($: asPParser trimBlanks , (newline not , any) star string ==> #second) optional ==> [ :quintet |
		  MMClassDiagramRealization new
			  node1: quintet first;
			  cardinality1: quintet second;
			  cardinality2: quintet third;
			  node2: quintet fourth;
			  label: quintet fifth;
			  yourself ]
	  / (self nodeName , (self cardinality optional , '..|>' asPParser ==> #first) , self cardinality optional , self nodeName
		   , ($: asPParser trimBlanks , (newline not , any) star string ==> #second) optional ==> [ :quintet |
			   MMClassDiagramRealization new
				   node2: quintet first;
				   cardinality2: quintet second;
				   cardinality1: quintet third;
				   node1: quintet fourth;
				   label: quintet fifth;
				   yourself ])
]

{ #category : 'parsing' }
MMClassDiagramParser >> skipLine [

	^ (newline not , any) star flatten ==> [ :string | nil ]
]

{ #category : 'parsing - arrows' }
MMClassDiagramParser >> solidLink [

	^ self nodeName , (self cardinality optional , '--' asPParser ==> #first) , self cardinality optional , self nodeName
	  , ($: asPParser trimBlanks , (newline not , any asPParser) star string ==> #second) optional ==> [ :quintet |
		  MMClassDiagramSolidLink new
			  node1: quintet first;
			  cardinality1: quintet second;
			  cardinality2: quintet third;
			  node2: quintet fourth;
			  label: quintet fifth;
			  yourself ]
]

{ #category : 'parsing' }
MMClassDiagramParser >> statement [

	^ self beginAttributes / self beginOperations / self direction
	  / self arrow / self memberDeclaration / self classDefinition
	  / self classDeclaration
]
