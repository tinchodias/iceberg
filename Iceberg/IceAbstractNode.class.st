"
My subclasses implement a tree used for diffing and merging.
"
Class {
	#name : 'IceAbstractNode',
	#superclass : 'Object',
	#category : 'Iceberg-Changes',
	#package : 'Iceberg',
	#tag : 'Changes'
}

{ #category : 'testing' }
IceAbstractNode class >> isAbstract [

	^ self == IceAbstractNode
]

{ #category : 'accessing' }
IceAbstractNode >> accept: aVisitor [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
IceAbstractNode >> addTo: anotherNode [

	^ self subclassResponsibility
]

{ #category : 'accessing - children' }
IceAbstractNode >> allChildren [
	
	| children |
	children := OrderedCollection new.
	self allChildrenDo: [ :each | children add: each ].
	^ children
]

{ #category : 'enumerating' }
IceAbstractNode >> allChildrenDo: aBlockClosure [
	"Evaluate aBlockClosure with my direct and indirect children."
	
	self childrenDo: [ :each |
		aBlockClosure value: each.
		each allChildrenDo: aBlockClosure ]
]

{ #category : 'enumerating' }
IceAbstractNode >> allLeavesDo: aBlockClosure [
	"Evaluate aBlockClosure with all empty nodes, including self and all (direct and indirect) children."

	self isEmpty
		ifTrue: [ aBlockClosure value: self ]
		ifFalse: [ 
			self childrenDo: [ :each |
				each allLeavesDo: aBlockClosure ] ]
]

{ #category : 'accessing' }
IceAbstractNode >> anySatisfy: aBlockClosure [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
IceAbstractNode >> children [
	"Answer the (direct) children of this node."

	^ self subclassResponsibility
]

{ #category : 'enumerating' }
IceAbstractNode >> childrenDo: aBlockClosure [ 
	
	self children do: aBlockClosure
]

{ #category : 'accessing' }
IceAbstractNode >> collect: aBlockClosure [
	"Collect the results of aBlockClosure on my value and the values of my children."

	^ self subclassResponsibility
]

{ #category : 'accessing' }
IceAbstractNode >> collectWithPath: aBlockClosure [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
IceAbstractNode >> do: aBlockClosure [
	"Evaluate aBlockClosure on my value and the values of my children."

	^ self subclassResponsibility
]

{ #category : 'accessing' }
IceAbstractNode >> firstNodeSuchThat: conditionBlock [ 
	
	^ self firstNodeSuchThat: conditionBlock ifNone: [ NotFound signalFor: conditionBlock ]
]

{ #category : 'accessing' }
IceAbstractNode >> firstNodeSuchThat: foundBlock ifNone: noneBlock [

	^ self subclassResponsibility
]

{ #category : 'testing' }
IceAbstractNode >> hasChanges [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
IceAbstractNode >> includesKey: anObject [

	^ self subclassResponsibility
]

{ #category : 'testing' }
IceAbstractNode >> isEmpty [

	^ self subclassResponsibility
]

{ #category : 'testing' }
IceAbstractNode >> isEmptyNode [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
IceAbstractNode >> mergeWith: anotherNode onLeft: leftBlock onRight: rightBlock onMerge: mergeBlock [

	^ self subclassResponsibility
]

{ #category : 'testing' }
IceAbstractNode >> notEmpty [

	^ self isEmpty not
]

{ #category : 'accessing' }
IceAbstractNode >> path [
	"Answer a RelativePath to the top parent."

	^ self subclassResponsibility
]

{ #category : 'accessing' }
IceAbstractNode >> resolve: aRelativePath ifPresent: presentBlock ifAbsent: absentBlock [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
IceAbstractNode >> select: aBlockClosure [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
IceAbstractNode >> withAllChildren [

	^ OrderedCollection streamContents: [ :stream | 
		  self withAllChildrenDo: [ :each | stream << each ] ]
]

{ #category : 'enumerating' }
IceAbstractNode >> withAllChildrenDo: aBlockClosure [

	aBlockClosure value: self.
	self allChildrenDo: aBlockClosure
]
