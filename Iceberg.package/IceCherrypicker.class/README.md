I know how to cherry-pick changes from a source IceDiff into a target IceDiff. 

* The source diff is an "initial change set" (ICS) with changes we want to initially selected.
* The target diff is an "estimated transitive change set" (ETCS) is the universe of changes, some of them will be pruned if they are not required by the changes in the ICS.
