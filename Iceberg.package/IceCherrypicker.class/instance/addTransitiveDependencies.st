execution - private
addTransitiveDependencies

	| originalDependencies |
	originalDependencies := nil.
	
	[ 	originalDependencies ~= dependencies ] whileTrue: [
		originalDependencies := dependencies copy.
		originalDependencies do: [ :each |
			each addTransitiveDependenciesFrom: targetDiff to: self ] ]