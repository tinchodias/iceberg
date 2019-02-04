tests
testCherryPickingClassNoConflictsAndNoDependencies
	
	| commitToCherryPick diff |
	
	self repository workingCopy addPackageNamed: self packageName1.
	fixture repository workingCopy createClass: 'TestClass' inPackage: self packageName1 asSymbol.
	fixture repository commitWithMessage: 'Initial commit'.
	
	fixture repository createBranch: 'b2'.
	self repository workingCopy addPackageNamed: self packageName1.
	fixture repository workingCopy createClass: 'TestClass2' inPackage: self packageName1 asSymbol.
	fixture repository commitWithMessage: 'Adding Test Class'.
	commitToCherryPick := fixture repository head.

	fixture repository checkoutBranch: 'master'.
	diff := fixture repository cherryPickChangesTo: commitToCherryPick.

	self assert: diff codeSubdirectoryNode children size equals: 1.
	self assert: (diff codeSubdirectoryNode / self packageName1) children size equals: 1.
	self assert: (diff codeSubdirectoryNode / self packageName1 / 'TestClass2') value isAddition.
	self assert: (diff codeSubdirectoryNode / self packageName1 / 'TestClass2') value definition isClassDefinition.
