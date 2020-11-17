"
I am an IceDefinition that have some source code in my contents.

See my sub/superclasses for more information.
"
Class {
	#name : #IceCodeDefinition,
	#superclass : #IceDefinition,
	#category : #'Iceberg-Changes'
}

{ #category : #'as yet unclassified' }
IceCodeDefinition class >> named: aName source: aString [
	
	^ (super named: aName)
		source: aString;
		yourself
]

{ #category : #comparing }
IceCodeDefinition >> = anotherDefinition [

	^ super = anotherDefinition
		and: [ self contents = anotherDefinition contents ]
]

{ #category : #patching }
IceCodeDefinition >> addModification: anotherIceDefinition toPatcher: aMCPatcher [ 
	
	self subclassResponsibility
]

{ #category : #patching }
IceCodeDefinition >> addToPatcher: aMCPatcher [ 
	
	self subclassResponsibility
]

{ #category : #properties }
IceCodeDefinition >> allPropertyNames [
	^ #()
]

{ #category : #comparing }
IceCodeDefinition >> hash [
	^ super hash bitXor: self contents hash
]

{ #category : #properties }
IceCodeDefinition >> ownedDefinitions [
	^ self propertyDefinitions
]

{ #category : #properties }
IceCodeDefinition >> propertyDefinitions [
	^ self allPropertyNames
		collect: [ :each | 
			IcePropertyDefinition new
				name: each;
				ownerIceDefinition: self;
				yourself.
			 ]
		thenReject: [ :each |
			each isDefaultValue ].

]

{ #category : #patching }
IceCodeDefinition >> removeFrom: aPatcher [
	
	self subclassResponsibility
]
