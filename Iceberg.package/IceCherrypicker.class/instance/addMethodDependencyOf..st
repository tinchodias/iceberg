dependencies
addMethodDependencyOf: aMCMethodDefinition 
	
	dependencies add: (IceMethodDependency new
				definition: aMCMethodDefinition;
				yourself)