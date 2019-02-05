comparing
= anObject

	^ super = anObject and: [definition superclassName = anObject definition superclassName]
