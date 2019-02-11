convenience
executeFrom: initialDiff to: extendedDiff

	self new
		sourceDiff: initialDiff;
		targetDiff: extendedDiff;
		execute