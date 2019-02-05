tests
testAddMethodInTraitAsDependency
	
	| commitToCherryPick diff |
		
	self repository createBranch: 'b2'.

	self repository workingCopy addPackageNamed: self packageName1.
	self repository workingCopy createTrait: 'TestTrait' inPackage: self packageName1 asSymbol.
	self repository commitWithMessage: 'Adding test trait'.

	self repository workingCopy addPackageNamed: self packageName1.	
	self repository workingCopy createMethod: 'm1 ^42' inClass: 'TestTrait'.

	self repository commitWithMessage: 'Adding Method'.
	commitToCherryPick := fixture repository head.

	self repository checkoutBranch: 'master'.
	diff := fixture repository cherryPickFrom: commitToCherryPick.

	self assert: diff codeSubdirectoryNode children size equals: 1.
	self assert: (diff codeSubdirectoryNode / self packageName1) children size equals: 1.

	self assert: (diff codeSubdirectoryNode / self packageName1 / 'TestTrait') value isAddition.
	self assert: (diff codeSubdirectoryNode / self packageName1 / 'TestTrait') children size equals: 1.
	self assert: (diff codeSubdirectoryNode / self packageName1 / 'TestTrait' / 'm1') value isAddition.
