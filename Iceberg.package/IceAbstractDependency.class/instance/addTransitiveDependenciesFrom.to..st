dependencies
addTransitiveDependenciesFrom: anIceDiff to: anIceChangeDependencies 
	
	self referencedClasses do: [ :aName | 
		IceNodeQuery new
			on: anIceDiff tree;
			className: aName;
			execute;
			ifFound: [ :aIceNode | anIceChangeDependencies addClassDependencyOf: aIceNode value definition asMCDefinition ]].
