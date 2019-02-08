dependencies
addPackageDependencyOfPackageNamed: aString

	dependencies add:
			(IcePackageDependency new
				name: aString;
				yourself)