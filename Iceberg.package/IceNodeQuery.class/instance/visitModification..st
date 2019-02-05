visiting
visitModification: anIceModification 

	anIceModification definition accept: self.
	self visitChildrenOf: currentNode.