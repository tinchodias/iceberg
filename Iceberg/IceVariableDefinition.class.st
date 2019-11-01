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
	^ '> ' , mcVariableDefinition name , ' (', self typeToShow, ')'
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
		nextPutAll: '(';
		print: name.
	aStream
		nextPutAll: ' -> ';
		print: self typeToShow;
		nextPutAll: ')'

]

{ #category : #printing }
IceVariableDefinition >> removeInPatcher: aMCPatcher [

	(aMCPatcher isKindOf: MCPackageLoader) ifTrue: [
		^ self "containerIceDefinition is just fine" ].
	
	
	aMCPatcher definitionIndex
		definitionLike: self containerIceDefinition asMCDefinition
		ifPresent: [ :currentDefinition | 
			aMCPatcher addDefinition: (self removedIn: currentDefinition) ]
		ifAbsent: [" self error" ('do nothing in removeInPatcher: ', self asString) logCr ]
]

{ #category : #patching }
IceVariableDefinition >> removedIn: aMCDefinition [
	^ aMCDefinition copyWithoutVariable: mcVariableDefinition
]

{ #category : #accessing }
IceVariableDefinition >> typeToShow [
	^ mcVariableDefinition class type
]
