visiting
visitClassDefinition: anIceClassDefinition 
	
	anIceClassDefinition asMCDefinition className = className ifTrue: [ results add: currentNode ].