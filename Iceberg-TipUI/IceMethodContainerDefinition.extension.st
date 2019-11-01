Extension { #name : #IceMethodContainerDefinition }

{ #category : #'*Iceberg-TipUI' }
IceMethodContainerDefinition >> browse [
	
	| browsed |
	browsed := Smalltalk globals at: name.
	browsed browse
]

{ #category : #'*Iceberg-TipUI' }
IceMethodContainerDefinition >> canBeBrowsed [
	
	^ Smalltalk globals includesKey: name
]

{ #category : #'*Iceberg-TipUI' }
IceMethodContainerDefinition >> canBrowseReferences [
	
	^ self canBeBrowsed
]
