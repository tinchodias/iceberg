dependencies
referencedTraits

	^ ((RBParser parseExpression: definition traitComposition) allChildren select: #isVariable)
		collect: #name 