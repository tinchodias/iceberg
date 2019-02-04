tests
testCherryPickingAddingClassWithSuperclassAsDependency
	
	| commitToCherryPick diff |
		
	self repository createBranch: 'b2'.

	self repository workingCopy createClass: #A inPackage: self packageName1 asSymbol.
	self repository workingCopy createClass: #C inPackage: self packageName1 asSymbol.
	self repository commitWithMessage: 'Adding 2 classes'.

	self repository workingCopy createClass: #B inPackage: self packageName1 asSymbol 
		with: [ :class | class superclass: (class environment ask behaviorNamed: #A) ].

	self repository commitWithMessage: 'Adding a subclass of A'.
	commitToCherryPick := self repository head.

	self repository checkoutBranch: 'master'.
	diff := fixture repository cherryPickFrom: commitToCherryPick.

	self assert: diff codeSubdirectoryNode children size equals: 1.
	self assert: (diff codeSubdirectoryNode / self packageName1) children size equals: 2.
	self should: [diff codeSubdirectoryNode / self packageName1 / 'C'] raise: NotFound .

	self assert: (diff codeSubdirectoryNode / self packageName1 / 'A') value definition isClassDefinition.
	self assert: (diff codeSubdirectoryNode / self packageName1 / 'A') value isAddition.
	self assert: (diff codeSubdirectoryNode / self packageName1 / 'B') value isAddition.
	self assert: (diff codeSubdirectoryNode / self packageName1 / 'B') value definition isClassDefinition.
