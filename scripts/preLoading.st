"Shutdown Libgit"
LGitLibrary shutDown: true.

"Unregister all iceberg repository adapters since we are going to unload all code related to it.
Otherwise obsolete instances will stay".
IceMetacelloRepositoryAdapter allInstances do: #unregister.
Smalltalk globals at: #IceSystemEventListener ifPresent: #unregisterSystemAnnouncements.

"Remove iceberg from system (so I can reload it)"
MetacelloPharoPlatform select.

RPackageOrganizer default packages
    select: [ :each | each name beginsWith: 'Iceberg' ]
    thenDo: [ :each |
        ('Removing ', each name) traceCr.
        each removeFromSystem ].
