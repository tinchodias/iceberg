dependencies
addTransitiveDependenciesFrom: anIceDiff to: anIceCherrypicker 
	
	self referencedClasses do: [ :aName | 
		IceNodeQuery new
			on: anIceDiff tree;
			className: aName;
			execute;
			ifFound: [ :aIceNode | anIceCherrypicker addClassDependencyOf: aIceNode value definition asMCDefinition ]].

	self referencedTraits do: [ :aName | 
		IceNodeQuery new
			on: anIceDiff tree;
			traitName: aName;
			execute;
			ifFound: [ :aIceNode | anIceCherrypicker addTraitDependencyOf: aIceNode value definition asMCDefinition ]].
