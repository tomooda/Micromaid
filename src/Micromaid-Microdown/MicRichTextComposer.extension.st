Extension { #name : 'MicRichTextComposer' }

{ #category : '*Micromaid-Microdown' }
MicRichTextComposer >> visitMicromaidScript: aMicromaidScriptBlock [

	| script extent rsCanvas form anchor resText |
	script := MicromaidParser parse: aMicromaidScriptBlock body.
	script isPetit2Failure ifTrue: [ ^ self ].
	extent := nil.
	aMicromaidScriptBlock arguments
		at: #extent
		ifPresent: [ :extentString |
				| intStrings |
				intStrings := extentString substrings: '@'.
				intStrings size = 2 ifTrue: [
						| x y |
						x := intStrings first asInteger.
						y := intStrings second asInteger.
						(x > 10 and: [ y > 10 ]) ifTrue: [ extent := x @ y ] ] ].
	rsCanvas := script roassalBuilder build.
	extent
		ifNil: [
		rsCanvas extent: rsCanvas encompassingRectangle extent + (20 @ 20) ]
		ifNotNil: [ rsCanvas extent: extent ].
	form := rsCanvas
		        zoomToFit;
		        asForm.
	anchor := self anchorFor: form of: aMicromaidScriptBlock.
	resText := (self textWithImage: form usingAnchor: anchor)
	           , ' ' asText.
	canvas
		newLineIfNotAlready;
		<< resText;
		newLine
]
