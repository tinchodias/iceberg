testing
isDependencyTo: anIceMethodDefinition

	^ 	anIceMethodDefinition asMCDefinition isMethodDefinition and: [ 
		anIceMethodDefinition asMCDefinition className = definition className and: [ 
		anIceMethodDefinition asMCDefinition selector = definition selector ] ]