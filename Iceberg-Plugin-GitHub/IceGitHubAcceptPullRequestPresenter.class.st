"
I'm a dialog for collecting data to accept a pull request.
"
Class {
	#name : 'IceGitHubAcceptPullRequestPresenter',
	#superclass : 'IceTipPresenter',
	#instVars : [
		'messageLabel',
		'messageText',
		'typeLabel',
		'typeList',
		'acceptBlock'
	],
	#category : 'Iceberg-Plugin-GitHub-View',
	#package : 'Iceberg-Plugin-GitHub',
	#tag : 'View'
}

{ #category : 'accessing' }
IceGitHubAcceptPullRequestPresenter class >> defaultPreferredExtent [
	^ (600 @ 300)
]

{ #category : 'class initialization' }
IceGitHubAcceptPullRequestPresenter class >> initialize [

	self deprecatedAliases: { #IceGitHubAcceptPullRequestModel }
]

{ #category : 'actions' }
IceGitHubAcceptPullRequestPresenter >> accept [

	acceptBlock ifNotNil: [ 
		acceptBlock cull: self ].
	self closeWindow
]

{ #category : 'accessing' }
IceGitHubAcceptPullRequestPresenter >> availableTypes [

	^ #( 'merge' 'squash' 'rebase' )
]

{ #category : 'initialization' }
IceGitHubAcceptPullRequestPresenter >> connectPresenters [

	self typeList
		items: self availableTypes;
		selectItem: self defaultType
]

{ #category : 'layout' }
IceGitHubAcceptPullRequestPresenter >> defaultLayout [

	^ SpGridLayout new 
		beColumnNotHomogeneous;
		column: 2 expand: true;
		build: [ :builder | builder
			add: messageLabel; add: messageText; nextRow;
			add: typeLabel; add: typeList; nextRow ];
		yourself
]

{ #category : 'accessing' }
IceGitHubAcceptPullRequestPresenter >> defaultType [

	^ 'merge'
]

{ #category : 'initialization' }
IceGitHubAcceptPullRequestPresenter >> initializeDialogWindow: aDialogWindowPresenter [
	
	aDialogWindowPresenter
		addButton: 'Cancel' do: [ :presenter | 
			presenter triggerCancelAction.
			presenter close ];
		addDefaultButton: 'Accept' do: [ :presenter | 
			self accept ]
]

{ #category : 'initialization' }
IceGitHubAcceptPullRequestPresenter >> initializePresenters [

	messageLabel := self newLabel.
	messageText := self newText.
	typeLabel := self newLabel.
	typeList := self newDropList.
		
	messageLabel label: 'Comment'.
	messageText addStyle: 'lines8'.
	messageText placeholder: self messageGhostText.
	typeLabel label: 'Merge type'
]

{ #category : 'accessing' }
IceGitHubAcceptPullRequestPresenter >> message [

	^ self messageText text asString
]

{ #category : 'accessing' }
IceGitHubAcceptPullRequestPresenter >> messageGhostText [

	^ 'Commit title

Add an optional extented description'
]

{ #category : 'accessing - ui' }
IceGitHubAcceptPullRequestPresenter >> messageLabel [

	^ messageLabel
]

{ #category : 'accessing - ui' }
IceGitHubAcceptPullRequestPresenter >> messageText [

	^ messageText
]

{ #category : 'events' }
IceGitHubAcceptPullRequestPresenter >> onAccept: aBlock [
	acceptBlock := aBlock
]

{ #category : 'specs' }
IceGitHubAcceptPullRequestPresenter >> titleForWindow [

	^ 'Accept pull request'
]

{ #category : 'accessing' }
IceGitHubAcceptPullRequestPresenter >> type [

	^ self typeList selectedItem
]

{ #category : 'accessing - ui' }
IceGitHubAcceptPullRequestPresenter >> typeLabel [

	^ typeLabel
]

{ #category : 'accessing - ui' }
IceGitHubAcceptPullRequestPresenter >> typeList [

	^ typeList
]
