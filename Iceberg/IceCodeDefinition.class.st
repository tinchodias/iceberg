"
I am an IceDefinition that have some source code in my contents.

See my sub/superclasses for more information.
"
Class {
	#name : 'IceCodeDefinition',
	#superclass : 'IceDefinition',
	#category : 'Iceberg-Changes',
	#package : 'Iceberg',
	#tag : 'Changes'
}

{ #category : 'instance creation' }
IceCodeDefinition class >> named: aName source: aString [
	
	^ (super named: aName)
		source: aString;
		yourself
]

{ #category : 'comparing' }
IceCodeDefinition >> = anotherDefinition [

	^ super = anotherDefinition
		and: [ self contents = anotherDefinition contents ]
]

{ #category : 'patching' }
IceCodeDefinition >> addModification: anotherIceDefinition toPatcher: aMCPatcher [ 
	
	self subclassResponsibility
]

{ #category : 'patching' }
IceCodeDefinition >> addToPatcher: aMCPatcher [ 
	
	self subclassResponsibility
]

{ #category : 'properties' }
IceCodeDefinition >> allPropertyNames [
	"Answer the names of the IcePropertyDefinition objects that are owned by this definition."

	^ #()
]

{ #category : 'comparing' }
IceCodeDefinition >> hash [
	^ super hash bitXor: self contents hash
]

{ #category : 'properties' }
IceCodeDefinition >> ownedDefinitions [
	^ self propertyDefinitions
]

{ #category : 'properties' }
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
