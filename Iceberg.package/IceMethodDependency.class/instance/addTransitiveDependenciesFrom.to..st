transitive dependencies
addTransitiveDependenciesFrom: anIceDiff to: anIceChangeDependencies 

	IceNodeQuery new
		on: anIceDiff tree;
		className: className;
		execute;
		ifFound: [ :aIceNode | anIceChangeDependencies addClassDependencyOf: aIceNode value definition asMCDefinition ].
