transitive dependencies
addTransitiveDependencies: anIceDiff

	| originalDependencies |
	originalDependencies := nil.
	
	[ 	originalDependencies ~= dependencies ] whileTrue: [
		originalDependencies := dependencies copy.
		originalDependencies do: [ :each |
			each addTransitiveDependenciesFrom: anIceDiff to: self ] ]