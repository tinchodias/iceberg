dependencies
referencedNames

	^ ((RBParser parseMethod: definition source) allChildren
		select: #isVariable) collect: #name