execution - public
execute

	"Obtain the initial change set (ICS)"
	self addInitialDependencies.

	"Obtain an estimated transitive change set (ETCS)"
   self addTransitiveDependencies.

	"Transform the diff to hold the ETCS"
	self pruneUndependedNodesInTargetDiff.
