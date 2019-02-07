visiting
visitClassDefinition: anIceClassDefinition

	anIceClassDefinition isMeta
		ifTrue: [ dependencies addMetaclassDependencyToClassNamed: anIceClassDefinition basicName ]
		ifFalse: [ dependencies addClassDependencyOf: anIceClassDefinition asMCDefinition ]