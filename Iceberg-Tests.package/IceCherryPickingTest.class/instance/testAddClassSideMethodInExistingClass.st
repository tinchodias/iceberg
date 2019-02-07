tests
testAddClassSideMethodInExistingClass
	
	| commitToCherryPick diff |
		
	self repository createBranch: 'b2'.
	self repository workingCopy addPackageNamed: self packageName1.
	self repository workingCopy createMethod: 'm1 ^42' inClass: 'TestClass' isMeta: true.
	self repository commitWithMessage: 'Adding Method'.
	commitToCherryPick := fixture repository head.

	self repository checkoutBranch: 'master'.
	diff := fixture repository cherryPickFrom: commitToCherryPick.

	self assert: diff codeSubdirectoryNode children size equals: 1.
	self assert: (diff codeSubdirectoryNode / self packageName1) children size equals: 1.

	self assert: (diff codeSubdirectoryNode / self packageName1 / 'TestClass class') value isAddition.

	self assert: (diff codeSubdirectoryNode / self packageName1 / 'TestClass class' / 'm1') value isAddition.
