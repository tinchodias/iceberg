"
I am an IceDefinition that represents a property in another definition. 

A property has a name and a value, and only its value can change. Properties cann't be removed from the container.

For example, the comment of an IceClassDefinition.

"
Class {
	#name : #IcePropertyDefinition,
	#superclass : #IceContainedDefinition,
	#instVars : [
		'propertyValue'
	],
	#category : #'Iceberg-Changes'
}

{ #category : #comparing }
IcePropertyDefinition >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	^ super = anObject and: [ self propertyValue = anObject propertyValue ]
]

{ #category : #visiting }
IcePropertyDefinition >> accept: aVisitor [
	^ aVisitor visitPropertyDefinition: self
]

{ #category : #patching }
IcePropertyDefinition >> addedIn: aMCDefinition [

	^ aMCDefinition copy
		basicAtPropertyNamed: self propertyName
			put: self propertyValue;
		yourself
]

{ #category : #accessing }
IcePropertyDefinition >> contents [
	^ self propertyValue asString
]

{ #category : #comparing }
IcePropertyDefinition >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ super hash bitXor: self propertyValue hash
]

{ #category : #testing }
IcePropertyDefinition >> isDefaultValue [
	name = #superclassName ifTrue: [ 
		^ self propertyValue = #Object ].

	name = #type ifTrue: [ 
		^ self propertyValue = #normal ].

	name = #comment ifTrue: [ 
		^ self propertyValue isNil or: [ self propertyValue isEmpty ] ].

	(name = #traitComposition or: [ name = #classTraitComposition ]) ifTrue: [ 
		^ self propertyValue = '{}' ].
	
	^ false.
]

{ #category : #testing }
IcePropertyDefinition >> isLowImpactAppliedTo: anIcePropertyDefinition [ 
	^ #(category comment commentStamp timeStamp) includes: self propertyName
]

{ #category : #accessing }
IcePropertyDefinition >> key [
	^ '>Property: ', name
]

{ #category : #printing }
IcePropertyDefinition >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	super printOn: aStream.
	aStream
		nextPutAll: '(';
		print: self propertyName.
	aStream
		nextPutAll: ' -> ';
		print: self propertyValue;
		nextPutAll: ')'

]

{ #category : #accessing }
IcePropertyDefinition >> propertyName [
	^ name
]

{ #category : #accessing }
IcePropertyDefinition >> propertyValue [
	^ propertyValue ifNil: [
		propertyValue := containerDefinition asMCDefinition basicAtPropertyNamed: name ]
]

{ #category : #patching }
IcePropertyDefinition >> removeFromPatcher: aMCPatcher [
	"Cannot remove a property, just change it."

]
