dependencies
addClassDependencyOf: aMCClassDefinition
	
	dependencies add: (IceClassDependency new
				definition: aMCClassDefinition;
				yourself)