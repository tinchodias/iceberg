testing
includesDependencyTo: aDefinition
 
	^ dependencies anySatisfy: [ :aDep | aDep isDependencyTo: aDefinition ]. 