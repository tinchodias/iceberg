Class {
	#name : #IceTipMergeSelectingPanel,
	#superclass : #IceTipDiffPanel,
	#instVars : [
		'codePanel',
		'checkedIceNodes'
	],
	#category : #'Iceberg-TipUI-View-Branch'
}

{ #category : #specs }
IceTipMergeSelectingPanel class >> defaultSpec [

	^ SpPanedLayout newLeftToRight
		  positionOfSlider: 25 percent;
		  add: #iceNodesTree;
		  add: (SpPanedLayout newVertical
				   positionOfSlider: 50 percent;
				   add: #diffPanel;
				   add: #codePanel;
				   yourself);
		  yourself
]

{ #category : #private }
IceTipMergeSelectingPanel >> activateItem: iceNode [

	iceNode value selectLeft.
	
	checkedIceNodes add: iceNode.
	iceNode children isEmptyOrNil ifTrue: [ ^ self ].
	iceNode allChildrenDo: [ :child |
		checkedIceNodes add: child ].
	self refreshCheckbox


]

{ #category : #accessing }
IceTipMergeSelectingPanel >> basicRefresh [

	super basicRefresh.
	self refreshCodePanel.
]

{ #category : #initialization }
IceTipMergeSelectingPanel >> changeListColumn [

	^ SpCompositeTableColumn new
		addColumn:
			(SpCheckBoxTableColumn new
				width: 20;
				evaluated: [ :iceNode | checkedIceNodes includes: iceNode ];
				onActivation: [ :iceNode | self activateItem: iceNode ];
				onDeactivation: [ :iceNode | self deactivateItem: iceNode ];
				yourself);
		addColumn:
			(SpImageTableColumn new
				width: 20;
				evaluated: [ :each | each value chosenOperation icon ];
				yourself);
		addColumn: self changeDescriptionColumn;
		yourself
]

{ #category : #private }
IceTipMergeSelectingPanel >> deactivateItem: iceNode [
		
	iceNode value selectRight.

	checkedIceNodes remove: iceNode.
	iceNode children isEmptyOrNil ifTrue: [ ^ self ].
	iceNode allChildrenDo: [ :child |
		checkedIceNodes remove: child ifAbsent: [  ] ].
	self refreshCheckbox.

]

{ #category : #initialization }
IceTipMergeSelectingPanel >> initialize [

	super initialize.
	checkedIceNodes := Set new.
	self model treeRoots do: [ :root | 
		root withAllChildrenDo: [ :child | 
			checkedIceNodes add: child.
			child value isConflict ifTrue: [ child value selectLeft ] ] ]
]

{ #category : #initialization }
IceTipMergeSelectingPanel >> initializePresenters [

	codePanel := self newCode.

	"Super triggers a selection changed that requires that codePanel is already instantiated."
	super initializePresenters.

]

{ #category : #accessing }
IceTipMergeSelectingPanel >> refresh [

	super refresh.
	self model treeRoots do: [ :root |
		root withAllChildrenDo: [ :each | checkedIceNodes add: each ] ].
	self refreshCodePanel 
]

{ #category : #private }
IceTipMergeSelectingPanel >> refreshCheckbox [
	"Refresh after a checkbox state has changed. When a node with children changes this state, all children might change too. That's the reason of this special refresh. When a leave node changed such state, this refresh is redundant."

	iceNodesTree refresh
]

{ #category : #private }
IceTipMergeSelectingPanel >> refreshCodePanel [

	| visitor mergeNode |
	visitor := IceNodeCodeDisplayVisitor onCodePresenter: codePanel.
	mergeNode := iceNodesTree selectedItem value.
	mergeNode
		ifNil: [ codePanel text: '' ]
		ifNotNil: [ mergeNode accept: visitor ]
]

{ #category : #accessing }
IceTipMergeSelectingPanel >> selectedItems [

	^ checkedIceNodes
]

{ #category : #'event handling' }
IceTipMergeSelectingPanel >> selectionChanged [

	super selectionChanged.
	self refreshCodePanel.
]
