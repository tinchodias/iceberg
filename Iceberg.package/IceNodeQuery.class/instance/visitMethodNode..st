visiting
visitMethodNode: anIceMethodDefinition 

	anIceMethodDefinition asMCDefinition selector = selector ifTrue: [ results add: currentNode ].