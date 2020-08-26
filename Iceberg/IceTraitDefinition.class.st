"
I represent a trait read from an Iceberg repository, either from a commit or from the working directory in disk.

My contents is the trait definition.

See my superclasses for more information.
"
Class {
	#name : #IceTraitDefinition,
	#superclass : #IceMethodContainerDefinition,
	#category : #'Iceberg-Changes'
}

{ #category : #visiting }
IceTraitDefinition >> accept: aVisitor [
	
	^ aVisitor visitTraitDefinition: self
]

{ #category : #patching }
IceTraitDefinition >> addModification: anotherIceDefinition toPatcher: aMCPatcher [
	
	aMCPatcher
		modifyDefinition: anotherIceDefinition asMCDefinition
		to: self asMCDefinition
]

{ #category : #patching }
IceTraitDefinition >> addToPatcher: aMCPatcher [ 
	
	"We should not handle metaclasses if their mcDefinition is nil.
	They should be added automatically when added the instance side."
	mcDefinition ifNil: [ ^ self ].

	"We should only be in this case if there is not instace-side changes."
	aMCPatcher addDefinition: self asMCDefinition
]

{ #category : #accessing }
IceTraitDefinition >> contents [
	^ mcDefinition definitionString
]

{ #category : #testing }
IceTraitDefinition >> isTraitDefinition [

	^ true
]

{ #category : #patching }
IceTraitDefinition >> removeFromPatcher: aMCPatcher [ 
	
	"We should not handle metaclasses. They will be added automatically when added the instance side"
	mcDefinition ifNil: [ ^ self ].
	
	aMCPatcher removeDefinition: self asMCDefinition
]
