Extension { #name : #IceMethodDefinition }

{ #category : #'*Iceberg-TipUI' }
IceMethodDefinition >> browse [
	
	| owner |
	owner := Smalltalk globals at: self className.
	self classIsMeta ifTrue: [ owner := owner classSide ].
	owner compiledMethodAt: name ifPresent: #browse.
]

{ #category : #'*Iceberg-TipUI' }
IceMethodDefinition >> canBeBrowsed [
	
	^ Smalltalk globals at: className
		ifPresent: [ :class | class includesSelector: name ]
		ifAbsent: [ false ]
]

{ #category : #'*Iceberg-TipUI' }
IceMethodDefinition >> canBrowseReferences [
	
	^ false
]

{ #category : #'*Iceberg-TipUI' }
IceMethodDefinition >> icon [
	
	^ self iconNamed: #changeUpdate
]
