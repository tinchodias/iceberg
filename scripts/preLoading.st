"Shutdown Libgit"
LGitLibrary shutDown: true.

"Unregister all iceberg repository adapters since we are going to unload all code related to it.
Otherwise obsolete instances will stay".
IceMetacelloRepositoryAdapter allInstances do: #unregister.
Smalltalk globals at: #IceSystemEventListener ifPresent: #unregisterSystemAnnouncements.

"Remove iceberg from system (so I can reload it)"
MetacelloPharoPlatform select.

(RPackageOrganizer default packages
    sorted: [ :a :b | a name > b name ])
    select: [ :each | each name matchesRegex: 'Iceberg.*|LibGit.*' ]
    thenDo: [ :each |
        ('Removing ', each name) traceCr.
        each removeFromSystem ].
