Class {
	#name : #IceTipCommitWithAuthorBrowser,
	#superclass : #IceTipCommitBrowser,
	#instVars : [
		'authorLibgitSignature'
	],
	#category : #'Iceberg-TipUI-View-Commit'
}

{ #category : #accessing }
IceTipCommitWithAuthorBrowser >> authorLibgitSignature [

	^ authorLibgitSignature
]

{ #category : #accessing }
IceTipCommitWithAuthorBrowser >> authorLibgitSignature: anObject [

	authorLibgitSignature := anObject
]

{ #category : #accessing }
IceTipCommitWithAuthorBrowser >> comment: aString [
	"Set the commit comment on the widget."

	commentPanel commentText text: aString
]

{ #category : #actions }
IceTipCommitWithAuthorBrowser >> doCommit: aCollection message: aString pushing: pushingBoolean saving: savingBoolean [

	self model
		commit:
			(IceTipCommitWithAuthorAction new
				diff: self model workingCopyDiff;
				items: aCollection;
				message: aString;
				authorLibgitSignature: authorLibgitSignature;
				yourself)
		then: [ self verifyNeedsRefreshOrClose.
			pushingBoolean
				ifTrue: [ (IceTipPushAction new repository: self model entity) execute ].
			savingBoolean
				ifTrue: [ saveAction execute ] ]
]
