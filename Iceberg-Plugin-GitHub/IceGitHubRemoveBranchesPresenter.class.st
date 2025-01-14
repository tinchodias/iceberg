"
I'm a dialog to select a list of anything (used by branches now).
"
Class {
	#name : 'IceGitHubRemoveBranchesPresenter',
	#superclass : 'IceTipPresenter',
	#instVars : [
		'selectedItems',
		'listPanel',
		'acceptBlock',
		'displayBlock',
		'remote'
	],
	#category : 'Iceberg-Plugin-GitHub-View',
	#package : 'Iceberg-Plugin-GitHub',
	#tag : 'View'
}

{ #category : 'accessing' }
IceGitHubRemoveBranchesPresenter class >> defaultPreferredExtent [ 


	^ 550 @ 500
]

{ #category : 'class initialization' }
IceGitHubRemoveBranchesPresenter class >> initialize [

	self deprecatedAliases: { #IceGitHubRemoveBranchesModel }
]

{ #category : 'actions' }
IceGitHubRemoveBranchesPresenter >> confirmSelection [

	acceptBlock ifNotNil: [ acceptBlock value: selectedItems ].
	self closeWindow
]

{ #category : 'layout' }
IceGitHubRemoveBranchesPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: listPanel;"
		  add: selectButton expand: false;"
		  yourself
]

{ #category : 'api' }
IceGitHubRemoveBranchesPresenter >> displayBlock: aBlock [
	
	displayBlock := aBlock
]

{ #category : 'initialization' }
IceGitHubRemoveBranchesPresenter >> initialize [

	selectedItems := Set new.
	super initialize
]

{ #category : 'initialization' }
IceGitHubRemoveBranchesPresenter >> initializeDialogWindow: aDialogWindowPresenter [

	aDialogWindowPresenter
		addButton: 'Cancel' do: [ :presenter | 
			presenter triggerCancelAction.
			presenter close ];
		addDefaultButton: 'Remove' do: [ :presenter | 
			self triggerAcceptAction.
			presenter close ]		
]

{ #category : 'initialization' }
IceGitHubRemoveBranchesPresenter >> initializePresenters [

	listPanel := self newTable.
	listPanel
		addColumn: (SpCheckBoxTableColumn new
			evaluated: [ :branch | selectedItems includes: branch ];
			onActivation: [ :branch | selectedItems add: branch ];
			onDeactivation: [ :branch | selectedItems remove: branch ];
			beNotExpandable;
			yourself);
		addColumn: (SpStringTableColumn evaluated: [ :branch | branch at: 'name' ]);
		addColumn: (SpStringTableColumn evaluated: [ :branch | self timeSinceLastCommit: branch ])
]

{ #category : 'api' }
IceGitHubRemoveBranchesPresenter >> items: aCollection [

	self listPanel items: aCollection
]

{ #category : 'accessing - ui' }
IceGitHubRemoveBranchesPresenter >> listPanel [

	^ listPanel
]

{ #category : 'events' }
IceGitHubRemoveBranchesPresenter >> onAccept: aBlock [

	acceptBlock := aBlock
]

{ #category : 'accessing' }
IceGitHubRemoveBranchesPresenter >> remote [

	^ remote
]

{ #category : 'accessing' }
IceGitHubRemoveBranchesPresenter >> remote: anObject [

	remote := anObject
]

{ #category : 'accessing' }
IceGitHubRemoveBranchesPresenter >> timeSinceLastCommit: branch [

	| lastCommitDate |
	lastCommitDate := 	((((branch at: 'commit') at: 'commit')
		at: 'author') at: 'date')asDateAndTime.
		^ '{1} days' format: {(Date today - lastCommitDate) days}
]

{ #category : 'initialization' }
IceGitHubRemoveBranchesPresenter >> titleForWindow [

	^ 'Select branches to remove on remote {1}' format:
		  { self remote name }
]

{ #category : 'private' }
IceGitHubRemoveBranchesPresenter >> triggerAcceptAction [
		
	acceptBlock ifNil: [ ^ self ].
	acceptBlock value: selectedItems
]
