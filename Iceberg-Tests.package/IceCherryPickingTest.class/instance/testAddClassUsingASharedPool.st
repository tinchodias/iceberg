tests
testAddClassUsingASharedPool
	
	| commitToCherryPick diff |
		
	self repository createBranch: 'b2'.

	self repository workingCopy addPackageNamed: self packageName1.
	self repository workingCopy 
		createClass: 'TestSharedPool' 
		inPackage: self packageName1 asSymbol 
		with: [:class | class superclass: (class environment ask behaviorNamed: #SharedPool)].
	self repository commitWithMessage: 'Adding a Shared Pool'.

	self repository workingCopy addPackageNamed: self packageName1.
	self repository workingCopy 
		createClass: 'TestClass2' 
		inPackage: self packageName1 asSymbol 
		with: [:class | class sharedPools: #(TestSharedPool)  ].
	self repository commitWithMessage: 'Adding a class using sharedpools'.

	commitToCherryPick := fixture repository head.

	self repository checkoutBranch: 'master'.
	diff := fixture repository cherryPickFrom: commitToCherryPick.

	self assert: diff codeSubdirectoryNode children size equals: 1.
	self assert: (diff codeSubdirectoryNode / self packageName1) children size equals: 2.

	self assert: (diff codeSubdirectoryNode / self packageName1 / 'TestClass2') value isAddition.
	self assert: (diff codeSubdirectoryNode / self packageName1 / 'TestClass2') children size equals: 0.

	self assert: (diff codeSubdirectoryNode / self packageName1 / 'TestSharedPool') value isAddition.
	self assert: (diff codeSubdirectoryNode / self packageName1 / 'TestSharedPool') children size equals: 0.
