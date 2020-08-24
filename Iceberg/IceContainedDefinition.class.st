Class {
	#name : #IceContainedDefinition,
	#superclass : #IceCodeDefinition,
	#instVars : [
		'containerDefinition'
	],
	#category : #'Iceberg-Changes'
}

{ #category : #comparing }
IceContainedDefinition >> = anotherDefinition [
	"Answer whether the receiver and anObject represent the same object."

	^ super = anotherDefinition
		and: [ containerDefinition name = anotherDefinition containerIceDefinition name ]
]

{ #category : #visiting }
IceContainedDefinition >> accept: aVisitor [
	^ aVisitor visitContainedDefinition: self
]

{ #category : #patching }
IceContainedDefinition >> addModification: anotherIceDefinition toPatcher: aMCPatcher [

(aMCPatcher isKindOf: MCPackageLoader) ifTrue: [ ^self "containerMCDefinition did it" ].

	aMCPatcher definitionIndex
		definitionLike: anotherIceDefinition containerMCDefinition
		ifPresent: [ :currentDefinition | 
			aMCPatcher addDefinition: (self addedIn: currentDefinition) ]
		ifAbsent: [ self error ].

]

{ #category : #patching }
IceContainedDefinition >> addToPatcher: aMCPatcher [ 

	(aMCPatcher isKindOf: MCPackageLoader) ifTrue: [
		^ self "containerIceDefinition is just fine" ].

	aMCPatcher definitionIndex
		definitionLike: self containerIceDefinition asMCDefinition
		ifPresent: [ :currentDefinition |
			aMCPatcher addDefinition: (self addedIn: currentDefinition) ]
		ifAbsent: [ self error ].

]

{ #category : #patching }
IceContainedDefinition >> addedIn: aMCDefinition [
	^ self subclassResponsibility
]

{ #category : #accessing }
IceContainedDefinition >> browse [
	self containerIceDefinition browse
]

{ #category : #accessing }
IceContainedDefinition >> containerIceDefinition [
	^ containerDefinition
]

{ #category : #accessing }
IceContainedDefinition >> containerIceDefinition: anObject [
	containerDefinition := anObject
]

{ #category : #accessing }
IceContainedDefinition >> containerMCDefinition [
	^ containerDefinition asMCDefinition
]

{ #category : #accessing }
IceContainedDefinition >> contents [
	
	^ self subclassResponsibility
]

{ #category : #comparing }
IceContainedDefinition >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ super hash bitXor: containerDefinition hash
]

{ #category : #accessing }
IceContainedDefinition >> icon [
	^ self iconNamed: #menuPin
]

{ #category : #testing }
IceContainedDefinition >> isLowImpactAppliedTo: anIcePropertyDefinition [ 
	^ false
]

{ #category : #patching }
IceContainedDefinition >> removeFrom: aPatcher [
	(self className , 'removeFrom: ' , aPatcher asString) traceCr
]

{ #category : #patching }
IceContainedDefinition >> removeFromPatcher: aMCPatcher [ 
	
	self subclassResponsibility
]
