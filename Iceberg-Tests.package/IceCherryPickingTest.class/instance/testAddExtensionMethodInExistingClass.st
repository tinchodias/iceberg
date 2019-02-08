tests
testAddExtensionMethodInExistingClass
	
	| commitToCherryPick diff |
		
	self repository createBranch: 'b2'.
	self repository workingCopy addPackageNamed: self packageName2.
	self repository workingCopy createMethod: 'm1 ^42' extendingClass: 'TestClass' inPackage: self packageName2.
	self repository commitWithMessage: 'Adding extension method'.
	commitToCherryPick := fixture repository head.

	self repository checkoutBranch: 'master'.
	diff := fixture repository cherryPickFrom: commitToCherryPick.

	self assert: diff codeSubdirectoryNode children size equals: 1.
	self assert: (diff codeSubdirectoryNode / self packageName2) children size equals: 1.
	self assert: (diff codeSubdirectoryNode / self packageName2 / 'TestClass') value isAddition.
	self assert: (diff codeSubdirectoryNode / self packageName2 / 'TestClass' / 'm1') value isAddition.
