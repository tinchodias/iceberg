cherry-picking
cherryPickTo: anotherCommit 

	| diffToParent diffToHead cherrypicker | 
	
	diffToParent := self commit diffToParent.
   diffToHead := self diffTo: anotherCommit.

	"Obtain the initial change set (ICS)"
	cherrypicker := IceCherrypickerBuilder newCherrypickerOn: diffToParent.

	"Obtain an estimated transitive change set (ETCS)"
   cherrypicker addTransitiveDependencies: diffToHead.

	"Transform the diff to hold the ETCS"
	IceCherrypickerDiffPruner new
		cherrypicker: cherrypicker;
		applyTo: diffToHead.
	
	^ diffToHead