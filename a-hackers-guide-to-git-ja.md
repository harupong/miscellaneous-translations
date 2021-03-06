[translation here]

<!--original
% A Hacker’s Guide to Git | Wildly Inaccurate
% 
% 
-->

[translation here]

<!--original
[Wildly Inaccurate](http://wildlyinaccurate.com/)
-->

[translation here]

<!--original
Web development, beer, and general geekiness
-->

[translation here]

<!--original
-   [Latest Posts](http://wildlyinaccurate.com/)
-   [Projects](http://wildlyinaccurate.com/projects)
-   [About](http://wildlyinaccurate.com/about)
-->

[translation here]

<!--original
A Hacker’s Guide to Git
=======================
-->

[translation here]

<!--original
[18 Comments](http://wildlyinaccurate.com/a-hackers-guide-to-git#comments "Comment on A Hacker’s Guide to Git")
-->

[translation here]

<!--original
*This post is a work in progress. Please feel free to [contact me](https://twitter.com/joseph_wynn "@Joseph_Wynn") with any corrections, requests or suggestions.*
-->

[translation here]

<!--original
Contents
-->

[translation here]

<!--original
-   [1 Introduction](#introduction)
-   [2 Repositories](#repositories)
-   [3 Tree Objects](#tree-objects)
-   [4 Commits](#commits)
-   [5 References](#references)
-   [6 Branches](#branches)
-   [7 Tags](#tags)
-   [8 Merging](#merging)
-   [9 Rebasing](#rebasing)
-   [10 Cherry-Picking](#cherry-picking)
-   [11 Rebasing (Continued)](#rebasing-continued)
-   [12 Remotes](#remotes)
-   [13 Pushing](#pushing)
-   [14 Fetching](#fetching)
-   [15 Pulling](#pulling)
-   [16 Toolkit](#toolkit)
    -   [16.1 git-reflog](#git-reflog)
    -   [16.2 git-fsck](#git-fsck)
    -   [16.3 git-stash](#git-stash)
    -   [16.4 git-describe](#git-describe)
    -   [16.5 git-rev-parse](#git-rev-parse)
    -   [16.6 git-bisect](#git-bisect)

-->

[translation here]

<!--original
Introduction
------------
-->

[translation here]

<!--original
Git is currently the most widely used version control system in the world, mostly thanks to GitHub. By that measure, I’d argue that it’s also the most misunderstood version control system in the world.
-->

[translation here]

<!--original
This statement probably doesn’t ring true straight away because on the surface, Git is pretty simple. It’s really easy to pick up if you’ve come from another VCS like Subversion or Mercurial. It’s even relatively easy to pick up if you’ve never used a VCS before. Everybody understands adding, committing, pushing and pulling; but this is about as far as Git’s simplicity goes. Past this point, Git is shrouded by fear, uncertainty and doubt.
-->

[translation here]

<!--original
Once you start talking about branching, merging, rebasing, multiple remotes, remote-tracking branches, detached HEAD states… Git becomes less of an easily-understood tool and more of a feared deity. Anybody who talks about no-fast-forward merges is regarded with quiet superstition, and even veteran hackers would rather stay away from rebasing “just to be safe”.
-->

[translation here]

<!--original
I think a big part of this is due to many people coming to Git from a conceptually simpler VCS — probably Subversion — and trying to apply their past knowledge to Git. It’s easy to understand why people want to do this. Take Subversion, for example. Subversion is simple, right? It’s just files and folders. Commits are numbered sequentially. Even branching and tagging is simple — it’s just like taking a backup of a folder.
-->

[translation here]

<!--original
Basically, Subversion fits in nicely with our existing computing paradigms. Everybody understands files and folders. Everybody knows that revision \#10 was the one after \#9 and before \#11. But these paradigms break down when you try to apply them to Git’s advanced features.
-->

[translation here]

<!--original
That’s why trying to understand Git in this way is wrong. Git doesn’t work like Subversion at all. Which is pretty confusing, right? You can add and remove files. You can commit your changes. You can generate diffs and patches which look just like Subversion’s. How can something which appears so similar really be so different?
-->

[translation here]

<!--original
Complex systems like Git become much easier to understand once you figure out how they really work. The goal of this post is to shed some light on how Git works under the hood. We’re going to take a look at some of Git’s core concepts including its basic object storage, how commits work, how branches and tags work, and we’ll look at the different kinds of merging in Git including the much-feared rebase. Hopefully at the end of it all, you’ll have a solid understanding of these concepts and will be able to use some of Git’s more advanced features with confidence.
-->

[translation here]

<!--original
It’s worth noting at this point that this guide is not intended to be a beginner’s introduction to Git. This guide was written for people who already use Git, but would like to better understand it by taking a peek under the hood, and learn a few neat tricks along the way. With that said, let’s begin.
-->

[translation here]

<!--original
Repositories
------------
-->

[translation here]

<!--original
At the core of Git, like other VCS, is the repository. A Git repository is really just a simple key-value data store. This is where Git stores, among other things:
-->

[translation here]

<!--original
-   **Blobs**, which are the most basic data type in Git. Essentially, a blob is just a bunch of bytes; usually a binary representation of a file.
-   **Tree objects**, which are a bit like directories. Tree objects can contain pointers to blobs and other tree objects.
-   **Commit objects**, which point to a single tree object, and contain some metadata including the commit author and any parent commits.
-   **Tag objects**, which point to a single commit object, and contain some metadata.
-   **References**, which are pointers to a single object (usually a commit or tag object).
-->

[translation here]

<!--original
You don’t need to worry about all of this just yet; we’ll cover these things in more detail later.
-->

[translation here]

<!--original
The important thing to remember about a Git repository is that it exists entirely in a single `.git` directory in your project root. There is no central repository like in Subversion or CVS. This is what allows Git to be a *distributed* version control system — everybody has their own self-contained version of a repository.
-->

[translation here]

<!--original
You can initialize a Git repository anywhere with the `git init` command. Take a look inside the `.git` folder to get a glimpse of what a repository looks like.
-->

[translation here]

<!--original
~~~~ {.no-highlight}
$ git init
Initialized empty Git repository in /home/demo/demo-repository/.git/
$ ls -l .git
total 32
drwxrwxr-x 2 demo demo 4096 May 24 20:10 branches
-rw-rw-r-- 1 demo demo 92 May 24 20:10 config
-rw-rw-r-- 1 demo demo 73 May 24 20:10 description
-rw-rw-r-- 1 demo demo 23 May 24 20:10 HEAD
drwxrwxr-x 2 demo demo 4096 May 24 20:10 hooks
drwxrwxr-x 2 demo demo 4096 May 24 20:10 info
drwxrwxr-x 4 demo demo 4096 May 24 20:10 objects
drwxrwxr-x 4 demo demo 4096 May 24 20:10 refs
~~~~
-->

[translation here]

<!--original
The important directories are `.git/objects`, where Git stores all of its objects; and `.git/refs`, where Git stores all of its references.
-->

[translation here]

<!--original
We’ll see how all of this fits together as we learn about the rest of Git. For now, let’s learn a little bit more about tree objects.
-->

[translation here]

<!--original
Tree Objects
------------
-->

[translation here]

<!--original
A tree object in Git can be thought of as a directory. It contains a list of blobs (files) and other tree objects (sub-directories).
-->

[translation here]

<!--original
Imagine we had a simple repository, with a `README` file and a `src/` directory containing a `hello.c` file.
-->

[translation here]

<!--original
~~~~ {.no-highlight}
README
src/
    hello.c
-->

[translation here]

<!--original
~~~~
-->

[translation here]

<!--original
This would be represented by two tree objects: one for the root directory, and another for the `src/` directory. Here’s what they would look like.
-->

[translation here]

<!--original
**tree 4da454..**
-->

[translation here]

<!--original
  ------ ---------- --------
  blob   976165..   README
  tree   81fc8b..   src
  ------ ---------- --------
-->

[translation here]

<!--original
**tree 81fc8b..**
-->

[translation here]

<!--original
  ------ ---------- ---------
  blob   1febef..   hello.c
  ------ ---------- ---------
-->

[translation here]

<!--original
If we draw the blobs (in green) as well as the tree objects (in blue), we end up with a diagram that looks a lot like our directory structure.
-->

[translation here]

<!--original
![Git tree graph](http://wildlyinaccurate.com/wp-content/uploads/2014/05/tree-graph.png)
-->

[translation here]

<!--original
Notice how given the root tree object, we can recurse through every tree object to figure out the state of the entire working tree. The root tree object, therefore, is essentially a snapshot of your repository at a given time. Usually when Git refers to “the tree”, it is referring to the root tree object.
-->

[translation here]

<!--original
Now let’s learn how you can track the history of your repository with commit objects.
-->

[translation here]

<!--original
Commits
-------
-->

[translation here]

<!--original
A commit object is essentially a pointer that contains a few pieces of important metadata. The commit itself has a hash, which is built from a combination of the metadata that it contains:
-->

[translation here]

<!--original
-   The hash of the tree (the root tree object) at the time of the commit. As we learned in *Tree Objects*, this means that with a single commit, Git can build the entire working tree by recursing into the tree.
-   The hash of any parent commits. This is what gives a repository its history: every commit has a parent commit, all the way back to the very first commit.
-   The author’s name and email address, and the time that the changes were authored.
-   The committer’s name and email address, and the time that the commit was made.
-   The commit message.
-->

[translation here]

<!--original
Let’s see a commit object in action by creating a simple repository.
-->

[translation here]

<!--original
~~~~ {.no-highlight}
 $ git init
Initialized empty Git repository in /home/demo/simple-repository/.git/
 $ echo 'This is the readme.' > README
 $ git add README
 $ git commit -m "First commit"
[master (root-commit) d409ca7] First commit
 1 file changed, 1 insertion(+)
 create mode 100644 README
~~~~
-->

[translation here]

<!--original
When you create a commit, Git will give you the hash of that commit. Using `git show` with the `--format=raw` flag, we can see this newly-created commit’s metadata.
-->

[translation here]

<!--original
~~~~ {.no-highlight}
$ git show --format=raw d409ca7
-->

[translation here]

<!--original
commit d409ca76bc919d9ca797f39ae724b7c65700fd27
tree 9d073fcdfaf07a39631ef94bcb3b8268bc2106b1
author Joseph Wynn <joseph@wildlyianccurate.com> 1400976134 -0400
committer Joseph Wynn <joseph@wildlyianccurate.com> 1400976134 -0400
-->

[translation here]

<!--original
    First commit

-->

[translation here]

<!--original
diff --git a/README b/README
new file mode 100644
index 0000000..9761654
--- /dev/null
+++ b/README
@@ -0,0 +1 @@
+This is the readme.
~~~~
-->

[translation here]

<!--original
Notice how although we referenced the commit by the partial hash `d409ca7`, Git was able to figure out that we actually meant `d409ca76bc919d9ca797f39ae724b7c65700fd27`. This is because the hashes that Git assigns to objects are unique enough to be identified by the first few characters. You can see here that Git is able to find this commit with as few as four characters; after which point Git will tell you that the reference is ambiguous.
-->

[translation here]

<!--original
~~~~ {.no-highlight}
$ git show d409c
$ git show d409
$ git show d40
fatal: ambiguous argument 'd40': unknown revision or path not in the working tree.
~~~~
-->

[translation here]

<!--original
References
----------
-->

[translation here]

<!--original
In previous sections, we saw how objects in Git are identified by a hash. Since we want to manipulate objects quite often in Git, it’s important to know their hashes. You could run all your Git commands referencing each object’s hash, like `git show d409ca7`, but that would require you to remember the hash of every object you want to manipulate.
-->

[translation here]

<!--original
To save you from having to memorize these hashes, Git has references, or “refs”. A reference is simply a file stored somewhere in `.git/refs`, containing the hash of a commit object.
-->

[translation here]

<!--original
To carry on the example from *Commits*, let’s figure out the hash of “First commit” using references only.
-->

[translation here]

<!--original
~~~~ {.no-highlight}
$ git status
On branch master
nothing to commit, working directory clean
~~~~
-->

[translation here]

<!--original
`git status` has told us that we are on branch `master`. As we will learn in a later section, branches are just references. We can see this by looking in `.git/refs/heads`.
-->

[translation here]

<!--original
~~~~ {.no-highlight}
$ ls -l .git/refs/heads/
total 4
-rw-rw-r-- 1 demo demo 41 May 24 20:02 master
~~~~
-->

[translation here]

<!--original
We can easily see which commit `master` points to by reading the file.
-->

[translation here]

<!--original
~~~~ {.no-highlight}
$ cat .git/refs/heads/master
d409ca76bc919d9ca797f39ae724b7c65700fd27
~~~~
-->

[translation here]

<!--original
Sure enough, `master` contains the hash of the “First commit” object.
-->

[translation here]

<!--original
Of course, it’s possible to simplify this process. Git can tell us which commit a reference is pointing to with the `show` and `rev-parse` commands.
-->

[translation here]

<!--original
~~~~ {.no-highlight}
$ git show --oneline master
d409ca7 First commit
$ git rev-parse master
d409ca76bc919d9ca797f39ae724b7c65700fd27
~~~~
-->

[translation here]

<!--original
Git also has a special reference, `HEAD`. This is a “symbolic” reference which points to the tip of the current branch rather than an actual commit. If we inspect `HEAD`, we see that it simply points to `refs/head/master`.
-->

[translation here]

<!--original
~~~~ {.no-highlight}
$ cat .git/HEAD
ref: refs/heads/master
~~~~
-->

[translation here]

<!--original
It is actually possible for `HEAD` to point directly to a commit object. When this happens, Git will tell you that you are in a “detached HEAD state”. We’ll talk a bit more about this later, but really all this means is that you’re not currently on a branch.
-->

[translation here]

<!--original
Branches
--------
-->

[translation here]

<!--original
Git’s branches are often touted as being one of its strongest features. This is because branches in Git are very lightweight, compared to other VCS where a branch is usually a clone of the entire repository.
-->

[translation here]

<!--original
The reason branches are so lightweight in Git is because they’re just references. We saw in *References* that the `master` branch was simply a file inside `.git/refs/heads`. Let’s create another branch to see what happens under the hood.
-->

[translation here]

<!--original
~~~~ {.no-highlight}
$ git branch test-branch
$ cat .git/refs/heads/test-branch 
d409ca76bc919d9ca797f39ae724b7c65700fd27
~~~~
-->

[translation here]

<!--original
It’s as simple as that. Git has created a new entry in `.git/refs/heads` and pointed it at the current commit.
-->

[translation here]

<!--original
We also saw in *References* that `HEAD` is Git’s reference to the current branch. Let’s see that in action by switching to our newly-created branch.
-->

[translation here]

<!--original
~~~~ {.no-highlight}
$ cat .git/HEAD
ref: refs/heads/master
$ git checkout test-branch 
Switched to branch 'test-branch'
$ cat .git/HEAD
ref: refs/heads/test-branch
~~~~
-->

[translation here]

<!--original
When you create a new commit, Git simply changes the current branch to point to the newly-created commit object.
-->

[translation here]

<!--original
~~~~ {.no-highlight}
$ echo 'Some more information here.' >> README
$ git add README
$ git commit -m "Update README in a new branch"
[test-branch 7604067] Update README in a new branch
 1 file changed, 1 insertion(+)
$ cat .git/refs/heads/test-branch 
76040677d717fd090e327681064ac6af9f0083fb
~~~~
-->

[translation here]

<!--original
Later on we’ll look at the difference between **local branches** and **remote-tracking branches**.
-->

[translation here]

<!--original
Tags
----
-->

[translation here]

<!--original
There are two types of tags in Git – **lightweight tags** and **annotated tags**.
-->

[translation here]

<!--original
On the surface, these two types of tags look very similar. Both of them are references stored in `.git/refs/tags`. However, that’s about as far as the similarities go. Let’s create a lightweight tag to see how they work.
-->

[translation here]

<!--original
~~~~ {.no-highlight}
$ git tag 1.0-lightweight
$ cat .git/refs/tags/1.0-lightweight 
d409ca76bc919d9ca797f39ae724b7c65700fd27
~~~~
-->

[translation here]

<!--original
We can see that Git has created a tag reference which points to the current commit. By default, `git tag` will create a lightweight tag. Note that this is **not a tag object**. We can verify this by using `git cat-file` to inspect the tag.
-->

[translation here]

<!--original
~~~~ {.no-highlight}
$ git cat-file -p 1.0-lightweight
tree 9d073fcdfaf07a39631ef94bcb3b8268bc2106b1
author Joseph Wynn <joseph@wildlyianccurate.com> 1400976134 -0400
committer Joseph Wynn <joseph@wildlyianccurate.com> 1400976134 -0400
-->

[translation here]

<!--original
First commit
$ git cat-file -p d409ca7
tree 9d073fcdfaf07a39631ef94bcb3b8268bc2106b1
author Joseph Wynn <joseph@wildlyianccurate.com> 1400976134 -0400
committer Joseph Wynn <joseph@wildlyianccurate.com> 1400976134 -0400
-->

[translation here]

<!--original
First commit
~~~~
-->

[translation here]

<!--original
You can see that as far as Git is concerned, the `1.0-lightweight` tag and the `d409ca7` commit are the *same object*. That’s because the lightweight tag is *only a reference* to the commit object.
-->

[translation here]

<!--original
Let’s compare this to an annotated tag.
-->

[translation here]

<!--original
~~~~ {.no-highlight}
$ git tag -a -m "Tagged 1.0" 1.0
$ cat .git/refs/tags/1.0
10589beae63c6e111e99a0cd631c28479e2d11bf
~~~~
-->

[translation here]

<!--original
We’ve passed the `-a` (`--annotate`) flag to `git tag` to create an annotated tag. Notice how Git creates a reference for the tag just like the lightweight tag, but this reference is not pointing to the same object as the lightweight tag. Let’s use `git cat-file` again to inspect the object.
-->

[translation here]

<!--original
~~~~ {.no-highlight}
$ git cat-file -p 1.0
object d409ca76bc919d9ca797f39ae724b7c65700fd27
type commit
tag 1.0
tagger Joseph Wynn <joseph@wildlyianccurate.com> 1401029229 -0400
-->

[translation here]

<!--original
Tagged 1.0
~~~~
-->

[translation here]

<!--original
This is a **tag object**, separate to the commit that it points to. As well as containing a pointer to a commit, tag objects also store a tag message and information about the tagger. Tag objects can also be signed with a [GPG key](http://en.wikipedia.org/wiki/GNU_Privacy_Guard "GNU Privacy Guard") to prevent commit or email spoofing.
-->

[translation here]

<!--original
Aside from being GPG-signable, there are a few reasons why annotated tags are preferred over lightweight tags.
-->

[translation here]

<!--original
Probably the most important reason is that annotated tags have their own author information. This can be helpful when you want to know who created the tag, rather than who created the commit that the tag is referring to.
-->

[translation here]

<!--original
Annotated tags are also timestamped. Since new versions are usually tagged right before they are released, an annotated tag can tell you when a version was released rather than just when the final commit was made.
-->

[translation here]

<!--original
Merging
-------
-->

[translation here]

<!--original
Merging in Git is the process of joining two histories (usually branches) together. Let’s start with a simple example. Say you’ve created a new feature branch from `master`, and done some work on it.
-->

[translation here]

<!--original
~~~~ {.no-highlight}
$ git checkout -b feature-branch
Switched to a new branch 'feature-branch'
$ vim feature.html
$ git commit -am "Finished the new feature"
[feature-branch 0c21359] Finished the new feature
 1 file changed, 1 insertion(+)
~~~~
-->

[translation here]

<!--original
At the same time, you need to fix an urgent bug. So you create a `hotfix` branch from `master`, and do some work in there.
-->

[translation here]

<!--original
~~~~ {.no-highlight}
$ git checkout master
Switched to branch 'master'
$ git checkout -b hotfix
Switched to a new branch 'hotfix'
$ vim index.html
$ git commit -am "Fixed some wording"
[hotfix 40837f1] Fixed some wording
 1 file changed, 1 insertion(+), 1 deletion(-)
~~~~
-->

[translation here]

<!--original
At this point, the history will look something like this.
-->

[translation here]

<!--original
![Branching -- hotfix and feature branch](http://wildlyinaccurate.com/wp-content/uploads/2014/05/branch-feature-hotfix.png)
-->

[translation here]

<!--original
Now you want to bring the bug fix into `master` so that you can tag it and release it.
-->

[translation here]

<!--original
~~~~ {.no-highlight}
$ git checkout master
Switched to branch 'master'
$ git merge hotfix
Updating d939a3a..40837f1
Fast-forward
 index.html | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
~~~~
-->

[translation here]

<!--original
Notice how Git mentions **fast-forward** during the merge. What this means is that all of the commits in `hotfix` were directly upstream from `master`. This allows Git to simply move the `master` pointer up the tree to `hotfix`. What you end up with looks like this.
-->

[translation here]

<!--original
![Branching -- after merging hotfix](http://wildlyinaccurate.com/wp-content/uploads/2014/05/branch-merge-hotfix.png)
-->

[translation here]

<!--original
Now let’s try and merge `feature-branch` into `master`.
-->

[translation here]

<!--original
~~~~ {.no-highlight}
$ git merge feature-branch 
Merge made by the 'recursive' strategy.
 feature.html | 1 +
 1 file changed, 1 insertion(+)
~~~~
-->

[translation here]

<!--original
This time, Git wasn’t able to perform a fast-forward. This is because `feature-branch` isn’t directly upstream from `master`. This is clear on the graph above, where `master` is at commit **D** which is in a different history tree to `feature-branch` at commit **C**.
-->

[translation here]

<!--original
So how did Git handle this merge? Taking a look at the log, we see that Git has actually created a new “merge” commit, as well as bringing the commit from `feature-branch`.
-->

[translation here]

<!--original
~~~~ {.no-highlight}
$ git log --oneline
8ad0923 Merge branch 'feature-branch'
0c21359 Finished the new feature
40837f1 Fixed some wording
d939a3a Initial commit
~~~~
-->

[translation here]

<!--original
Upon closer inspection, we can see that this is a special kind of commit object — it has **two parent commits**. This is referred to as a **merge commit**.
-->

[translation here]

<!--original
~~~~ {.no-highlight}
$ git show --format=raw 8ad0923
-->

[translation here]

<!--original
commit 8ad09238b0dff99e8a99c84d68161ebeebbfc714
tree e5ee97c8f9a4173f07aa4c46cb7f26b7a9ff7a17
parent 40837f14b8122ac6b37c0919743b1fd429b3bbab
parent 0c21359730915c7888c6144aa8e9063345330f1f
author Joseph Wynn <joseph@wildlyinaccurate.com> 1401134489 +0100
committer Joseph Wynn <joseph@wildlyinaccurate.com> 1401134489 +0100
-->

[translation here]

<!--original
 Merge branch 'feature-branch'
~~~~
-->

[translation here]

<!--original
This means that our history graph now looks something like this (commit **E** is the new merge commit).
-->

[translation here]

<!--original
![Branching -- after merging feature-branch](http://wildlyinaccurate.com/wp-content/uploads/2014/05/branch-merge-feature.png)
-->

[translation here]

<!--original
Some people believe that this sort of history graph is undesirable. In the *Rebasing (Continued)* section, we’ll learn how to prevent non-fast-forward merges by rebasing feature branches before merging them with `master`.
-->

[translation here]

<!--original
Rebasing
--------
-->

[translation here]

<!--original
Rebasing is without a doubt one of Git’s most misunderstood features. For most people, `git rebase` is a command that should be avoided at all costs. This is probably due to the extraordinary amount of scaremongering around rebasing. *“Rebase Considered Harmful”*, and *“Please, stay away from rebase” *are just two of the many anti-rebase articles you will find in the vast archives of the Internet.
-->

[translation here]

<!--original
But rebase isn’t scary, or dangerous, so long as you understand what it does. But before we get into rebasing, I’m going to take a quick digression, because it’s actually much easier to explain rebasing in the context of cherry-picking.
-->

[translation here]

<!--original
Cherry-Picking
--------------
-->

[translation here]

<!--original
What git cherry-pick does is take one or more commits, and replay them on top of the current commit. Imagine a repository with the following history graph.
-->

[translation here]

<!--original
![Node graph -- before cherry-pick](http://wildlyinaccurate.com/wp-content/uploads/2014/05/cherry-pick-before.png)
-->

[translation here]

<!--original
If you are on commit **D** and you run `git cherry-pick F`, Git will take the changes that were introduced in commit **F** and replay them *as a new commit* (shown as **F’**) on top of commit **D.**
-->

[translation here]

<!--original
![Node graph -- after cherry-pick](http://wildlyinaccurate.com/wp-content/uploads/2014/05/cherry-pick-after.png)
-->

[translation here]

<!--original
The reason you end up with a *copy* of commit **F** rather than commit **F** itself is due to the way commits are constructed. Recall that the parent commit is part of a commit’s hash. So despite containing the exact same changes, author information and timestamp; **F’** will have a different parent to **F**, giving it a different hash.
-->

[translation here]

<!--original
A common workflow in Git is to develop features on small branches, and merge the features one at a time into the master branch. Let’s recreate this scenario by adding some branch labels to the graphs.
-->

[translation here]

<!--original
![Node graph -- with branch labels](http://wildlyinaccurate.com/wp-content/uploads/2014/05/graph-branch-labels.png)
-->

[translation here]

<!--original
As you can see, `master` has been updated since `foo` was created. To avoid potential conflicts when `foo` is merged with `master`, we want bring `master`‘s changes into `foo`. Because `master` is the *base* branch, we want to play `foo`‘s commits *on top* of `master`. Essentially, we want to change commit **C**‘s parent from **B** to **F**.
-->

[translation here]

<!--original
It’s not going to be easy, but we can achieve this with `git cherry-pick`. First, we need to create a temporary branch at commit **F**.
-->

[translation here]

<!--original
~~~~ {.no-highlight}
$ git checkout master
$ git checkout -b foo-tmp
~~~~
-->

[translation here]

<!--original
![Node graph -- after creating foo-tmp](http://wildlyinaccurate.com/wp-content/uploads/2014/05/foo-tmp.png)
-->

[translation here]

<!--original
Now that we have a base on commit **F**, we can `cherry-pick` all of `foo`‘s commits on top if it.
-->

[translation here]

<!--original
~~~~ {.no-highlight}
$ git cherry-pick C D
~~~~
-->

[translation here]

<!--original
![Node graph -- after cherry-picking C and D](http://wildlyinaccurate.com/wp-content/uploads/2014/05/cherry-pick-c-d.png)
-->

[translation here]

<!--original
Now all that’s left to do is point `foo` at commit **D’**, and delete the temporary branch `foo-tmp`. We do this with the `reset` command, which points `HEAD` (and therefore the current branch) at a specified commit. The `--hard` flag ensures our working tree is updated as well.
-->

[translation here]

<!--original
~~~~ {.no-highlight}
$ git checkout foo
$ git reset --hard foo-tmp
$ git branch -D foo-tmp
~~~~
-->

[translation here]

<!--original
This gives the desired result of `foo`‘s commits being upstream of `master`. Note that the original **C** and **D** commits are no longer reachable because no branch points to them.
-->

[translation here]

<!--original
![Node graph -- after resetting foo](http://wildlyinaccurate.com/wp-content/uploads/2014/05/cherry-pick-final.png)
-->

[translation here]

<!--original
Rebasing (Continued)
--------------------
-->

[translation here]

<!--original
While the example in *Cherry-Picking* worked, it’s not practical. In Git, rebasing allows us to replace our verbose cherry-pick workflow…
-->

[translation here]

<!--original
~~~~ {.no-highlight}
$ git checkout master
$ git checkout -b foo-tmp
$ git cherry-pick C D
$ git checkout foo
$ git reset --hard foo-bar
$ git branch -D foo-bar
~~~~
-->

[translation here]

<!--original
…With a single command.
-->

[translation here]

<!--original
~~~~ {.no-highlight}
$ git rebase master foo
~~~~
-->

[translation here]

<!--original
With the format `git rebase <base> <target>`, the `rebase` command will take all of the commits from `<target>` and play them on top of `<base>` one by one. It does this without actually modifying `<base>`, so the end result is a linear history in which `<base>` can be fast-forwarded to `<target>`.
-->

[translation here]

<!--original
In a sense, performing a rebase is like telling Git, **“Hey, I want to pretend that `<target>` was actually branched from `<base>`. Take all of the commits from `<target>`, and pretend that they happened *after* `<base>`“**.
-->

[translation here]

<!--original
Let’s take a look again at the example graph from *Merging* to see how rebasing can prevent us from having to do a non-fast-forward merge.
-->

[translation here]

<!--original
![Branching -- after merging hotfix](http://wildlyinaccurate.com/wp-content/uploads/2014/05/branch-merge-hotfix.png)
-->

[translation here]

<!--original
All we have to do to enable a fast-forward merge of `feature-branch` into `master` is run `git rebase master feature-branch` before performing the merge.
-->

[translation here]

<!--original
~~~~ {.no-highlight}
$ git rebase master feature-branch
First, rewinding head to replay your work on top of it...
Applying: Finished the new feature
~~~~
-->

[translation here]

<!--original
This has brought `feature-branch` directly upstream of `master`.
-->

[translation here]

<!--original
![Rebasing -- rebase feature-branch with master](http://wildlyinaccurate.com/wp-content/uploads/2014/05/rebase-feature.png)
-->

[translation here]

<!--original
Now all that’s left to do is let Git perform the merge.
-->

[translation here]

<!--original
~~~~ {.no-highlight}
$ git checkout master
$ git merge feature-branch
Updating 40837f1..2a534dd
Fast-forward
 feature.html | 1 +
 1 file changed, 1 insertion(+)
~~~~
-->

[translation here]

<!--original
Remotes
-------
-->

[translation here]

<!--original
// TODO
-->

[translation here]

<!--original
Pushing
-------
-->

[translation here]

<!--original
// TODO
-->

[translation here]

<!--original
Fetching
--------
-->

[translation here]

<!--original
// TODO
-->

[translation here]

<!--original
Pulling
-------
-->

[translation here]

<!--original
// TODO
-->

[translation here]

<!--original
Toolkit
-------
-->

[translation here]

<!--original
With a solid understanding of Git’s inner workings, some of the more advanced Git tools start to make more sense.
-->

[translation here]

<!--original
### git-reflog
-->

[translation here]

<!--original
Whenever you make a change in Git that affects the tip of a branch, Git records information about that change in what’s called the reflog. Usually you shouldn’t need to look at these logs, but sometimes they can come in *very* handy.
-->

[translation here]

<!--original
Let’s say you have a repository with a few commits.
-->

[translation here]

<!--original
~~~~ {.no-highlight}
$ git log --oneline
d6f2a84 Add empty LICENSE file
51c4b49 Add some actual content to readme
3413f46 Add TODO note to readme
322c826 Add empty readme
~~~~
-->

[translation here]

<!--original
You decide, for some reason, to perform a destructive action on your `master` branch.
-->

[translation here]

<!--original
~~~~ {.no-highlight}
$ git reset --hard 3413f46
HEAD is now at 3413f46 Add TODO note to readme
~~~~
-->

[translation here]

<!--original
Since performing this action, you’ve realised that you lost some commits and you have no idea what their hashes were. You never pushed the changes; they were only in your local repository. `git log` is no help, since the commits are no longer reachable from `HEAD`.
-->

[translation here]

<!--original
~~~~ {.no-highlight}
$ git log --oneline
3413f46 Add TODO note to readme
322c826 Add empty readme
~~~~
-->

[translation here]

<!--original
This is where `git reflog` can be useful.
-->

[translation here]

<!--original
~~~~ {.no-highglight}
$ git reflog
3413f46 HEAD@{0}: reset: moving to 3413f46
d6f2a84 HEAD@{1}: commit: Add empty LICENSE file
51c4b49 HEAD@{2}: commit: Add some actual content to readme
3413f46 HEAD@{3}: commit: Add TODO note to readme
322c826 HEAD@{4}: commit (initial): Add empty readme
~~~~
-->

[translation here]

<!--original
The reflog shows a list of all changes to `HEAD` in reverse chronological order. The hash in the first column is the value of `HEAD` *after the change was made*. We can see, therefore, that we were at commit `d6f2a84` before the destructive change.
-->

[translation here]

<!--original
How you want to recover commits depends on the situation. In this particular example, we can simply do a `git reset --hard d6f2a84` to restore `HEAD` to its original position. However if we have introduced new commits since the destructive change, we may need to do something like `cherry-pick` all the commits that were lost.
-->

[translation here]

<!--original
Note that Git’s reflog is only a record of changes **for your local repository. If your local repository becomes corrupt or is deleted, the reflog won’t be of any use (if the repository is deleted the reflog won’t exist at all!)**
-->

[translation here]

<!--original
Depending on the situation, you may find `git fsck` more suitable for recovering lost commits.
-->

[translation here]

<!--original
### git-fsck
-->

[translation here]

<!--original
In a way, Git’s object storage works like a primitive file system — objects are like files on a hard drive, and their hashes are the objects’ physical address on the disk. The Git index is exactly like the index of a file system, in that it contains references which point at an object’s physical location.
-->

[translation here]

<!--original
By this analogy, `git fsck` is aptly named after `fsck` (“file system check”). This tool is able to check Git’s database and verify the validity and reachability of every object that it finds.
-->

[translation here]

<!--original
When a reference (like a branch) is deleted from Git’s index, the object(s) they refer to usually aren’t deleted, even if they are no longer reachable by any other references. Using a simple example, we can see this in practice.
-->

[translation here]

<!--original
~~~~ {.no-highlight}
$ git checkout -b foobar
Switched to a new branch 'foobar'
$ echo 'foobar' > foo.txt 
$* git commit -am "Update foo.txt with foobar"
[foobar bcbaac7] Update foo.txt with foobar
 1 file changed, 1 insertion(+), 1 deletion(-)
$ git checkout master
Switched to branch 'master'
$ git branch -D foobar
Deleted branch foobar (was bcbaac7).
~~~~
-->

[translation here]

<!--original
At this point, commit `bcbaac7` still exists in our repository, but there are no references pointing to it. By search through the database, `git fsck` is able to find it.
-->

[translation here]

<!--original
~~~~ {.no-highlight}
$ git fsck --lost-found
Checking object directories: 100% (256/256), done.
dangling commit bcbaac709e0b8abbd3f1f322990d204907be5841
~~~~
-->

[translation here]

<!--original
For simple cases, `git reflog` may be preferred. Where `git fsck` excels over `git reflog`, though, is when you need to find objects which you never referenced in your local repository (and therefore would not be in your reflog). An example of this is when you delete a remote branch through an interface like GitHub. Assuming the objects haven’t been garbage-collected, you can clone the remote repository and use `git fsck` to recover the deleted branch.
-->

[translation here]

<!--original
### git-stash
-->

[translation here]

<!--original
// TODO
-->

[translation here]

<!--original
### git-describe
-->

[translation here]

<!--original
Git’s `describe` command is summed up pretty neatly in the documentation:
-->

[translation here]

<!--original
> git-describe – Show the most recent tag that is reachable from a commit
-->

[translation here]

<!--original
This can be helpful for things like build and release scripts, as well as figuring out which version a change was introduced in.
-->

[translation here]

<!--original
`git describe` will take any reference or commit hash, and return the name of the most recent tag. If the tag points at the commit you gave it, `git describe` will return only the tag name. Otherwise, it will suffix the tag name with some information including the number of commits since the tag and an abbreviation of the commit hash.
-->

[translation here]

<!--original
~~~~ {.no-highlight}
$ git describe v1.2.15
v1.2.15
$ git describe 2db66f
v1.2.15-80-g2db66f5
~~~~
-->

[translation here]

<!--original
If you want to ensure that only the tag name is returned, you can force Git to remove the suffix by passing `--abbrev=0`.
-->

[translation here]

<!--original
~~~~ {.no-highlight}
$ git describe --abbrev=0 2db66f
v1.2.15
~~~~
-->

[translation here]

<!--original
### git-rev-parse
-->

[translation here]

<!--original
`git rev-parse` is an ancillary plumbing command which takes a wide range of inputs and returns one or more commit hashes. The most common use case is figuring out which commit a tag or branch points to.
-->

[translation here]

<!--original
~~~~ {.no-highlight}
$ git rev-parse v1.2.15        
2a46f5e2fbe83ccb47a1cd42b81f815f2f36ee9d
$ git rev-parse --short v1.2.15        
2a46f5e
~~~~
-->

[translation here]

<!--original
### git-bisect
-->

[translation here]

<!--original
`git bisect` is an indispensable tool when you need to figure out which commit introduced a breaking change. The `bisect` command does a binary search through your commit history to help you find the breaking change as quickly as possible. To get started simply run `git bisect start`. Then you need to `bisect` a couple of important hints: you can tell Git that the commit you’re currently on is broken with `git bisect bad`. Then, you can give Git a commit that you know is working with `git bisect good <commit>`.
-->

[translation here]

<!--original
~~~~ {.no-highlight}
$ git bisect start
$ git bisect bad
$ git bisect good v1.2.15
Bisecting: 41 revisions left to test after this (roughly 5 steps)
[b87713687ecaa7a873eeb3b83952ebf95afdd853] docs(misc/index): add header; general links
~~~~
-->

[translation here]

<!--original
Git will checkout a commit and ask you to test whether it’s broken or not. If the commit is broken, run `git bisect bad`, otherwise if it’s fine, run `git bisect good`. After a few goes of this, Git will be able to pinpoint at which commit the breaking change was first introduced.
-->

[translation here]

<!--original
~~~~ {.no-highlight}
$ git bisect bad
e145a8df72f309d5fb80eaa6469a6148b532c821 is the first bad commit
~~~~
-->

[translation here]

<!--original
Once the `bisect` is finished (or when you want to abort it), be sure to run `git bisect reset` to reset `HEAD` to where it was before the `bisect`.
-->

[translation here]

<!--original
Posted in [Git](http://wildlyinaccurate.com/category/git "View all posts in Git") and tagged [blob](http://wildlyinaccurate.com/tag/blob), [commit](http://wildlyinaccurate.com/tag/commit), [git](http://wildlyinaccurate.com/tag/git-2), [merge](http://wildlyinaccurate.com/tag/merge), [rebase](http://wildlyinaccurate.com/tag/rebase), [tag](http://wildlyinaccurate.com/tag/tag), [tree](http://wildlyinaccurate.com/tag/tree) on 25 May 2014 by Joseph.
-->

[translation here]

<!--original
« [Defining readable code](http://wildlyinaccurate.com/what-makes-code-readable)
-->

[translation here]

<!--original
-   progrock
-->

[translation here]

<!--original
    Helpful article and high quality comments. The best mix.

-->

[translation here]

<!--original
-   Victor Espíritu
-->

[translation here]

<!--original
    Excelente guia …..!

-->

[translation here]

<!--original
-   http://www.shakedos.com/ Shaked Klein Orbach
-->

[translation here]

<!--original
    Is it possible to suscribe somewhere so I will be able to get an update once you finish the article? Great writing.

-->

[translation here]

<!--original
-   Ruben Vereecken
-->

[translation here]

<!--original
    I really like the page so far, I hope you manage to finish it!\
     If you’re planning on adding to your ‘rebase’ section, like another comment suggested, might I request a bit on interactive git rebase and, related, commit squashing? I found reading up on those to be really helpful in practice.

-->

[translation here]

<!--original
-   trans
-->

[translation here]

<!--original
    I love Git because of GitHub, but beyond that I am not so taken. It’s not that there is something technically wrong with git, rather, it is technically very right, but it is in the wrong place. When you said “Subversion fits in nicely with our existing computing paradigms. Everybody understands files and folders.” That pretty much hits the nail on the head. Git has essentially built a file system on top of a file system. This limits access to ones files via the git gate keeper, so to speak, and a disconnect between the actual file system and the vcs (e.g. \`rm foo\` vs \`git rm foo\`). I am convinced the next generation of version control system will be the one that integrates the concepts of versioning, a la git, into the file system itself, allowing us to work once again in the conceptual paradigm of files and folders, but with all the benefits of version control, a la svn.

-->

[translation here]

<!--original
-   behemoth
-->

[translation here]

<!--original
    great job bro :)

-->

[translation here]

<!--original
-   gondoSVK
-->

[translation here]

<!--original
    would be helpful to mention how to deal with conflicts during merge and rebase

-->

[translation here]

<!--original
-   http://shime.github.com/ Hrvoje Šimi?
-->

[translation here]

<!--original
    Couldn’t a problem in a cherry picking example be solved in a simpler way? Maybe I’m crazy, but I usually just merge master into the feature branch.

    -   Sam Wyman

        I think the point is that it’s a simple, contrived example. Especially since that section is used as an introduction to the rebase section.

-->

[translation here]

<!--original
-   Kim Silkebækken
-->

[translation here]

<!--original
    Also, don’t forget to check out the man pages if you want to be a true git pro: [http://git-man-page-generator.lokaltog.net/](http://git-man-page-generator.lokaltog.net/)

-->

[translation here]

<!--original
-   http://madhur.github.com Madhur
-->

[translation here]

<!--original
    The article is good. But I feel there are some missing pieces:

    \$ git reset –hard foo-bar\
     \$ git branch -D foo-bar\
     What is “foo-bar” here? There is no mention of it in the text.

    Can you elaborate on difference between rebase and merge? In which scenarios you prefer one over another.

    -   wildlyinaccurate

        Thank you, that was supposed to be foo-tmp — I’ve fixed that.

        I’d certainly like to expand on merge & rebase; I’ll be adding more on that this week. For now though, my rule of thumb is that rebase is for bringing feature branches up-to-date with master. Merge is for bringing feature branches into master. There are other situations, of course, like wanting to bring a feature branch up-to-date with another feature branch. Usually in this case I’d rebase, but this really depends on the situation. Like I said, hopefully I’ll be able to expand on this in the guide later.

    -   tunesmith

        I tend to prefer merge over rebase when it is important to me to accurately track the dates of when changes were actually first committed. Like, when it’s important to see from the revision history that I implemented Feature X between 2 and 4pm on Tuesday afternoon.

        I tend to prefer rebase over merge when timeline isn’t so important, and when I instead want to optimize for gathering chunks of commits together into one conceptual whole. Like, if I have worked on a new feature privately over a two-week period, during a time when bunches of other commits have been pushed to origin. If I want to push my feature to origin and have its commits bundled together as a cohesive whole (for easier review), then rebase is better than merge.

        So it depends on whether you want to optimize for accurate history (merge), or clarity of conceptual change (rebase).

        -   mcagl

            Well, man git-rebase mentions this option:

            –committer-date-is-author-date, –ignore-date\
             These flags are passed to git am to easily change the dates of the rebased commits (see git-am(1)). Incompatible with the –interactive option.

            which is what you want to do when you choose merging instead of rebasing, if I understood correctly.

-->

[translation here]

<!--original
-   Keshav Kini
-->

[translation here]

<!--original
    \>The reason you end up with a copy of commit F rather than commit F itself is due to the way commits are constructed. Recall that the parent commit is part of a commit’s hash. So despite containing the exact same changes, author information and timestamp; F’ will have a different parent to F, giving it a different hash.

    This is very misleading. Commits do not contain “changes”, they contain full snapshots of the codebase (or whatever files you’re tracking). F’ is not a copy of F in any way. F’ is a commit that is formed by taking the diff from E to F and applying that diff to D, just like 105 is a number formed by taking the difference between 7 and 12 and adding it to 100. 105 is not a “copy of 12″, and neither is F’ a copy of F.

    Furthermore, since commits contain snapshots and not diffs, the hash of F’ would be completely different from the hash of F even if their parent fields were identical, because they would contain completely different tree objects created from completely different blob objects. To imply that the reason their hashes are different is merely that they have different parents is, well, wildly inaccurate.

    -   wildlyinaccurate

        Thanks for the feedback; I guess the wording could be clearer. While a commit doesn’t actually contain a diff, when Git performs a cherry-pick it calculates the diff for that commit and re-applies it at HEAD. So (and bare with me here), given A \<– B \<– C, if you did \`git reset –hard B\`, reset the computer's clock to be the same time that C was committed, and then ran \`git cherry-pick C\`… C \*should\* have the exact same hash that it did before. At least that's my understanding of it — please correct me if I'm wrong!

        -   Keshav Kini

            C will have the exact same hash that it did before, of course – no object’s hash ever changes in the git data store. Also, and I guess this is what you meant to say, \`git cherry-pick\` will have “created” a commit with the same hash as C, and moved the current branch pointer to that commit. In practice this means that the current branch pointer will just move back to C.

            The “reset the computer’s clock to be the same time that C was committed” step can be avoided either by setting the GIT\_COMMITTER\_DATE environment variable to the date seen in the “committer” line of the output of \`git cat-file -p C\`, or by invoking \`git cherry-pick\` with the \`–ff\` flag. The only reason this step is even necessary is that the standard headers of a git commit object contain both an authoring date and a committing date. History surgery operations like cherry-pick, rebase, etc. tend to preserve the author date but update the committer date to the present moment, thus changing the hash.

            Note that this has nothing to do with the normal usage of \`git cherry-pick\`, which is to cherry pick a commit from one branch onto another one, not onto the commit’s own parent. My main point was that it’s wrong to say in general that C’ is a copy of C or to imply that the only thing distinguishing C’ from C is a few differences in the commit headers. That’s a fundamental conceptual error.

-->

[translation here]

<!--original
-   http://www.scriptcrafty.com/ david karapetyan
-->

[translation here]

<!--original
    Well done. Looking forward to the section on remotes.

-->

<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script>
$(function() {
  $("*").contents().filter(function() {
    return this.nodeType==8 && this.nodeValue.match(/^original/);
  }).each(function(i, e) {
    var tooltips = e.nodeValue.replace(/^original *[\n\r]|[\n\r]$/g, '');
    $(this).prev().attr('title', tooltips);
  });
});
</script>
