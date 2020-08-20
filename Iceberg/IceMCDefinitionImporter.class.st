"
I am an importer that visits MCDefinitions and creates IceDefinitions from them. I install those definitions into a corresponding package node.
"
Class {
	#name : #IceMCDefinitionImporter,
	#superclass : #Object,
	#instVars : [
		'packageNode',
		'snapshot'
	],
	#category : #'Iceberg-Changes'
}

{ #category : #visiting }
IceMCDefinitionImporter >> ensureMethodOwnerNamed: ownerName isMeta: isMeta isTrait: isTrait isExtension: isExtension [
	| newDefinition |
	newDefinition := isExtension
		ifTrue: [ IceExtensionDefinition named: ownerName isMeta: isMeta packageName: packageNode value name]
		ifFalse: [ isTrait
				ifFalse: [ IceClassDefinition named: ownerName isMeta: isMeta ]
				ifTrue: [ IceTraitDefinition named: ownerName isMeta: isMeta ] ].

	^ packageNode
		childAt: newDefinition key
		ifAbsentPut: [ newDefinition ]
]

{ #category : #testing }
IceMCDefinitionImporter >> isExtension: aName [
	
	snapshot classDefinitionNamed: aName ifAbsent:  [ ^ true ].
	^ false
]

{ #category : #testing }
IceMCDefinitionImporter >> isTrait: aName [ 
	
	| definition |
	definition := snapshot classDefinitionNamed: aName ifAbsent: [ ^ false ].
	^ definition isTraitDefinition
]

{ #category : #accessing }
IceMCDefinitionImporter >> packageNode: anIcePackageNode [ 
	packageNode := anIcePackageNode
]

{ #category : #accessing }
IceMCDefinitionImporter >> snapshot: aMCSnapshot [ 
	snapshot := aMCSnapshot
]

{ #category : #visiting }
IceMCDefinitionImporter >> visitClassDefinition: aMCClassDefinition [ 
	
	| classDefinitionNode iceDefinition |
	classDefinitionNode := self
		ensureMethodOwnerNamed: aMCClassDefinition className
		isTrait: false
		isExtension: false.
	iceDefinition := classDefinitionNode value.
	iceDefinition mcDefinition: aMCClassDefinition.
	
	iceDefinition childrenDefinitions do: [ :each |
		classDefinitionNode addChild: each ].
	
	^ classDefinitionNode
]

{ #category : #visiting }
IceMCDefinitionImporter >> visitClassTraitDefinition: aMCClassTraitDefinition [ 

	| classTraitDefinitionNode |
	classTraitDefinitionNode := self
		ensureMethodOwnerNamed: aMCClassTraitDefinition className
		isTrait: true
		isExtension: false.
	classTraitDefinitionNode value mcDefinition: aMCClassTraitDefinition.
	^ classTraitDefinitionNode
]

{ #category : #visiting }
IceMCDefinitionImporter >> visitMetaclassDefinition: aMCClassDefinition [
	"We do nothing because of Monticello meta-model.
	
	The problem is that Monticello visitor does not launch the Metaclass visit if the metaclass does not have any class instance variables or Trait composition. We need this information all the time so we will generate it in the class visit.
	
	The concrete method it MCClassDefinition>>accept:"

]

{ #category : #visiting }
IceMCDefinitionImporter >> visitMethodDefinition: aMCMethodDefinition [ 
	
	| ownerName isMeta isTrait ownerNode iceNode iceDefinition |
	
	ownerName := aMCMethodDefinition className.
	isMeta := aMCMethodDefinition classIsMeta.
	isTrait := self isTrait: aMCMethodDefinition className.
	
	ownerNode := self
		ensureMethodOwnerNamed: ownerName
		isTrait: isTrait
		isExtension: (self isExtension: aMCMethodDefinition className).

	iceDefinition :=
		IceMethodDefinition
			className: ownerName
			classIsMeta: isMeta
			protocol: aMCMethodDefinition protocol
			name: aMCMethodDefinition selector
			sourceCode: aMCMethodDefinition source.

	iceNode := ownerNode addChild: iceDefinition.

	iceDefinition childrenDefinitions do: [ :each |
		iceNode addChild: each ].
	
	^ iceNode 
]

{ #category : #visiting }
IceMCDefinitionImporter >> visitOrganizationDefinition: aMCOrganizationDefinition [ 
	
	packageNode value categories: aMCOrganizationDefinition categories
]

{ #category : #visiting }
IceMCDefinitionImporter >> visitTraitDefinition: aMCTraitDefinition [ 
	
	| traitDefinitionNode |
	traitDefinitionNode := self
		ensureMethodOwnerNamed: aMCTraitDefinition className
		isTrait: true
		isExtension: false.
	traitDefinitionNode value mcDefinition: aMCTraitDefinition.
	^ traitDefinitionNode
]
