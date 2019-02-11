visiting
visitClassDefinition: anIceClassDefinition

	anIceClassDefinition isMeta
		ifTrue: [ cherrypicker addMetaclassDependencyToClassNamed: anIceClassDefinition basicName ]
		ifFalse: [ cherrypicker addClassDependencyOf: anIceClassDefinition asMCDefinition ]