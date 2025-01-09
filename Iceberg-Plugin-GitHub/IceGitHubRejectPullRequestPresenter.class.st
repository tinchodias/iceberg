"
I'm a dialog to collect data about a pull request rejection.
"
Class {
	#name : 'IceGitHubRejectPullRequestPresenter',
	#superclass : 'IceTipPresenter',
	#instVars : [
		'messageLabel',
		'messageText',
		'acceptButton',
		'acceptBlock'
	],
	#category : 'Iceberg-Plugin-GitHub-View',
	#package : 'Iceberg-Plugin-GitHub',
	#tag : 'View'
}

{ #category : 'class initialization' }
IceGitHubRejectPullRequestPresenter class >> initialize [

	self deprecatedAliases: { #IceGitHubRejectPullRequestModel }
]

{ #category : 'actions' }
IceGitHubRejectPullRequestPresenter >> accept [

	acceptBlock ifNotNil: [ acceptBlock cull: self ].

	self closeWindow
]

{ #category : 'accessing - ui' }
IceGitHubRejectPullRequestPresenter >> acceptButton [

	^ acceptButton
]

{ #category : 'accessing' }
IceGitHubRejectPullRequestPresenter >> availableTypes [

	^ #( 'merge' 'squash' 'rebase' )
]

{ #category : 'layout' }
IceGitHubRejectPullRequestPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		borderWidth: 5;
		spacing: 5;
		add: messageLabel expand: false;
		add: messageText;
		yourself
]

{ #category : 'accessing' }
IceGitHubRejectPullRequestPresenter >> defaultType [

	^ 'merge'
]

{ #category : 'api' }
IceGitHubRejectPullRequestPresenter >> initialExtentForWindow [

	^ (500 @ 250) scaledByDisplayScaleFactor
]

{ #category : 'initialization' }
IceGitHubRejectPullRequestPresenter >> initializeDialogWindow: aDialogWindowPresenter [

	aDialogWindowPresenter
		addButton: 'Cancel' do: [ :presenter | 
			presenter triggerCancelAction.
			presenter close ];
		addDefaultButton: 'Reject' do: [ :presenter | 
			presenter triggerOkAction.
			presenter close ]
]

{ #category : 'initialization' }
IceGitHubRejectPullRequestPresenter >> initializePresenters [

	super initializePresenters.
	messageLabel := self newLabel.
	messageText := self newText autoAccept: true.
	acceptButton := self newButton.

	messageLabel label: 'Comment'.
	messageText placeholder: self messageGhostText.
	acceptButton
		label: 'Reject pull request';
		action: [ self accept ].

]

{ #category : 'accessing' }
IceGitHubRejectPullRequestPresenter >> message [

	^ self messageText text asString
]

{ #category : 'accessing' }
IceGitHubRejectPullRequestPresenter >> messageGhostText [

	^ 'Commit title

Add an optional extented description'
]

{ #category : 'accessing - ui' }
IceGitHubRejectPullRequestPresenter >> messageLabel [

	^ messageLabel
]

{ #category : 'accessing - ui' }
IceGitHubRejectPullRequestPresenter >> messageText [

	^ messageText
]

{ #category : 'events' }
IceGitHubRejectPullRequestPresenter >> onAccept: aBlock [

	acceptBlock := aBlock
]

{ #category : 'specs' }
IceGitHubRejectPullRequestPresenter >> titleForWindow [

	^ 'Reject pull request'
]
