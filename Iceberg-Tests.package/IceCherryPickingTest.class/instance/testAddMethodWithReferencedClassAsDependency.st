tests
testAddMethodWithReferencedClassAsDependency
	
	| commitToCherryPick diff |
		
	self repository createBranch: 'b2'.

	self repository workingCopy addPackageNamed: self packageName1.
	self repository workingCopy 
		createClass: 'TestClass2' 
		inPackage: self packageName1 asSymbol .
	self repository commitWithMessage: 'Adding a test class'.

	self repository workingCopy addPackageNamed: self packageName1.	
	self repository workingCopy createMethod: 'm1 ^TestClass2' inClass: 'TestClass'.
	self repository commitWithMessage: 'Adding a method'.
	commitToCherryPick := fixture repository head.

	self repository checkoutBranch: 'master'.
	diff := fixture repository cherryPickFrom: commitToCherryPick.

	self assert: diff codeSubdirectoryNode children size equals: 1.
	self assert: (diff codeSubdirectoryNode / self packageName1) children size equals: 2.

	self assert: (diff codeSubdirectoryNode / self packageName1 / 'TestClass2') value isAddition.
	self assert: (diff codeSubdirectoryNode / self packageName1 / 'TestClass2') children size equals: 0.

	self assert: (diff codeSubdirectoryNode / self packageName1 / 'TestClass' / 'm1') value isAddition.
