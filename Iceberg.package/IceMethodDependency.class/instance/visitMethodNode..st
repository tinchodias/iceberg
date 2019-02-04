testing
visitMethodNode: anIceMethodDefinition 
	
	^ anIceMethodDefinition asMCDefinition className = className and: [ anIceMethodDefinition asMCDefinition selector = selector ]