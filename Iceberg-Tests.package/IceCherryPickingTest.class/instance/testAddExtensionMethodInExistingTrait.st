tests
testAddExtensionMethodInExistingTrait
	
	| commitToCherryPick diff |
		
	self repository createBranch: 'b2'.
	self repository workingCopy addPackageNamed: self packageName2.
	self repository workingCopy createMethod: 'm1 ^42' extendingClass: 'TestTraitInitial' inPackage: self packageName2.
	self repository commitWithMessage: 'Adding extension method'.
	commitToCherryPick := fixture repository head.

	self repository checkoutBranch: 'master'.
	diff := fixture repository cherryPickFrom: commitToCherryPick.

	self assert: diff codeSubdirectoryNode children size equals: 1.
	self assert: (diff codeSubdirectoryNode / self packageName2) children size equals: 1.
	self assert: (diff codeSubdirectoryNode / self packageName2 / 'TestTraitInitial') value isAddition.
	self assert: (diff codeSubdirectoryNode / self packageName2 / 'TestTraitInitial' / 'm1') value isAddition.
