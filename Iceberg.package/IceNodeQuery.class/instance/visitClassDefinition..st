visiting
visitClassDefinition: anIceClassDefinition 
	
	anIceClassDefinition asMCDefinition className = entityName ifTrue: [ results add: currentNode ].