testing
includesDependencyTo: aDefinition

	^ dependencies anySatisfy: [ :each | each isDependencyTo: aDefinition ]. 