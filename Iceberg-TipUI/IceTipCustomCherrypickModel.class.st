Class {
	#name : #IceTipCustomCherrypickModel,
	#superclass : #IceTipModel,
	#instVars : [
		'diff'
	],
	#category : #'Iceberg-TipUI-Model'
}

{ #category : #accessing }
IceTipCustomCherrypickModel >> diff [
	^ self
]

{ #category : #accessing }
IceTipCustomCherrypickModel >> diff: anIceDiff [

	diff := anIceDiff
]

{ #category : #'as yet unclassified' }
IceTipCustomCherrypickModel >> treeToShow [

	^ diff tree collectWithPath: [ :operation :path | 
		  IceNonConflictingOperation operation: operation ]
]
