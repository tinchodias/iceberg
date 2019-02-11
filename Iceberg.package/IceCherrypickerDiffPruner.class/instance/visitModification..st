visiting
visitModification: anIceModification

	(cherrypicker includesDependencyTo: anIceModification definition)
		ifFalse: [ nodesToRemove add: currentNode ]