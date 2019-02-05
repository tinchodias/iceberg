tests
testAddMethodThatVariablesThatAreNotDependencies
	
	| commitToCherryPick diff |
		
	self repository createBranch: 'b2'.

	self repository workingCopy addPackageNamed: self packageName1.	
	self repository workingCopy createMethod: 'm1 ^{self. super. true. false. nil. Smalltalk}' inClass: 'TestClass'.
	self repository commitWithMessage: 'Adding a method'.
	commitToCherryPick := fixture repository head.

	self repository checkoutBranch: 'master'.
	diff := fixture repository cherryPickFrom: commitToCherryPick.

	self assert: diff codeSubdirectoryNode children size equals: 1.
	self assert: (diff codeSubdirectoryNode / self packageName1) children size equals: 1.
	self assert: (diff codeSubdirectoryNode / self packageName1 / 'TestClass' / 'm1') value isAddition.
