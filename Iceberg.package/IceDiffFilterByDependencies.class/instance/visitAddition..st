visiting
visitAddition: anIceAddition 
	
	(dependencies includesDependencyTo: anIceAddition definition) 
		ifFalse: [ toRemove add: currentNode ]