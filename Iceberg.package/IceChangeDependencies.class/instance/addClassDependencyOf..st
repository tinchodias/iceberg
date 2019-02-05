adding changes
addClassDependencyOf: aMCClassDefinition
	
	dependencies add: (IceClassDependency new
				className: aMCClassDefinition className;
				superclassName: aMCClassDefinition superclassName;
				yourself)