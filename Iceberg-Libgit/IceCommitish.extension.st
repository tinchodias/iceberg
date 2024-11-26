Extension { #name : 'IceCommitish' }

{ #category : '*Iceberg-Libgit' }
IceCommitish >> commitId [

	^ LGitId fromHexString: self commit id
]
