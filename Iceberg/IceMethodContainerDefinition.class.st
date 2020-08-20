"
I am an abstract class representing an IceDefinition that is a container of methods. I.e., a class, a trait or an extension.

I have a name which is the name of the container I represent. If I'm meta-side, I add to my name a suffix class. For example: Integer class.

I also contain the monticello definition that corresponds to me.

See my super/subclasses for more information.
"
Class {
	#name : #IceMethodContainerDefinition,
	#superclass : #IceCodeDefinition,
	#instVars : [
		'mcDefinition'
	],
	#category : #'Iceberg-Changes'
}

{ #category : #'instance creation' }
IceMethodContainerDefinition class >> named: aString [
	
	^ self new
		name: aString;
		yourself
]

{ #category : #patching }
IceMethodContainerDefinition >> allPropertyNames [
	^ MCClassDefinition instVarNames copyWithoutAll: #(name variables commentStamp)
]

{ #category : #patching }
IceMethodContainerDefinition >> asMCDefinition [
	^ mcDefinition
]

{ #category : #private }
IceMethodContainerDefinition >> childrenDefinitions [
	^ self propertyDefinitions, self variableDefinitions
{ #category : #converting }
IceMethodContainerDefinition >> asMCDefinitionWithoutMetaSide [
	
	self subclassResponsibility
]

{ #category : #accessing }
IceMethodContainerDefinition >> contents [
	mcDefinition ifNil: [ ^ '' ].
	^ self isMeta
		ifFalse: [ mcDefinition fullDefinitionString ]
		ifTrue: [ mcDefinition classDefinitionString ]
]

{ #category : #patching }
IceMethodContainerDefinition >> mcDefinition [
	^ mcDefinition
]

{ #category : #patching }
IceMethodContainerDefinition >> mcDefinition: aMCDefinition [
	mcDefinition := aMCDefinition
]

{ #category : #patching }
IceMethodContainerDefinition >> removeFrom: aPatcher [
	
	aPatcher removeClass: self
]

{ #category : #patching }
IceMethodContainerDefinition >> variableDefinitions [
	^ mcDefinition variables
		collect: [ :each | 
			IceVariableDefinition new
				mcVariableDefinition: each;
				containerIceDefinition: self;
				yourself ]
]
