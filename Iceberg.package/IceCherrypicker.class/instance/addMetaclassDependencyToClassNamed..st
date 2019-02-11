dependencies
addMetaclassDependencyToClassNamed: aSymbol
	
	dependencies add: (IceMetaclassDependency new
				name: aSymbol;
				yourself)