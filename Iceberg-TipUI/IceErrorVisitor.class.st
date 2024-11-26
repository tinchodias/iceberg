"
I'm a generic error visitor to traverse diferent iceberg errors.
"
Class {
	#name : 'IceErrorVisitor',
	#superclass : 'Object',
	#category : 'Iceberg-TipUI-Model',
	#package : 'Iceberg-TipUI',
	#tag : 'Model'
}

{ #category : '*Iceberg-TipUI' }
IceErrorVisitor >> visitExperimentalFeature: aWarning [
	
	"By default experimental features are just accepted when we are not in an interactive mode".
	aWarning resume
]

{ #category : '*Iceberg-TipUI' }
IceErrorVisitor >> visitNoCommitMessage: aWarning [
	self visitGenericError: aWarning
]
