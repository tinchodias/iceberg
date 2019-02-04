running
setUp 

	super setUp.
	
	repository workingCopy addPackageNamed: self packageName1.
	repository workingCopy createClass: 'TestClass' inPackage: self packageName1 asSymbol.
	repository commitWithMessage: 'Initial commit'.
