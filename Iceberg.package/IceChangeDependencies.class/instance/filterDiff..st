filtering
filterDiff: anIceDiff 

	IceDiffFilterByDependencies new
		filterDiff: anIceDiff 
		dependencies: self. 
	
	^ anIceDiff	