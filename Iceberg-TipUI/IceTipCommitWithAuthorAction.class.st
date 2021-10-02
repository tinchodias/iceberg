Class {
	#name : #IceTipCommitWithAuthorAction,
	#superclass : #IceTipCommitAction,
	#instVars : [
		'authorLibgitSignature'
	],
	#category : #'Iceberg-TipUI-Commands'
}

{ #category : #accessing }
IceTipCommitWithAuthorAction >> authorLibgitSignature [

	^ authorLibgitSignature
]

{ #category : #accessing }
IceTipCommitWithAuthorAction >> authorLibgitSignature: anObject [

	authorLibgitSignature := anObject
]

{ #category : #executing }
IceTipCommitWithAuthorAction >> basicExecute [
	self validateCanCommit.
	UIManager default 
		informUser: 'Commiting...' 
		during: [ 
			self repository workingCopy
				commitChanges: (diff copyWithOnly: items)
				withMessage: message
				force: false
				author: authorLibgitSignature ].
	Iceberg announcer announce: (IceRepositoryModified for: self repository).
	Iceberg announcer announce: (IceCommited for: self repository).
]
