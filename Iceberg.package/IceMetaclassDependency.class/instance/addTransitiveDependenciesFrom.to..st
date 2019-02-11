dependencies
addTransitiveDependenciesFrom: anIceDiff to: anIceCherrypicker

	IceNodeQuery new
		on: anIceDiff tree;
		className: name;
		execute;
		ifFound: [ :aIceNode | 
			anIceCherrypicker addClassDependencyOf: aIceNode value definition asMCDefinition ]