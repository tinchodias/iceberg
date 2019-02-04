cherry-picking
cherryPickTo: anotherCommit 

	| diffToParent |
	
	diffToParent := self commit diffToParent.	
   ^ diffToParent dependencies filterDiff: (self diffTo: anotherCommit).