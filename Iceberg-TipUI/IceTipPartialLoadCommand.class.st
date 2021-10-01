Class {
	#name : #IceTipPartialLoadCommand,
	#superclass : #IceTipCommand,
	#category : #'Iceberg-TipUI-Commands'
}

{ #category : #'accessing - defaults' }
IceTipPartialLoadCommand class >> defaultDescription [

	^ 'Partially load this commit and apply changes to the working copy'
]

{ #category : #'accessing - defaults' }
IceTipPartialLoadCommand class >> defaultName [

	^ 'Partial load'
]

{ #category : #testing }
IceTipPartialLoadCommand >> canBeExecuted [

	^ true
]

{ #category : #executing }
IceTipPartialLoadCommand >> execute [

	| diffToParent |
	diffToParent := self selectedCommitish diffToParent.
	(IceTipPartialLoadPreviewBrowser onDiff: diffToParent) openWithSpec
]

{ #category : #executing }
IceTipPartialLoadCommand >> selectedCommitish [

	^ self context selectedCommit realObject entity
]
