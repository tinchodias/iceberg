visiting
addMethodDependencyOf: aMCMethodDefinition 
	
	dependencies add: (IceMethodDependency new
		className: aMCMethodDefinition className;
		selector: aMCMethodDefinition selector;
		yourself)