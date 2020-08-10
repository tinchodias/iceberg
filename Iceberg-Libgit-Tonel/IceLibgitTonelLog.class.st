"
I'm a tool to ask the full history of a method (based on tonel file format).
"
Class {
	#name : #IceLibgitTonelLog,
	#superclass : #IceLog,
	#category : #'Iceberg-Libgit-Tonel'
}

{ #category : #testing }
IceLibgitTonelLog class >> isAvailableFor: aRepository [
	^ aRepository writerClass id = #tonel
]

{ #category : #private }
IceLibgitTonelLog >> basepathOf: aPath [ 
	^ aPath copyAfterLast: $/
]

{ #category : #private }
IceLibgitTonelLog >> definitionFor: aMethod path: aPath commit: aCommit [
	^ ((IceLibgitTonelLogReader fileName: aPath on: aCommit)
		package: aMethod package mcPackage; 
		packageDirectory: (self repository directoryPathStringForPackage: aMethod package);
		definitions)
		detect: [ :each | each isMethodDefinition and: [ each selector = aMethod selector  ] ]
		ifNone: [ 
			 "not found, return 'NULL' object: compare will fail anyway"
			MCMethodDefinition 
				className: aMethod origin name
				selector: aMethod selector
				category: #''
				timeStamp: nil
				source: '' ]
]

{ #category : #'path building' }
IceLibgitTonelLog >> fileNameForMethod: aMethod [
	| path |
	
	path := OrderedCollection new.
	self repository subdirectory 
		ifNotEmpty: [ :subDir | path add: subDir ].
	path add: (self tonelPackageName: aMethod package).
	path add: (self tonelMethodClassOrTraitName: aMethod).
	
	^ String streamContents: [ :stream |
		path asStringOn: stream delimiter: '/' ]
]

{ #category : #'path building' }
IceLibgitTonelLog >> fileNameForPackageNamed: aPackageName [
	"Answer the path string for a package."

	^ String streamContents: [ :stream |
		self repository subdirectory
			ifNotEmpty: [ :subDir |
				stream nextPutAll: subDir; nextPut: $/ ].
		stream nextPutAll: aPackageName ]
]

{ #category : #'path building' }
IceLibgitTonelLog >> fileNameForPackageNamed: aPackageName classNamed: aName isTrait: isTrait isMeta: isMeta [
	"Answer the path string for the instance- and class-side definitions of a class or trait. In Tonel, they are all together in the same file."

	^ '{1}/{2}'
		format:
			{(self fileNameForPackageNamed: aPackageName).
			(isTrait
				ifTrue: [ self tonelTraitNamed: aName ]
				ifFalse: [ self tonelClassNamed: aName ])}
]

{ #category : #'path building' }
IceLibgitTonelLog >> fileNameForPackageNamed: aPackageName classNamed: aClassName isTrait: isTrait isMeta: isMeta selector: aSelector [
		"Answer the path string for a method. In Tonel, methods have the same path as the container (class, trait or extension)."

	^ self
		fileNameForPackageNamed: aPackageName
		classNamed: aClassName
		isTrait: isTrait
		isMeta: isMeta
]

{ #category : #private }
IceLibgitTonelLog >> toFileName: aMethod [
	^ self fileNameForMethod: aMethod
]

{ #category : #private }
IceLibgitTonelLog >> tonelClassNamed: aString [
	^ aString, '.class.st'
]

{ #category : #private }
IceLibgitTonelLog >> tonelExtensionNamed: aString [
	^ aString, '.extension.st'
]

{ #category : #private }
IceLibgitTonelLog >> tonelMethodClassOrTraitName: aMethod [
	| containerName |
	containerName := aMethod origin instanceSide name.
	aMethod isExtension
		ifTrue: [ ^ self tonelExtensionNamed: containerName ].
	aMethod origin isTrait
		ifTrue: [ ^ self tonelTraitNamed: containerName ].
	^ self tonelClassNamed: containerName
]

{ #category : #private }
IceLibgitTonelLog >> tonelPackageName: aPackage [
	^ aPackage name	
]

{ #category : #private }
IceLibgitTonelLog >> tonelTraitNamed: aString [
	^ aString, '.trait.st'
]
