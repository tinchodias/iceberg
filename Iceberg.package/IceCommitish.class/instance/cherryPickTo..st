cherry-picking
cherryPickTo: anotherCommit 

	| initialDiff extendedDiff |
	initialDiff := self commit diffToParent.
   extendedDiff := self diffTo: anotherCommit.

	IceCherrypicker executeFrom: initialDiff to: extendedDiff.
	
	^ extendedDiff