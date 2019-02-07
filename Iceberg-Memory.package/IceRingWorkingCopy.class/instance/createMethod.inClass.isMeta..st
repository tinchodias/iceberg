helpers
createMethod: source inClass: aClassName isMeta: aBoolean
	
	| class method package |
	class := ringEnvironment ensureClassNamed: aClassName.
	package := class package.
	aBoolean ifTrue: [ class := class classSide ].
	method := class ensureLocalMethodNamed: (RBParser parseMethod: source) selector.
	method sourceCode: source.
	method package: package.
	self markAsDirtyPackageNamed: package name.