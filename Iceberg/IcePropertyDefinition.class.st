"
I represent a property of an IceClassDefinition or IceTraitDefinition. For example, the comment.

A property has a name and a value, and only its value can change. Properties cann't be removed from the container.
"
Class {
	#name : 'IcePropertyDefinition',
	#superclass : 'IceOwnedDefinition',
	#instVars : [
		'propertyValue'
	],
	#category : 'Iceberg-Changes',
	#package : 'Iceberg',
	#tag : 'Changes'
}

{ #category : 'comparing' }
IcePropertyDefinition >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	^ super = anObject and: [ self propertyValue = anObject propertyValue ]
]

{ #category : 'visiting' }
IcePropertyDefinition >> accept: aVisitor [
	^ aVisitor visitPropertyDefinition: self
]

{ #category : 'patching' }
IcePropertyDefinition >> addedIn: aMCDefinition [

	^ aMCDefinition copy
		basicAtPropertyNamed: self propertyName
			put: self propertyValue;
		yourself
]

{ #category : 'accessing' }
IcePropertyDefinition >> contents [
	^ self propertyValue asString
]

{ #category : 'comparing' }
IcePropertyDefinition >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ super hash bitXor: self propertyValue hash
]

{ #category : 'testing' }
IcePropertyDefinition >> isDefaultValue [
	name = #superclassName ifTrue: [ 
		^ self propertyValue = #Object ].

	name = #type ifTrue: [
		^ self propertyValue = #normal ].

	name = #comment ifTrue: [ 
		^ self propertyValue isNil or: [ self propertyValue isEmpty ] ].

	(#(traitComposition classTraitComposition) includes: name) ifTrue: [ 
		^ self propertyValue = '{}' ].
	
	^ false
]

{ #category : 'testing' }
IcePropertyDefinition >> isLowImpactAppliedTo: anIcePropertyDefinition [ 
	^ #(category comment commentStamp timeStamp) includes: self propertyName
]

{ #category : 'testing' }
IcePropertyDefinition >> isPropertyDefinition [

	^ true
]

{ #category : 'accessing' }
IcePropertyDefinition >> propertyName [
	^ name
]

{ #category : 'accessing' }
IcePropertyDefinition >> propertyValue [
	^ propertyValue ifNil: [
		propertyValue := ownerIceDefinition asMCDefinition basicAtPropertyNamed: name ]
]

{ #category : 'patching' }
IcePropertyDefinition >> removeFromPatcher: aMCPatcher [
	"Cannot remove a property, just change it."

]

{ #category : 'accessing' }
IcePropertyDefinition >> type [

	^ 'property'
]
