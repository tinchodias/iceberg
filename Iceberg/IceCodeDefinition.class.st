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
IceCodeDefinition >> addInPatcher: aMCPatcher [ 
	
	self subclassResponsibility
]

{ #category : #properties }
IceCodeDefinition >> allPropertyNames [
	^ #()
]

{ #category : #properties }
IceCodeDefinition >> childrenDefinitions [
	^ self propertyDefinitions
]

{ #category : #comparing }
IceCodeDefinition >> hash [
	^ super hash bitXor: self contents hash
]

{ #category : #patching }
IceCodeDefinition >> modifyFrom: anotherIceDefinition inPatcher: aMCPatcher [ 
	
	self subclassResponsibility
]

{ #category : #properties }
IceCodeDefinition >> propertyDefinitions [
	^ self allPropertyNames
		collect: [ :each | 
			IcePropertyDefinition new
				name: each;
				containerIceDefinition: self;
				yourself.
			 ].

]

{ #category : #patching }
IceCodeDefinition >> removeFrom: aPatcher [
	
	self subclassResponsibility
]
