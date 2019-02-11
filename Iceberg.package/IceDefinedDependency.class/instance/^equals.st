comparing
= anObject
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self species = anObject species ifFalse: [ ^ false ].
	^ definition className = anObject definition className