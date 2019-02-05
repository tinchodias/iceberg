comparing
= anObject

	^ super = anObject and: [superclassName = anObject superclassName]
