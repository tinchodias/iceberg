dependencies
addTransitiveDependenciesFrom: anIceDiff to: anIceChangeDependencies

	IceNodeQuery new
		on: anIceDiff tree;
		className: name;
		execute;
		ifFound: [ :aIceNode | 
			anIceChangeDependencies addClassDependencyOf: aIceNode value definition asMCDefinition ]