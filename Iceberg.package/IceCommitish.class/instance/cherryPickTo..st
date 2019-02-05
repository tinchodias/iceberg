cherry-picking
cherryPickTo: anotherCommit 

	| diffToParent diffToHead dependencies | 
	
	diffToParent := self commit diffToParent.	
   diffToHead := self diffTo: anotherCommit.
	dependencies := diffToParent dependencies.

   ^ dependencies 
		addTransitiveDependencies: diffToHead;
		filterDiff: diffToHead.