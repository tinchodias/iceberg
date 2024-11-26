Extension { #name : 'MCDefinition' }

{ #category : '*Iceberg' }
MCDefinition >> basicAtPropertyNamed: aName [
	^ self instVarNamed: aName
]

{ #category : '*Iceberg' }
MCDefinition >> basicAtPropertyNamed: aName put: aValue [
	self instVarNamed: aName put: aValue
]

{ #category : '*Iceberg-changes' }
MCDefinition >> isFileDefinition [
	
	^ false
]
