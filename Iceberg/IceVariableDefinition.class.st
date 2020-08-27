"
I represent a variable of an IceClassDefinition or IceTraitDefinition.

Variables have a name, that identify them, and a type. They can be added and removed from the container.
"
Class {
	#name : #IceVariableDefinition,
	#superclass : #IceContainedDefinition,
	#instVars : [
		'mcVariableDefinition'
	],
	#category : #'Iceberg-Changes'
}

{ #category : #comparing }
IceVariableDefinition >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	^ super = anObject
		and: [ mcVariableDefinition = anObject mcVariableDefinition ]
]

{ #category : #visiting }
IceVariableDefinition >> accept: aVisitor [
	^ aVisitor visitVariableDefinition: self
]

{ #category : #patching }
IceVariableDefinition >> addedIn: aMCDefinition [
	^ aMCDefinition copyWithVariable: mcVariableDefinition
]

{ #category : #accessing }
IceVariableDefinition >> contents [
	
	^ ''
]

{ #category : #comparing }
IceVariableDefinition >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ super hash bitXor: mcVariableDefinition hash
]

{ #category : #accessing }
IceVariableDefinition >> icon [
	^ self iconNamed: #menuPin
]

{ #category : #accessing }
IceVariableDefinition >> key [
	^ '>Variable (' , self typeToShow, '): ', mcVariableDefinition name
]

{ #category : #accessing }
IceVariableDefinition >> mcVariableDefinition [
	^ mcVariableDefinition
]

{ #category : #accessing }
IceVariableDefinition >> mcVariableDefinition: aMCVariableDefinition [
	mcVariableDefinition := aMCVariableDefinition.
	self name: mcVariableDefinition name
]

{ #category : #printing }
IceVariableDefinition >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	super printOn: aStream.
	aStream
		nextPut: $(;
		print: name.
	aStream
		nextPutAll: ' -> ';
		print: self typeToShow;
		nextPut: $)

]

{ #category : #printing }
IceVariableDefinition >> removeFromPatcher: aMCPatcher [

	self flag: #todo. "Check this"
	(aMCPatcher isKindOf: MCPackageLoader)
		ifTrue: [ ^ self	"containerIceDefinition is just fine" ].
	aMCPatcher definitionIndex
		definitionLike: self containerIceDefinition asMCDefinition
		ifPresent: [ :currentDefinition |
			aMCPatcher addDefinition: (self removedIn: currentDefinition) ]
		ifAbsent: [ 1halt ]
]

{ #category : #patching }
IceVariableDefinition >> removedIn: aMCDefinition [
	^ aMCDefinition copyWithoutVariable: mcVariableDefinition
]

{ #category : #accessing }
IceVariableDefinition >> typeToShow [
	^ mcVariableDefinition class type
]