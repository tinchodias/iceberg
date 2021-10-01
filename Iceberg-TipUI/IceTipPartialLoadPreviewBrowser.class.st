Class {
	#name : #IceTipPartialLoadPreviewBrowser,
	#superclass : #IceTipBrowser,
	#instVars : [
		'diffPanel',
		'buttonBar'
	],
	#category : #'Iceberg-TipUI-View-Branch'
}

{ #category : #commands }
IceTipPartialLoadPreviewBrowser class >> buildGeneralCommandGroupWith: presenter for: aCommandGroup [

	"Nothing to add"
]

{ #category : #commands }
IceTipPartialLoadPreviewBrowser class >> buildSelectionCommandGroupWith: presenter for: aCommandGroup [

	"Nothing to add"
]

{ #category : #specs }
IceTipPartialLoadPreviewBrowser class >> defaultSpec [

	^ SpBoxLayout newTopToBottom
		  add: #diffPanel;
		  add: #buttonBar height: self buttonHeight;
		  yourself
]

{ #category : #'instance creation' }
IceTipPartialLoadPreviewBrowser class >> onDiff: anIceDiff [

	^ self on: (IceTipPartialLoadModel onDiff: anIceDiff)
]

{ #category : #actions }
IceTipPartialLoadPreviewBrowser >> doLoad [

	IceTipStandardAction new
		repository: self model repository;
		message: 'Applying selected changes';
		onSuccessRepositoryModified;
		execute: [ 
			| mergeTree |
			mergeTree := diffPanel model tree.
			mergeTree accept: IceMergeToChangeTreeVisitor new.
			self model repository workingCopy
				loadChangesInWorkingCopy: mergeTree;
				forceCalculateDirtyPackages.
			self closeWindow ]
]

{ #category : #initialization }
IceTipPartialLoadPreviewBrowser >> initialExtentForWindow [

	^ (800 @ 600) scaledByDisplayScaleFactor
]

{ #category : #initialization }
IceTipPartialLoadPreviewBrowser >> initializePresenters [
	super initializePresenters.

	diffPanel := self
		instantiate: (IceTipMergeSelectingPanel onDiff: self model diff).
	buttonBar := self newButtonBar.
	buttonBar add: self newActionButton.

	diffPanel leftLabel: 'Working Copy'.
	diffPanel rightLabel: ' Cherrypicked change '
]

{ #category : #'accessing - ui' }
IceTipPartialLoadPreviewBrowser >> mainList [
	"Answer the presenter that is the main list of items of this browser."

	^ diffPanel iceNodesTree
]

{ #category : #'private - factory' }
IceTipPartialLoadPreviewBrowser >> newActionButton [

	^ self newButton
		label: 'Load';
		icon: (self iconNamed: #merge);
		help: 'Apply changes into your Working Copy';
		action: [ self doLoad ];
		yourself
]

{ #category : #initialization }
IceTipPartialLoadPreviewBrowser >> titleForWindow [

	^ 'Choose what to load in the image'
]
