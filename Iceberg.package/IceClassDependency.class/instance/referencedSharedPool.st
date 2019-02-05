dependencies
referencedSharedPool

	^ (definition sharedPoolsString splitOn: ' ') collect: #asSymbol