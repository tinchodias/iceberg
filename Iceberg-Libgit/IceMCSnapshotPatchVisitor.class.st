Class {
	#name : #IceMCSnapshotPatchVisitor,
	#superclass : #IceTreeVisitor,
	#instVars : [
		'patcher'
	],
	#category : #'Iceberg-Libgit-Commit'
}

{ #category : #accessing }
IceMCSnapshotPatchVisitor >> patcher: aMCPatcher [
	patcher := aMCPatcher
]

{ #category : #visiting }
IceMCSnapshotPatchVisitor >> visitAddition: anIceAddition [ 
	anIceAddition definition addToPatcher: patcher.
	self visitChildrenOf: currentNode
]

{ #category : #visiting }
IceMCSnapshotPatchVisitor >> visitConflictingOperation: anIceConflictingOperation [ 
	
	anIceConflictingOperation isResolved
		ifFalse: [ self error: 'Cannot apply a non resolved conflict' ].
		
	^ anIceConflictingOperation chosenOperation accept: self
]

{ #category : #visiting }
IceMCSnapshotPatchVisitor >> visitModification: anIceModification [

	anIceModification leftDefinition
		addModification: anIceModification rightDefinition
		toPatcher: patcher.
	self visitChildrenOf: currentNode
]

{ #category : #visiting }
IceMCSnapshotPatchVisitor >> visitNoModification: anIceNoModification [
	
	anIceNoModification definition addToPatcher: patcher.
	self visitChildrenOf: currentNode
]

{ #category : #visiting }
IceMCSnapshotPatchVisitor >> visitNonConflictingOperation: anIceNonConflictingOperation [

	^ anIceNonConflictingOperation chosenOperation accept: self
]

{ #category : #visiting }
IceMCSnapshotPatchVisitor >> visitRemoval: anIceRemoval [ 
	anIceRemoval definition removeInPatcher: patcher.
	self visitChildrenOf: currentNode
]
