tests
testModifyClassWithoutDependencies
	
	| commitToCherryPick diff |
		
	self repository createBranch: 'b2'.
	self repository workingCopy addPackageNamed: self packageName1.
	self repository workingCopy createClass: 'TestClass' inPackage: self packageName1 asSymbol 
		with: [ :class | class instanceVariables: #(someInstVar) ].
	self repository commitWithMessage: 'Modifying Test Class'.
	commitToCherryPick := self repository head.

	self repository checkoutBranch: 'master'.
	diff := fixture repository cherryPickFrom: commitToCherryPick.

	self assert: diff codeSubdirectoryNode children size equals: 1.
	self assert: (diff codeSubdirectoryNode / self packageName1) children size equals: 1.
	self assert: (diff codeSubdirectoryNode / self packageName1 / 'TestClass') value isModification.
	self assert: (diff codeSubdirectoryNode / self packageName1 / 'TestClass') value definition isClassDefinition.
