filtering
filterDiff: anIceDiff dependencies: anIceChangeDependencies 
	
	dependencies := anIceChangeDependencies.
	toRemove := Set new.
	
	anIceDiff accept: self.
	
	toRemove do: [ :aNode | aNode parent removeChild: aNode ].
	
	^ anIceDiff