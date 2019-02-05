querying
ifFound: aBlockClosure 
	
	results size = 0 ifTrue: [ ^ self ].
	
	self assert: results size = 1.
	
	aBlockClosure value: results anyOne 