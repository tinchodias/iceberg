"
I'm a dialog to ask for data relevant to create a pull request.
"
Class {
	#name : 'IceGitHubCreatePullRequestPresenter',
	#superclass : 'IceTipPresenter',
	#instVars : [
		'repository',
		'titleLabel',
		'headLabel',
		'headForkList',
		'headBranchList',
		'baseLabel',
		'baseForkList',
		'baseBranchList',
		'bodyLabel',
		'acceptBlock',
		'availableRemotes',
		'availableBranchNames',
		'baseRemote',
		'gitRepositoryInfo',
		'credentials',
		'baseBranches',
		'headRemote',
		'lastCommitMessage',
		'titleTextInput',
		'bodyText'
	],
	#category : 'Iceberg-Plugin-GitHub-View',
	#package : 'Iceberg-Plugin-GitHub',
	#tag : 'View'
}

{ #category : 'class initialization' }
IceGitHubCreatePullRequestPresenter class >> initialize [

	self deprecatedAliases: { #IceGitHubCreatePullReqsuestModel }
]

{ #category : 'instance creation' }
IceGitHubCreatePullRequestPresenter class >> new [
	self error: 'Use #repository:credentials:headRemote:'
]

{ #category : 'instance creation' }
IceGitHubCreatePullRequestPresenter class >> newApplication: anApplication 
	repository: aRepository 
	credentials: aCredentials 
	headRemote: aRemote [

	^ self basicNew
		application: anApplication;
		initializeRepository: aRepository
		  	credentials: aCredentials
		  	headRemote: aRemote;
		yourself
]

{ #category : 'accessing' }
IceGitHubCreatePullRequestPresenter class >> titleSize [

	^ 80
]

{ #category : 'actions' }
IceGitHubCreatePullRequestPresenter >> accept [

	| title |
	title := self titlePanel text trim.
	title ifEmpty: [ 
		self application newInform
			label: 'You need to specify a title for the pull request.'; 
			title: 'Error';
			openModal.
		^ self ].
	
	acceptBlock ifNotNil: [ 
		acceptBlock cull: self createPullRequest ].
	
	self closeWindow
]

{ #category : 'accessing' }
IceGitHubCreatePullRequestPresenter >> availableBranchNames [

	^ availableBranchNames ifNil: [ 
		  availableBranchNames := self obtainAvailableBranchNames ]
]

{ #category : 'accessing' }
IceGitHubCreatePullRequestPresenter >> availableRemotes [
	"Retrieves available remotes to perform the PR"

	^ availableRemotes ifNil: [ 
		  availableRemotes := self obtainAvailableRemotes ]
]

{ #category : 'accessing - ui' }
IceGitHubCreatePullRequestPresenter >> baseBranchList [
	^ baseBranchList
]

{ #category : 'private' }
IceGitHubCreatePullRequestPresenter >> baseBranchNames [

	^ self baseBranches collect: [ :each | each at: #name ]
]

{ #category : 'private' }
IceGitHubCreatePullRequestPresenter >> baseBranches [

	^ baseBranches ifNil: [ baseBranches := self requestBaseBranches ]
]

{ #category : 'accessing' }
IceGitHubCreatePullRequestPresenter >> baseDefaultBranchName [

	^ self gitBase at: #default_branch
]

{ #category : 'accessing - ui' }
IceGitHubCreatePullRequestPresenter >> baseForkList [
	^ baseForkList
]

{ #category : 'accessing - ui' }
IceGitHubCreatePullRequestPresenter >> baseLabel [
	^ baseLabel
]

{ #category : 'accessing' }
IceGitHubCreatePullRequestPresenter >> baseRemote [
	"This is the 'base' remote (the place where the repository is forked). This is used to 
	 suggest fork PR destination (base)"

	^ baseRemote ifNil: [ baseRemote := self obtainBaseRemote ]
]

{ #category : 'accessing - ui' }
IceGitHubCreatePullRequestPresenter >> bodyLabel [
	^ bodyLabel
]

{ #category : 'accessing - ui' }
IceGitHubCreatePullRequestPresenter >> bodyPanel [
	^ bodyText
]

{ #category : 'accessing' }
IceGitHubCreatePullRequestPresenter >> branch [

	^ self repository branch
]

{ #category : 'private' }
IceGitHubCreatePullRequestPresenter >> createPullRequest [

	^ IceGitHubPullRequestDefinition new 
		credentials: self credentials;
		title: self titlePanel text trim;
		headRemote: self headForkList selectedItem;
		headBranchName: self headBranchList selectedItem;
		baseRemote: self baseForkList selectedItem;
		baseBranchName: self baseBranchList selectedItem;
		body: self bodyPanel text asString trim;
		yourself
]

{ #category : 'accessing' }
IceGitHubCreatePullRequestPresenter >> credentials [

	^ credentials
]

{ #category : 'accessing' }
IceGitHubCreatePullRequestPresenter >> credentials: aCredentials [

	credentials := aCredentials
]

{ #category : 'accessing' }
IceGitHubCreatePullRequestPresenter >> defaultBaseBranchName [

	self hasParent ifFalse: [ ^ self baseDefaultBranchName ].
	^ self baseBranchNames
		  detect: [ :each | each = self branch shortname ]
		  ifNone: [ self baseDefaultBranchName ]
]

{ #category : 'accessing' }
IceGitHubCreatePullRequestPresenter >> defaultHeadBranchName [

	^ self branch shortname
]

{ #category : 'layout' }
IceGitHubCreatePullRequestPresenter >> defaultLayout [

	^ SpGridLayout new 
		beColumnNotHomogeneous;
		column: 2 expand: true;
		column: 3 expand: true;
		build: [ :builder | builder
			add: titleLabel; add: titleTextInput span: 2@1; nextRow;
			add: headLabel; add: headForkList; add: headBranchList; nextRow;
			add: baseLabel; add: baseForkList; add: baseBranchList; nextRow;
			add: bodyLabel; add: bodyText span: 2@1; nextRow ]; 
		yourself
]

{ #category : 'private' }
IceGitHubCreatePullRequestPresenter >> gitBase [

	| json |
	json := self gitRepositoryInfo.
	^ json at: #parent ifAbsent: [ json ]
]

{ #category : 'private' }
IceGitHubCreatePullRequestPresenter >> gitRepositoryInfo [

	^ gitRepositoryInfo ifNil: [ 
		  gitRepositoryInfo := self requestGitRepositoryInfo ]
]

{ #category : 'private' }
IceGitHubCreatePullRequestPresenter >> hasParent [

	^ self gitRepositoryInfo includesKey: #parent
]

{ #category : 'accessing - ui' }
IceGitHubCreatePullRequestPresenter >> headBranchList [
	^ headBranchList
]

{ #category : 'accessing - ui' }
IceGitHubCreatePullRequestPresenter >> headForkList [
	^ headForkList
]

{ #category : 'accessing - ui' }
IceGitHubCreatePullRequestPresenter >> headLabel [
	^ headLabel
]

{ #category : 'accessing' }
IceGitHubCreatePullRequestPresenter >> headRemote [

	^ headRemote ifNil: [ self repository head upstream remote ]
]

{ #category : 'initialization' }
IceGitHubCreatePullRequestPresenter >> initialExtentForWindow [

	^ (700 @ 300) scaledByDisplayScaleFactor
]

{ #category : 'initialization' }
IceGitHubCreatePullRequestPresenter >> initializeDialogWindow: aWindow [

	aWindow
		addButton: 'Cancel' do: [ :presenter | 
			presenter triggerCancelAction.
			presenter close ];
		addDefaultButton: 'Create' do: [ 
			self accept ]

]

{ #category : 'initialization' }
IceGitHubCreatePullRequestPresenter >> initializePresenters [

	titleLabel := self newLabel label: 'Title'.
	headLabel := self newLabel label: 'From (Head)'.
	baseLabel := self newLabel label: 'To (Base)'.
	bodyLabel := self newLabel label: 'Comment'.

	titleTextInput := self newTextInput.

	headForkList := self newDropList.
	baseForkList := self newDropList.

	headBranchList := self newDropList.
	baseBranchList := self newDropList.

	bodyText := self newText
		addStyle: 'lines8';
		yourself
]

{ #category : 'initialization' }
IceGitHubCreatePullRequestPresenter >> initializeRepository: aRepository credentials: aCredentials headRemote: aRemote [

	repository := aRepository.
	credentials := aCredentials.
	headRemote := aRemote.
	self initialize
]

{ #category : 'accessing' }
IceGitHubCreatePullRequestPresenter >> lastCommitMessage [

	^ lastCommitMessage ifNil: [ lastCommitMessage := self obtainLastCommitMessage ]
]

{ #category : 'private' }
IceGitHubCreatePullRequestPresenter >> obtainAvailableBranchNames [

	^ ((self repository allBranches collect: #shortname as: Set)
			addAll: self baseBranchNames;
			asArray)
			sort

]

{ #category : 'private' }
IceGitHubCreatePullRequestPresenter >> obtainAvailableRemotes [

	| remotes |
	remotes := self repository remotes.
	(remotes includes: self baseRemote)
		ifFalse: [ remotes := remotes copyWith: self baseRemote ].
	^ remotes	

]

{ #category : 'private' }
IceGitHubCreatePullRequestPresenter >> obtainBaseRemote [
	| base sshUrl httpUrl |
	
	base := self gitBase.
	sshUrl := base at: #ssh_url.
	httpUrl := (base at: #git_url) copyReplaceAll: 'git://' with: 'https://'.
	^ self repository remotes 
		detect: [ :each | { sshUrl. httpUrl } includes: each url ]
		ifNone: [  
			(IceGitRemote url: httpUrl)
				name: (base at: #full_name);
				yourself ]
]

{ #category : 'private' }
IceGitHubCreatePullRequestPresenter >> obtainLastCommitMessage [

	^ self branch commit comment
]

{ #category : 'events' }
IceGitHubCreatePullRequestPresenter >> onAccept: aBlock [

	acceptBlock := aBlock
]

{ #category : 'private' }
IceGitHubCreatePullRequestPresenter >> proposedComment [
	| lines firstLine remainingLines |
	
	lines := self lastCommitMessage lines.
	remainingLines := lines allButFirst.
	firstLine := lines first size > self class titleSize
		ifTrue: [ '...', (lines first allButFirst: (self class titleSize - 3)) ]
		ifFalse: [ nil ].
		
	^ String streamContents: [ :stream |
		firstLine 
			ifNotNil: [ stream << firstLine; cr ]
			ifNil: [ remainingLines ifNotEmpty: [ stream << '...' ] ].
			remainingLines 
				do: [ :each | stream << each ]
				separatedBy: [ stream cr ] ]
]

{ #category : 'private' }
IceGitHubCreatePullRequestPresenter >> proposedTitle [
	
	self lastCommitMessage linesDo: [ :eachLine |
		^ eachLine size > self class titleSize 
			ifTrue: [ eachLine truncateWithElipsisTo: self class titleSize ]
			ifFalse: [ eachLine ] ].
		
	^ ''
]

{ #category : 'accessing' }
IceGitHubCreatePullRequestPresenter >> repository [

	^ repository
]

{ #category : 'private - request' }
IceGitHubCreatePullRequestPresenter >> requestBaseBranches [

	^ IceGitHubAPI new
		  credentials: self credentials;
		  getBranches: self baseRemote owner
		  project: self baseRemote projectBasename
]

{ #category : 'private - request' }
IceGitHubCreatePullRequestPresenter >> requestGitRepositoryInfo [

	| remote |
	remote := self headRemote.
	^ IceGitHubAPI new
		  credentials: self credentials;
		  getRepository: remote owner project: remote projectBasename
]

{ #category : 'specs' }
IceGitHubCreatePullRequestPresenter >> titleForWindow [

	^ 'New pull request'
]

{ #category : 'accessing - ui' }
IceGitHubCreatePullRequestPresenter >> titleLabel [

	^ titleLabel
]

{ #category : 'accessing - ui' }
IceGitHubCreatePullRequestPresenter >> titlePanel [

	^ titleTextInput
]

{ #category : 'initialization' }
IceGitHubCreatePullRequestPresenter >> updatePresenter [

	baseForkList
		items: self availableRemotes;
		display: [ :aRemote | aRemote name ];
		selectItem: self baseRemote.
	baseBranchList
		items: self baseBranchNames;
		selectItem: self defaultBaseBranchName.
 	headForkList
		items: self availableRemotes;
		display: [ :aRemote | aRemote name ];
		selectItem: self headRemote.
	headBranchList 
		items: self availableBranchNames;
		selectItem: self branch name.
		
	titleTextInput text: self proposedTitle.
	bodyText text: self proposedComment
]
