visiting
visitModification: anIceModification

	(dependencies includesDependencyTo: anIceModification definition)
		ifFalse: [ toRemove add: currentNode ]