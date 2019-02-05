visiting
addMethodDependencyOf: aMCMethodDefinition 
	
	dependencies add: (IceMethodDependency new
		definition: aMCMethodDefinition;
		yourself)