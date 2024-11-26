Extension { #name : 'IceMethodDefinition' }

{ #category : '*Iceberg-TipUI' }
IceMethodDefinition >> browse [
	
	| owner |
	owner := self class environment at: self ownerName.
	self classIsMeta ifTrue: [ owner := owner classSide ].
	(owner >> name) browse
]

{ #category : '*Iceberg-TipUI' }
IceMethodDefinition >> canBeBrowsed [
	
	^ self class environment at: self ownerName
		ifPresent: [ :class | class includesSelector: name ]
		ifAbsent: [ false ]
]

{ #category : '*Iceberg-TipUI' }
IceMethodDefinition >> canBrowseReferences [
	
	^ false
]

{ #category : '*Iceberg-TipUI' }
IceMethodDefinition >> iconName [
	
	^ #changeUpdate
]
