Extension { #name : 'MCClassDefinition' }

{ #category : '*Iceberg' }
MCClassDefinition >> basicVariables: aCollection [
	variables := aCollection
]

{ #category : '*Iceberg' }
MCClassDefinition >> copyWithVariable: aMCVariableDefinition [
	| copy |
	copy := self copy.
	(copy variables includes: aMCVariableDefinition)
		ifFalse: [ copy basicVariables: (variables copyWith: aMCVariableDefinition) ].
	^ copy
]

{ #category : '*Iceberg' }
MCClassDefinition >> copyWithoutVariable: aMCVariableDefinition [
	^ self copy
		basicVariables: (variables copyWithout: aMCVariableDefinition);
		yourself
]

{ #category : '*Iceberg' }
MCClassDefinition >> copyWithoutVariables [
	^ self copy
		basicVariables: OrderedCollection new;
		yourself
]

{ #category : '*Iceberg' }
MCClassDefinition >> fullDefinitionString [
	^ String streamContents: [:stream | 
		self printDefinitionOn: stream.
		stream cr; cr.
		self printClassDefinitionOn: stream.
		stream cr; cr.
		stream << self comment ]
]

{ #category : '*Iceberg' }
MCClassDefinition >> isEqualIgnoringCommentTo: aDefinition [ 
	^(super = aDefinition)
		and: [superclassName = aDefinition superclassName
		and: [self traitCompositionString = aDefinition traitCompositionString
		and: [self classTraitCompositionString = aDefinition classTraitCompositionString
		and: [category = aDefinition category
		and: [type = aDefinition type
		and: [self sortedVariables = aDefinition sortedVariables ]]]]]]
]

{ #category : '*Iceberg-Changes' }
MCClassDefinition >> removeMetaSideVariables [
	
	variables := variables reject: [ :e | e isClassInstanceVariable ].

]
