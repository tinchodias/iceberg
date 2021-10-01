Class {
	#name : #IceTipPartialLoadModel,
	#superclass : #IceTipModel,
	#instVars : [
		'diff',
		'treeToShow'
	],
	#category : #'Iceberg-TipUI-Model'
}

{ #category : #'instance creation' }
IceTipPartialLoadModel class >> onDiff: anIceDiff [

	^ self new
		  iceDiff: anIceDiff;
		  yourself
]

{ #category : #accessing }
IceTipPartialLoadModel >> diff [
	"The merge preview presenter sends this message to know how will answer to #treeToShow."

	^ self
]

{ #category : #accessing }
IceTipPartialLoadModel >> iceDiff: anIceDiff [

	diff := anIceDiff
]

{ #category : #accessing }
IceTipPartialLoadModel >> repository [

	^ diff repository
]

{ #category : #accessing }
IceTipPartialLoadModel >> treeToShow [

	^ treeToShow ifNil: [
		treeToShow := diff tree collectWithPath: [ :operation :path | 
		  IceNonConflictingOperation operation: operation ].
		
"		| receiverDiff headCommit |
		headCommit := diff repository head commit.
		receiverDiff := headCommit diffTo: diff sourceVersion.
		treeToShow := IceTreeMerger new merge: diff tree into: receiverDiff tree" ]
]
