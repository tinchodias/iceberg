visiting
visitClassDefinition: anIceClassDefinition
	
	dependencies addClassDependencyOf: anIceClassDefinition asMCDefinition.	
	dependencies addSuperClassDependencyOf: anIceClassDefinition asMCDefinition.

	^ dependencies