testing
visitMethodNode: anIceMethodDefinition 
	
	^ anIceMethodDefinition asMCDefinition className = definition className and: [ anIceMethodDefinition asMCDefinition selector = definition selector ]