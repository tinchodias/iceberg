"
I visit a tree of IceNode with IceOperationMerge with all operations already chosen and return the coresponding tree of changes (IceNodes with IceOperation)
"
Class {
	#name : #IceMergeToChangeTreeVisitor,
	#superclass : #IceTreeVisitor,
	#category : #'Iceberg-Changes'
}

{ #category : #utilities }
IceMergeToChangeTreeVisitor >> convertMergeNodeToChangeNode [
	currentNode value: currentNode value chosenOperation .
]

{ #category : #visiting }
IceMergeToChangeTreeVisitor >> visitAddition: anIceAddition [ 
	self convertMergeNodeToChangeNode.
]

{ #category : #visiting }
IceMergeToChangeTreeVisitor >> visitClassDefinition: anIceClassDefinition [ 
	self convertMergeNodeToChangeNode.
	self visitChildrenOf: currentNode
]

{ #category : #'as yet unclassified' }
IceMergeToChangeTreeVisitor >> visitDirectoryDefinition: anIceDirectoryDefinition [ 
	self convertMergeNodeToChangeNode.
	self visitChildrenOf: currentNode
]

{ #category : #'as yet unclassified' }
IceMergeToChangeTreeVisitor >> visitExtensionDefinition: anIceExtensionDefinition [ 

	self convertMergeNodeToChangeNode
]

{ #category : #'as yet unclassified' }
IceMergeToChangeTreeVisitor >> visitFileNode: anIceFileDefinition [

	self convertMergeNodeToChangeNode
]

{ #category : #'as yet unclassified' }
IceMergeToChangeTreeVisitor >> visitMethodNode: anIceMethodDefinition [

	self convertMergeNodeToChangeNode
]

{ #category : #visiting }
IceMergeToChangeTreeVisitor >> visitModification: anIceModification [

	anIceModification definition accept: self
]

{ #category : #visiting }
IceMergeToChangeTreeVisitor >> visitNoModification: anIceNoModification [
	anIceNoModification definition accept: self.
]

{ #category : #visiting }
IceMergeToChangeTreeVisitor >> visitNonConflictingOperation: anIceNonConflictingOperation [ 
	anIceNonConflictingOperation chosenOperation accept: self.
]

{ #category : #visiting }
IceMergeToChangeTreeVisitor >> visitPackage: anIcePackageDefinition [
	self convertMergeNodeToChangeNode.
	self visitChildrenOf: currentNode
]

{ #category : #'as yet unclassified' }
IceMergeToChangeTreeVisitor >> visitRemoval: anIceRemoval [

	self convertMergeNodeToChangeNode
]

{ #category : #visiting }
IceMergeToChangeTreeVisitor >> visitRootDefinition: anIceRootDefinition [ 
	self visitChildrenOf: currentNode
]

{ #category : #'as yet unclassified' }
IceMergeToChangeTreeVisitor >> visitTraitDefinition: anIceTraitDefinition [

	self convertMergeNodeToChangeNode.
	self visitChildrenOf: currentNode
]
