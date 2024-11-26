"
I represent a method read from an Iceberg repository, either from a commit or from the working directory in disk.

My contents is the code of the method.

See my superclasses for more information.
"
Class {
	#name : 'IceMethodDefinition',
	#superclass : 'IceOwnedDefinition',
	#instVars : [
		'classIsMeta',
		'protocol',
		'sourceCode'
	],
	#category : 'Iceberg-Changes',
	#package : 'Iceberg',
	#tag : 'Changes'
}

{ #category : 'instance creation' }
IceMethodDefinition class >> owner: anIceDefinition classIsMeta: classIsMeta protocol: protocol selector: aString sourceCode: source [

	^ (self named: aString)
		ownerIceDefinition: anIceDefinition;
		classIsMeta: classIsMeta;
		protocol: protocol;
		sourceCode: source;
		yourself
]

{ #category : 'comparing' }
IceMethodDefinition >> = anotherDefinition [
	"A method can be equal and belong to another class (and be in the other side). 
	 And yes, even if this usually should not happen, it happens (and not always is incorrect)"
	^ super = anotherDefinition 
		and: [ self classIsMeta = anotherDefinition classIsMeta ]
]

{ #category : 'visiting' }
IceMethodDefinition >> accept: aVisitor [
	
	^ aVisitor visitMethodNode: self
]

{ #category : 'morphic - compatibility' }
IceMethodDefinition >> actualClass [

	^ self contextClass
]

{ #category : 'patching' }
IceMethodDefinition >> addModification: anotherIceDefinition toPatcher: aMCPatcher [
	aMCPatcher
		modifyDefinition: anotherIceDefinition asMCDefinition
		to: self asMCDefinition
]

{ #category : 'patching' }
IceMethodDefinition >> addToPatcher: aMCPatcher [ 
	
	aMCPatcher addDefinition: self asMCDefinition
]

{ #category : 'patching' }
IceMethodDefinition >> asMCDefinition [

	^ MCMethodDefinition 
		className: self ownerName
		classIsMeta: self classIsMeta
		selector: self name
		category: self protocol
		timeStamp: ''
		source: sourceCode
]

{ #category : 'accessing' }
IceMethodDefinition >> ast [

	^ RBParser parseMethod: sourceCode
]

{ #category : 'accessing' }
IceMethodDefinition >> classIsMeta [
	^ classIsMeta
]

{ #category : 'accessing' }
IceMethodDefinition >> classIsMeta: aBoolean [
	classIsMeta := aBoolean
]

{ #category : 'accessing' }
IceMethodDefinition >> contents [

	^ '"', self protocol, '"
', sourceCode
]

{ #category : 'morphic-compatibility' }
IceMethodDefinition >> contextClass [
	
	| class |
	class := self class environment at: self ownerName ifAbsent: [ ^ nil ].
	self classIsMeta ifTrue: [ class := class classSide ].
	^ class
]

{ #category : 'actions' }
IceMethodDefinition >> install [
	
	self asMCDefinition load
]

{ #category : 'morphic - compatibility' }
IceMethodDefinition >> isLoadable [
	^ self contextClass isNotNil
]

{ #category : 'testing' }
IceMethodDefinition >> isLowImpactAppliedTo: anotherIceMethodDefinition [

	^ sourceCode = anotherIceMethodDefinition sourceCode
		or: [ self ast = anotherIceMethodDefinition ast ]
]

{ #category : 'testing' }
IceMethodDefinition >> isMethodDefinition [
	
	^ true
]

{ #category : 'accessing' }
IceMethodDefinition >> protocol [
	^ protocol
]

{ #category : 'accessing' }
IceMethodDefinition >> protocol: aString [
	protocol := aString
]

{ #category : 'patching' }
IceMethodDefinition >> removeFrom: aPatcher [
	
	aPatcher removeMethod: self
]

{ #category : 'patching' }
IceMethodDefinition >> removeFromPatcher: aMCPatcher [ 
	
	aMCPatcher removeDefinition: self asMCDefinition
]

{ #category : 'accessing' }
IceMethodDefinition >> selector [
	
	^ name
]

{ #category : 'accessing' }
IceMethodDefinition >> sourceCode [

	^ sourceCode
]

{ #category : 'accessing' }
IceMethodDefinition >> sourceCode: aString [

	sourceCode := aString
]

{ #category : 'accessing' }
IceMethodDefinition >> type [

	^ self classIsMeta
		ifTrue: [ 'class method' ]
		ifFalse: [ 'method' ]
]
