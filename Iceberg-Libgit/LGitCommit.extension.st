Extension { #name : #LGitCommit }

{ #category : #'*Iceberg-Libgit' }
LGitCommit >> parentAt: anInteger [
	"Answer the nth parent (1-based)."

	| parentOid |
	parentOid := LGitId
		fromHandle: (self commit_parent_id: self n: (anInteger - 1)) getHandle.
	^ self class of: self repository fromId: parentOid
]
