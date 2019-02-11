visiting
visitAddition: anIceAddition 
	
	(cherrypicker includesDependencyTo: anIceAddition definition) 
		ifFalse: [ nodesToRemove add: currentNode ]