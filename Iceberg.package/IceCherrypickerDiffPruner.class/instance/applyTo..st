applying
applyTo: anIceDiff
	
	nodesToRemove := Set new.
	
	anIceDiff accept: self.
	
	nodesToRemove do: [ :aNode | aNode parent removeChild: aNode ].
