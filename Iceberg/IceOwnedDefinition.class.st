"
I am an abstract class that represents a sub-definition of either a IceClassDefinition or an IceTraitDefinition.

My instances only have meaning as elements of the container. 
"
Class {
	#name : #IceOwnedDefinition,
	#superclass : #IceCodeDefinition,
	#instVars : [
		'ownerIceDefinition'
	],
	#category : #'Iceberg-Changes'
}

{ #category : #comparing }
IceOwnedDefinition >> = anotherDefinition [
	"Answer whether the receiver and anObject represent the same object."

	^ super = anotherDefinition
		and: [ self ownerName = anotherDefinition ownerName ]
]

{ #category : #patching }
IceOwnedDefinition >> addModification: anotherIceDefinition toPatcher: aMCPatcher [

	self flag: #todo. "?"
	(aMCPatcher isKindOf: MCPackageLoader) ifTrue: [ ^self "containerMCDefinition did it" ].

	aMCPatcher definitionIndex
		definitionLike: anotherIceDefinition ownerMCDefinition
		ifPresent: [ :currentDefinition | 
			aMCPatcher addDefinition: (self addedIn: currentDefinition) ]
		ifAbsent: [ self error ].

]

{ #category : #patching }
IceOwnedDefinition >> addToPatcher: aMCPatcher [ 

	self flag: #todo.
	(aMCPatcher isKindOf: MCPackageLoader) ifTrue: [
		^ self "owner is just fine" ].

	aMCPatcher definitionIndex
		definitionLike: self ownerIceDefinition asMCDefinition
		ifPresent: [ :currentDefinition |
			aMCPatcher addDefinition: (self addedIn: currentDefinition) ]
		ifAbsent: [ self error ].

]

{ #category : #patching }
IceOwnedDefinition >> addedIn: aMCDefinition [
	"Answer a copy of the argument that includes self."

	^ aMCDefinition copy
]

{ #category : #accessing }
IceOwnedDefinition >> browse [
	self ownerIceDefinition browse
]

{ #category : #accessing }
IceOwnedDefinition >> className [

	self
		deprecated: 'Use #ownerName instead.'
		transformWith: '`@receiver className' -> '`@receiver ownerName'.

	^ self ownerName
]

{ #category : #comparing }
IceOwnedDefinition >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ super hash bitXor: self ownerName hash
]

{ #category : #accessing }
IceOwnedDefinition >> icon [
	^ self iconNamed: #menuPin
]

{ #category : #testing }
IceOwnedDefinition >> isLowImpactAppliedTo: anIcePropertyDefinition [ 
	^ false
]

{ #category : #accessing }
IceOwnedDefinition >> key [
	"Answer a string that is enough as an identification between my siblings."

	^ self type, ': ', name
]

{ #category : #accessing }
IceOwnedDefinition >> ownerIceDefinition [
	^ ownerIceDefinition
]

{ #category : #accessing }
IceOwnedDefinition >> ownerIceDefinition: anIceMethodContainerDefinition [
	ownerIceDefinition := anIceMethodContainerDefinition
]

{ #category : #accessing }
IceOwnedDefinition >> ownerMCDefinition [
	^ ownerIceDefinition asMCDefinition
]

{ #category : #accessing }
IceOwnedDefinition >> ownerName [
	
	^ ownerIceDefinition name
]

{ #category : #patching }
IceOwnedDefinition >> removeFrom: aPatcher [
	"By default, of the owner is removed, then also I'm removed."

]

{ #category : #patching }
IceOwnedDefinition >> removeFromPatcher: aMCPatcher [ 
	
	self subclassResponsibility
]

{ #category : #accessing }
IceOwnedDefinition >> type [

	^ self subclassResponsibility
]
