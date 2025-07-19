Extension { #name : 'MicRichTextComposer' }

{ #category : '*Micromaid-Microdown' }
MicRichTextComposer >> visitMicromaidScript: aMicromaidScriptBlock [

	| script form anchor resText |
	script := MicromaidParser parse: aMicromaidScriptBlock body.
	script isPetit2Failure ifTrue: [ ^ self ].
	form := script roassalBuilder build
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
