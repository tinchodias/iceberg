adding changes
addSuperClassDependencyOf: aMCClassDefinition
	
	dependencies add: (IceSuperclassDependency new
				className: aMCClassDefinition className;
				superclassName: aMCClassDefinition superclassName;
				yourself)