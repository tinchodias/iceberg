"
I represent a class read from an Iceberg repository, either from a commit or from the working directory in disk.

My contents is the class definition code.

See my superclasses for more information.
"
Class {
	#name : #IceClassDefinition,
	#superclass : #IceMethodContainerDefinition,
	#category : #'Iceberg-Changes'
}

{ #category : #visiting }
IceClassDefinition >> accept: aVisitor [ 
	
	^ aVisitor visitClassDefinition: self
]

{ #category : #patching }
IceClassDefinition >> addModification: anotherIceDefinition toPatcher: aMCPatcher [
	
	"Let the original MCClassDefinition intact, and give the responsability to modify it to the IceContainedDefinitions."
	
	"NOTE: MCPatcher is the other kind of visitor"
	
	(aMCPatcher isKindOf: MCPackageLoader) ifTrue: [ 
							aMCPatcher
		modifyDefinition: anotherIceDefinition asMCDefinition
		to: self asMCDefinition 
		
		]

]

{ #category : #patching }
IceClassDefinition >> addToPatcher: aMCPatcher [ 
	
	aMCPatcher addDefinition: self asMCDefinition "copyWithoutVariables" "Variables will be added by IceVariableDefinitions"
]

{ #category : #accessing }
IceClassDefinition >> contents [
	^ mcDefinition fullDefinitionString
]

{ #category : #testing }
IceClassDefinition >> isClassDefinition [
	
	^ true
]

{ #category : #'as yet unclassified' }
IceClassDefinition >> isLowImpactAppliedTo: anIceClassDefinition [ 
	^ mcDefinition isEqualIgnoringCommentTo: anIceClassDefinition mcDefinition 
]

{ #category : #patching }
IceClassDefinition >> removeInPatcher: aMCPatcher [ 
	
	aMCPatcher removeDefinition: self asMCDefinition 
]
