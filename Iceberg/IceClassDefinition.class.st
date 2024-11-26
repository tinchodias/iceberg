"
I represent a class read from an Iceberg repository, either from a commit or from the working directory in disk.

My contents is the class definition code.

See my superclasses for more information.
"
Class {
	#name : 'IceClassDefinition',
	#superclass : 'IceMethodContainerDefinition',
	#category : 'Iceberg-Changes',
	#package : 'Iceberg',
	#tag : 'Changes'
}

{ #category : 'visiting' }
IceClassDefinition >> accept: aVisitor [ 
	
	^ aVisitor visitClassDefinition: self
]

{ #category : 'patching' }
IceClassDefinition >> addModification: anotherIceDefinition toPatcher: aMCPatcher [
	
	"Let the original MCClassDefinition intact, and give the responsability to modify it to the IceContainedDefinitions."
	
	"NOTE: MCPatcher is the other kind of visitor"
	
	(aMCPatcher isKindOf: MCPackageLoader) ifTrue: [ 
							aMCPatcher
		modifyDefinition: anotherIceDefinition asMCDefinition
		to: self asMCDefinition 
		
		]

]

{ #category : 'patching' }
IceClassDefinition >> addToPatcher: aMCPatcher [ 
	
	aMCPatcher addDefinition: self asMCDefinition "copyWithoutVariables" "Variables will be added by IceVariableDefinitions"
]

{ #category : 'patching' }
IceClassDefinition >> allPropertyNames [
	"Answer the names of the IcePropertyDefinition objects that are owned by this definition.
	
	As an optimization, given that mcDefinition has a MCClassDefinition, this implementation answers the result of this expression:
	MCClassDefinition instVarNames copyWithoutAll: #(name variables commentStamp) "

	^ #( #superclassName #category #type #comment #traitComposition
	     #classTraitComposition )
]

{ #category : 'converting' }
IceClassDefinition >> asMCDefinitionWithoutMetaSide [
	
	^ mcDefinition deepCopy removeMetaSideVariables

]

{ #category : 'accessing' }
IceClassDefinition >> contents [
	mcDefinition ifNil: [ ^'' ].
	^ mcDefinition fullDefinitionString
]

{ #category : 'testing' }
IceClassDefinition >> isClassDefinition [
	
	^ true
]

{ #category : 'testing' }
IceClassDefinition >> isLowImpactAppliedTo: anIceClassDefinition [ 
	^ mcDefinition isEqualIgnoringCommentTo: anIceClassDefinition mcDefinition 
]

{ #category : 'patching' }
IceClassDefinition >> removeFromPatcher: aMCPatcher [ 
	
	aMCPatcher removeDefinition: self asMCDefinition 
]
