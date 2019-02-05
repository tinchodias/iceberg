tests
testAddMethodWithInstanceVariableAsDependency
	
	| commitToCherryPick diff |
		
	self repository createBranch: 'b2'.

	self repository workingCopy addPackageNamed: self packageName1.
	self repository workingCopy 
		createClass: 'TestClass2' 
		inPackage: self packageName1 asSymbol 
		with: [:class | class instanceVariables: #(aInstanceVariable)].
	self repository commitWithMessage: 'Adding a test class with an instance variable'.

	self repository workingCopy addPackageNamed: self packageName1.
	self repository workingCopy 
		createClass: 'TestClass3' 
		inPackage: self packageName1 asSymbol 
		with: [:class | class superclass: (class environment ask behaviorNamed: #TestClass2) ].
	self repository commitWithMessage: 'Adding another test class'.

	self repository workingCopy addPackageNamed: self packageName1.	
	self repository workingCopy createMethod: 'm1 ^aInstanceVariable' inClass: 'TestClass3' asSymbol.
	self repository commitWithMessage: 'Adding method using test an instance variable'.

	commitToCherryPick := fixture repository head.

	self repository checkoutBranch: 'master'.
	diff := fixture repository cherryPickFrom: commitToCherryPick.

	self assert: diff codeSubdirectoryNode children size equals: 1.
	self assert: (diff codeSubdirectoryNode / self packageName1) children size equals: 2.

	self assert: (diff codeSubdirectoryNode / self packageName1 / 'TestClass2') value isAddition.
	self assert: (diff codeSubdirectoryNode / self packageName1 / 'TestClass2') children size equals: 0.

	self assert: (diff codeSubdirectoryNode / self packageName1 / 'TestClass3') value isAddition.
	self assert: (diff codeSubdirectoryNode / self packageName1 / 'TestClass3') children size equals: 1.

	self assert: (diff codeSubdirectoryNode / self packageName1 / 'TestClass3' / 'm1') value isAddition.
