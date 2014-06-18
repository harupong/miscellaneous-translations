% A Hacker’s Guide to Git | Wildly Inaccurate
% 
% 

[Wildly Inaccurate](http://wildlyinaccurate.com/)

Web development, beer, and general geekiness

-   [Latest Posts](http://wildlyinaccurate.com/)
-   [Projects](http://wildlyinaccurate.com/projects)
-   [About](http://wildlyinaccurate.com/about)

A Hacker’s Guide to Git
=======================

[38 Comments](http://wildlyinaccurate.com/a-hackers-guide-to-git#comments "Comment on A Hacker’s Guide to Git")

*This post is a work in progress. Please feel free to [contact me](https://twitter.com/joseph_wynn "@Joseph_Wynn") with any corrections, requests or suggestions.*

Contents

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
    -   [12.1 Cloning](#cloning)
    -   [12.2 Pushing](#pushing)
    -   [12.3 Remote-Tracking Branches](#remote-tracking-branches)
    -   [12.4 Fetching](#fetching)
    -   [12.5 Pulling](#pulling)

-   [13 Toolkit](#toolkit)
    -   [13.1 git-reflog](#git-reflog)
    -   [13.2 git-fsck](#git-fsck)
    -   [13.3 git-stash](#git-stash)
    -   [13.4 git-describe](#git-describe)
    -   [13.5 git-rev-parse](#git-rev-parse)
    -   [13.6 git-bisect](#git-bisect)

Introduction
------------

Git is currently the most widely used version control system in the world, mostly thanks to GitHub. By that measure, I’d argue that it’s also the most misunderstood version control system in the world.

This statement probably doesn’t ring true straight away because on the surface, Git is pretty simple. It’s really easy to pick up if you’ve come from another VCS like Subversion or Mercurial. It’s even relatively easy to pick up if you’ve never used a VCS before. Everybody understands adding, committing, pushing and pulling; but this is about as far as Git’s simplicity goes. Past this point, Git is shrouded by fear, uncertainty and doubt.

Once you start talking about branching, merging, rebasing, multiple remotes, remote-tracking branches, detached HEAD states… Git becomes less of an easily-understood tool and more of a feared deity. Anybody who talks about no-fast-forward merges is regarded with quiet superstition, and even veteran hackers would rather stay away from rebasing “just to be safe”.

I think a big part of this is due to many people coming to Git from a conceptually simpler VCS — probably Subversion — and trying to apply their past knowledge to Git. It’s easy to understand why people want to do this. Subversion is simple, right? It’s just files and folders. Commits are numbered sequentially. Even branching and tagging is simple — it’s just like taking a backup of a folder.

Basically, Subversion fits in nicely with our existing computing paradigms. Everybody understands files and folders. Everybody knows that revision \#10 was the one after \#9 and before \#11. But these paradigms break down when you try to apply them to Git’s advanced features.

That’s why trying to understand Git in this way is wrong. Git doesn’t work like Subversion at all. Which is pretty confusing, right? You can add and remove files. You can commit your changes. You can generate diffs and patches which look just like Subversion’s. How can something which appears so similar really be so different?

Complex systems like Git become much easier to understand once you figure out how they really work. The goal of this guide is to shed some light on how Git works under the hood. We’re going to take a look at some of Git’s core concepts including its basic object storage, how commits work, how branches and tags work, and we’ll look at the different kinds of merging in Git including the much-feared rebase. Hopefully at the end of it all, you’ll have a solid understanding of these concepts and will be able to use some of Git’s more advanced features with confidence.

It’s worth noting at this point that this guide is not intended to be a beginner’s introduction to Git. This guide was written for people who already use Git, but would like to better understand it by taking a peek under the hood, and learn a few neat tricks along the way. With that said, let’s begin.

Repositories
------------

At the core of Git, like other VCS, is the repository. A Git repository is really just a simple key-value data store. This is where Git stores, among other things:

-   **Blobs**, which are the most basic data type in Git. Essentially, a blob is just a bunch of bytes; usually a binary representation of a file.
-   **Tree objects**, which are a bit like directories. Tree objects can contain pointers to blobs and other tree objects.
-   **Commit objects**, which point to a single tree object, and contain some metadata including the commit author and any parent commits.
-   **Tag objects**, which point to a single commit object, and contain some metadata.
-   **References**, which are pointers to a single object (usually a commit or tag object).

You don’t need to worry about all of this just yet; we’ll cover these things in more detail later.

The important thing to remember about a Git repository is that it exists entirely in a single `.git` directory in your project root. There is no central repository like in Subversion or CVS. This is what allows Git to be a *distributed* version control system — everybody has their own self-contained version of a repository.

You can initialize a Git repository anywhere with the `git init` command. Take a look inside the `.git` folder to get a glimpse of what a repository looks like.

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

The important directories are `.git/objects`, where Git stores all of its objects; and `.git/refs`, where Git stores all of its references.

We’ll see how all of this fits together as we learn about the rest of Git. For now, let’s learn a little bit more about tree objects.

Tree Objects
------------

A tree object in Git can be thought of as a directory. It contains a list of blobs (files) and other tree objects (sub-directories).

Imagine we had a simple repository, with a `README` file and a `src/` directory containing a `hello.c` file.

~~~~ {.no-highlight}
README
src/
    hello.c
~~~~

This would be represented by two tree objects: one for the root directory, and another for the `src/` directory. Here’s what they would look like.

**tree 4da454..**

  ------ ---------- --------
  blob   976165..   README
  tree   81fc8b..   src
  ------ ---------- --------

**tree 81fc8b..**

  ------ ---------- ---------
  blob   1febef..   hello.c
  ------ ---------- ---------

If we draw the blobs (in green) as well as the tree objects (in blue), we end up with a diagram that looks a lot like our directory structure.

![Git tree graph](http://wildlyinaccurate.com/wp-content/uploads/2014/05/tree-graph.png)

Notice how given the root tree object, we can recurse through every tree object to figure out the state of the entire working tree. The root tree object, therefore, is essentially a snapshot of your repository at a given time. Usually when Git refers to “the tree”, it is referring to the root tree object.

Now let’s learn how you can track the history of your repository with commit objects.

Commits
-------

A commit object is essentially a pointer that contains a few pieces of important metadata. The commit itself has a hash, which is built from a combination of the metadata that it contains:

-   The hash of the tree (the root tree object) at the time of the commit. As we learned in *Tree Objects*, this means that with a single commit, Git can build the entire working tree by recursing into the tree.
-   The hash of any parent commits. This is what gives a repository its history: every commit has a parent commit, all the way back to the very first commit.
-   The author’s name and email address, and the time that the changes were authored.
-   The committer’s name and email address, and the time that the commit was made.
-   The commit message.

Let’s see a commit object in action by creating a simple repository.

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

When you create a commit, Git will give you the hash of that commit. Using `git show` with the `--format=raw` flag, we can see this newly-created commit’s metadata.

~~~~ {.no-highlight}
$ git show --format=raw d409ca7

commit d409ca76bc919d9ca797f39ae724b7c65700fd27
tree 9d073fcdfaf07a39631ef94bcb3b8268bc2106b1
author Joseph Wynn <joseph@wildlyinaccurate.com> 1400976134 -0400
committer Joseph Wynn <joseph@wildlyinaccurate.com> 1400976134 -0400

    First commit

diff --git a/README b/README
new file mode 100644
index 0000000..9761654
--- /dev/null
+++ b/README
@@ -0,0 +1 @@
+This is the readme.
~~~~

Notice how although we referenced the commit by the partial hash `d409ca7`, Git was able to figure out that we actually meant `d409ca76bc919d9ca797f39ae724b7c65700fd27`. This is because the hashes that Git assigns to objects are unique enough to be identified by the first few characters. You can see here that Git is able to find this commit with as few as four characters; after which point Git will tell you that the reference is ambiguous.

~~~~ {.no-highlight}
$ git show d409c
$ git show d409
$ git show d40
fatal: ambiguous argument 'd40': unknown revision or path not in the working tree.
~~~~

References
----------

In previous sections, we saw how objects in Git are identified by a hash. Since we want to manipulate objects quite often in Git, it’s important to know their hashes. You could run all your Git commands referencing each object’s hash, like `git show d409ca7`, but that would require you to remember the hash of every object you want to manipulate.

To save you from having to memorize these hashes, Git has references, or “refs”. A reference is simply a file stored somewhere in `.git/refs`, containing the hash of a commit object.

To carry on the example from *Commits*, let’s figure out the hash of “First commit” using references only.

~~~~ {.no-highlight}
$ git status
On branch master
nothing to commit, working directory clean
~~~~

`git status` has told us that we are on branch `master`. As we will learn in a later section, branches are just references. We can see this by looking in `.git/refs/heads`.

~~~~ {.no-highlight}
$ ls -l .git/refs/heads/
total 4
-rw-rw-r-- 1 demo demo 41 May 24 20:02 master
~~~~

We can easily see which commit `master` points to by reading the file.

~~~~ {.no-highlight}
$ cat .git/refs/heads/master
d409ca76bc919d9ca797f39ae724b7c65700fd27
~~~~

Sure enough, `master` contains the hash of the “First commit” object.

Of course, it’s possible to simplify this process. Git can tell us which commit a reference is pointing to with the `show` and `rev-parse` commands.

~~~~ {.no-highlight}
$ git show --oneline master
d409ca7 First commit
$ git rev-parse master
d409ca76bc919d9ca797f39ae724b7c65700fd27
~~~~

Git also has a special reference, `HEAD`. This is a “symbolic” reference which points to the tip of the current branch rather than an actual commit. If we inspect `HEAD`, we see that it simply points to `refs/head/master`.

~~~~ {.no-highlight}
$ cat .git/HEAD
ref: refs/heads/master
~~~~

It is actually possible for `HEAD` to point directly to a commit object. When this happens, Git will tell you that you are in a “detached HEAD state”. We’ll talk a bit more about this later, but really all this means is that you’re not currently on a branch.

Branches
--------

Git’s branches are often touted as being one of its strongest features. This is because branches in Git are very lightweight, compared to other VCS where a branch is usually a clone of the entire repository.

The reason branches are so lightweight in Git is because they’re just references. We saw in *References* that the `master` branch was simply a file inside `.git/refs/heads`. Let’s create another branch to see what happens under the hood.

~~~~ {.no-highlight}
$ git branch test-branch
$ cat .git/refs/heads/test-branch 
d409ca76bc919d9ca797f39ae724b7c65700fd27
~~~~

It’s as simple as that. Git has created a new entry in `.git/refs/heads` and pointed it at the current commit.

We also saw in *References* that `HEAD` is Git’s reference to the current branch. Let’s see that in action by switching to our newly-created branch.

~~~~ {.no-highlight}
$ cat .git/HEAD
ref: refs/heads/master
$ git checkout test-branch 
Switched to branch 'test-branch'
$ cat .git/HEAD
ref: refs/heads/test-branch
~~~~

When you create a new commit, Git simply changes the current branch to point to the newly-created commit object.

~~~~ {.no-highlight}
$ echo 'Some more information here.' >> README
$ git add README
$ git commit -m "Update README in a new branch"
[test-branch 7604067] Update README in a new branch
 1 file changed, 1 insertion(+)
$ cat .git/refs/heads/test-branch 
76040677d717fd090e327681064ac6af9f0083fb
~~~~

Later on we’ll look at the difference between **local branches** and **remote-tracking branches**.

Tags
----

There are two types of tags in Git – **lightweight tags** and **annotated tags**.

On the surface, these two types of tags look very similar. Both of them are references stored in `.git/refs/tags`. However, that’s about as far as the similarities go. Let’s create a lightweight tag to see how they work.

~~~~ {.no-highlight}
$ git tag 1.0-lightweight
$ cat .git/refs/tags/1.0-lightweight 
d409ca76bc919d9ca797f39ae724b7c65700fd27
~~~~

We can see that Git has created a tag reference which points to the current commit. By default, `git tag` will create a lightweight tag. Note that this is **not a tag object**. We can verify this by using `git cat-file` to inspect the tag.

~~~~ {.no-highlight}
$ git cat-file -p 1.0-lightweight
tree 9d073fcdfaf07a39631ef94bcb3b8268bc2106b1
author Joseph Wynn <joseph@wildlyinaccurate.com> 1400976134 -0400
committer Joseph Wynn <joseph@wildlyinaccurate.com> 1400976134 -0400

First commit
$ git cat-file -p d409ca7
tree 9d073fcdfaf07a39631ef94bcb3b8268bc2106b1
author Joseph Wynn <joseph@wildlyinaccurate.com> 1400976134 -0400
committer Joseph Wynn <joseph@wildlyinaccurate.com> 1400976134 -0400

First commit
~~~~

You can see that as far as Git is concerned, the `1.0-lightweight` tag and the `d409ca7` commit are the *same object*. That’s because the lightweight tag is *only a reference* to the commit object.

Let’s compare this to an annotated tag.

~~~~ {.no-highlight}
$ git tag -a -m "Tagged 1.0" 1.0
$ cat .git/refs/tags/1.0
10589beae63c6e111e99a0cd631c28479e2d11bf
~~~~

We’ve passed the `-a` (`--annotate`) flag to `git tag` to create an annotated tag. Notice how Git creates a reference for the tag just like the lightweight tag, but this reference is not pointing to the same object as the lightweight tag. Let’s use `git cat-file` again to inspect the object.

~~~~ {.no-highlight}
$ git cat-file -p 1.0
object d409ca76bc919d9ca797f39ae724b7c65700fd27
type commit
tag 1.0
tagger Joseph Wynn <joseph@wildlyinaccurate.com> 1401029229 -0400

Tagged 1.0
~~~~

This is a **tag object**, separate to the commit that it points to. As well as containing a pointer to a commit, tag objects also store a tag message and information about the tagger. Tag objects can also be signed with a [GPG key](http://en.wikipedia.org/wiki/GNU_Privacy_Guard "GNU Privacy Guard") to prevent commit or email spoofing.

Aside from being GPG-signable, there are a few reasons why annotated tags are preferred over lightweight tags.

Probably the most important reason is that annotated tags have their own author information. This can be helpful when you want to know who created the tag, rather than who created the commit that the tag is referring to.

Annotated tags are also timestamped. Since new versions are usually tagged right before they are released, an annotated tag can tell you when a version was released rather than just when the final commit was made.

Merging
-------

Merging in Git is the process of joining two histories (usually branches) together. Let’s start with a simple example. Say you’ve created a new feature branch from `master`, and done some work on it.

~~~~ {.no-highlight}
$ git checkout -b feature-branch
Switched to a new branch 'feature-branch'
$ vim feature.html
$ git commit -am "Finished the new feature"
[feature-branch 0c21359] Finished the new feature
 1 file changed, 1 insertion(+)
~~~~

At the same time, you need to fix an urgent bug. So you create a `hotfix` branch from `master`, and do some work in there.

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

At this point, the history will look something like this.

![Branching -- hotfix and feature branch](http://wildlyinaccurate.com/wp-content/uploads/2014/05/branch-feature-hotfix.png)

Now you want to bring the bug fix into `master` so that you can tag it and release it.

~~~~ {.no-highlight}
$ git checkout master
Switched to branch 'master'
$ git merge hotfix
Updating d939a3a..40837f1
Fast-forward
 index.html | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
~~~~

Notice how Git mentions **fast-forward** during the merge. What this means is that all of the commits in `hotfix` were directly upstream from `master`. This allows Git to simply move the `master` pointer up the tree to `hotfix`. What you end up with looks like this.

![Branching -- after merging hotfix](http://wildlyinaccurate.com/wp-content/uploads/2014/05/branch-merge-hotfix.png)

Now let’s try and merge `feature-branch` into `master`.

~~~~ {.no-highlight}
$ git merge feature-branch 
Merge made by the 'recursive' strategy.
 feature.html | 1 +
 1 file changed, 1 insertion(+)
~~~~

This time, Git wasn’t able to perform a fast-forward. This is because `feature-branch` isn’t directly upstream from `master`. This is clear on the graph above, where `master` is at commit **D** which is in a different history tree to `feature-branch` at commit **C**.

So how did Git handle this merge? Taking a look at the log, we see that Git has actually created a new “merge” commit, as well as bringing the commit from `feature-branch`.

~~~~ {.no-highlight}
$ git log --oneline
8ad0923 Merge branch 'feature-branch'
0c21359 Finished the new feature
40837f1 Fixed some wording
d939a3a Initial commit
~~~~

Upon closer inspection, we can see that this is a special kind of commit object — it has **two parent commits**. This is referred to as a **merge commit**.

~~~~ {.no-highlight}
$ git show --format=raw 8ad0923

commit 8ad09238b0dff99e8a99c84d68161ebeebbfc714
tree e5ee97c8f9a4173f07aa4c46cb7f26b7a9ff7a17
parent 40837f14b8122ac6b37c0919743b1fd429b3bbab
parent 0c21359730915c7888c6144aa8e9063345330f1f
author Joseph Wynn <joseph@wildlyinaccurate.com> 1401134489 +0100
committer Joseph Wynn <joseph@wildlyinaccurate.com> 1401134489 +0100

 Merge branch 'feature-branch'
~~~~

This means that our history graph now looks something like this (commit **E** is the new merge commit).

![Branching -- after merging feature-branch](http://wildlyinaccurate.com/wp-content/uploads/2014/05/branch-merge-feature.png)

Some people believe that this sort of history graph is undesirable. In the *Rebasing (Continued)* section, we’ll learn how to prevent non-fast-forward merges by rebasing feature branches before merging them with `master`.

Rebasing
--------

Rebasing is without a doubt one of Git’s most misunderstood features. For most people, `git rebase` is a command that should be avoided at all costs. This is probably due to the extraordinary amount of scaremongering around rebasing. *“Rebase Considered Harmful”*, and *“Please, stay away from rebase” *are just two of the many anti-rebase articles you will find in the vast archives of the Internet.

But rebase isn’t scary, or dangerous, so long as you understand what it does. But before we get into rebasing, I’m going to take a quick digression, because it’s actually much easier to explain rebasing in the context of cherry-picking.

Cherry-Picking
--------------

What `git cherry-pick` does is take one or more commits, and replay them on top of the current commit. Imagine a repository with the following history graph.

![Node graph -- before cherry-pick](http://wildlyinaccurate.com/wp-content/uploads/2014/05/cherry-pick-before.png)

If you are on commit **D** and you run `git cherry-pick F`, Git will take the changes that were introduced in commit **F** and replay them *as a new commit* (shown as **F’**) on top of commit **D.**

![Node graph -- after cherry-pick](http://wildlyinaccurate.com/wp-content/uploads/2014/05/cherry-pick-after.png)

The reason you end up with a *copy* of commit **F** rather than commit **F** itself is due to the way commits are constructed. Recall that the parent commit is part of a commit’s hash. So despite containing the exact same changes, author information and timestamp; **F’** will have a different parent to **F**, giving it a different hash.

A common workflow in Git is to develop features on small branches, and merge the features one at a time into the master branch. Let’s recreate this scenario by adding some branch labels to the graphs.

![Node graph -- with branch labels](http://wildlyinaccurate.com/wp-content/uploads/2014/05/graph-branch-labels.png)

As you can see, `master` has been updated since `foo` was created. To avoid potential conflicts when `foo` is merged with `master`, we want to bring `master`‘s changes into `foo`. Because `master` is the *base* branch, we want to play `foo`‘s commits *on top* of `master`. Essentially, we want to change commit **C**‘s parent from **B** to **F**.

It’s not going to be easy, but we can achieve this with `git cherry-pick`. First, we need to create a temporary branch at commit *F*.

~~~~ {.no-highlight}
$ git checkout master
$ git checkout -b foo-tmp
~~~~

![Node graph -- after creating foo-tmp](http://wildlyinaccurate.com/wp-content/uploads/2014/05/foo-tmp.png)

Now that we have a base on commit *F*, we can `cherry-pick` all of `foo`‘s commits on top of it.

~~~~ {.no-highlight}
$ git cherry-pick C D
~~~~

![Node graph -- after cherry-picking C and D](http://wildlyinaccurate.com/wp-content/uploads/2014/05/cherry-pick-c-d.png)

Now all that’s left to do is point `foo` at commit **D’**, and delete the temporary branch `foo-tmp`. We do this with the `reset` command, which points `HEAD` (and therefore the current branch) at a specified commit. The `--hard` flag ensures our working tree is updated as well.

~~~~ {.no-highlight}
$ git checkout foo
$ git reset --hard foo-tmp
$ git branch -D foo-tmp
~~~~

This gives the desired result of `foo`‘s commits being upstream of `master`. Note that the original **C** and **D** commits are no longer reachable because no branch points to them.

![Node graph -- after resetting foo](http://wildlyinaccurate.com/wp-content/uploads/2014/05/cherry-pick-final.png)

Rebasing (Continued)
--------------------

While the example in *Cherry-Picking* worked, it’s not practical. In Git, rebasing allows us to replace our verbose cherry-pick workflow…

~~~~ {.no-highlight}
$ git checkout master
$ git checkout -b foo-tmp
$ git cherry-pick C D
$ git checkout foo
$ git reset --hard foo-tmp
$ git branch -D foo-tmp
~~~~

…With a single command.

~~~~ {.no-highlight}
$ git rebase master foo
~~~~

With the format `git rebase <base> <target>`, the `rebase` command will take all of the commits from `<target>` and play them on top of `<base>` one by one. It does this without actually modifying `<base>`, so the end result is a linear history in which `<base>` can be fast-forwarded to `<target>`.

In a sense, performing a rebase is like telling Git, **“Hey, I want to pretend that `<target>` was actually branched from `<base>`. Take all of the commits from `<target>`, and pretend that they happened *after* `<base>`“**.

Let’s take a look again at the example graph from *Merging* to see how rebasing can prevent us from having to do a non-fast-forward merge.

![Branching -- after merging hotfix](http://wildlyinaccurate.com/wp-content/uploads/2014/05/branch-merge-hotfix.png)

All we have to do to enable a fast-forward merge of `feature-branch` into `master` is run `git rebase master feature-branch` before performing the merge.

~~~~ {.no-highlight}
$ git rebase master feature-branch
First, rewinding head to replay your work on top of it...
Applying: Finished the new feature
~~~~

This has brought `feature-branch` directly upstream of `master`.

![Rebasing -- rebase feature-branch with master](http://wildlyinaccurate.com/wp-content/uploads/2014/05/rebase-feature.png)

Git is now able to perform a fast-forward merge.

~~~~ {.no-highlight}
$ git checkout master
$ git merge feature-branch
Updating 40837f1..2a534dd
Fast-forward
 feature.html | 1 +
 1 file changed, 1 insertion(+)
~~~~

Remotes
-------

In order to collaborate on any Git project, you need to utilise at least one remote repository. Unlike centralised VCS which require a dedicated server daemon, a Git remote is simply another Git repository. In order to demonstrate this, we first need to understand the concept of a *bare* repository.

Recall that Git stores the entire repository inside the `.git` directory. Inside this directory are blobs and tree objects which can be traversed to build a snapshot of the entire project. This means that Git doesn’t actually *need* a working tree — it only uses the working tree to figure out what changes have been made since the last commit. This is easily demonstrated if you delete a file from a repository, and then run `git checkout <file>`. Despite being removed from the file system, Git can still restore the file because it has previously stored it in the repository. You can do the same thing with entire directories and Git will still be able to restore everything by traversing its tree objects.

It is therefore possible to have a repository which can store your project’s history without actually having a working tree. This is called a *bare* repository. Bare repositories are most commonly used as a “central” repository where collaborators can share changes. The mechanism for sharing these changes will be explained in detail in the *Pushing* and *Pulling* sections. For now, let’s look at creating a bare repository.

~~~~ {.no-highlight}
$ git init --bare
Initialised empty Git repository in /home/demo/bare-repo/
$ ls -l
total 12
drwxrwxr-x 1 demo demo   0 May 31 12:58 branches
-rw-rw-r-- 1 demo demo  66 May 31 12:58 config
-rw-rw-r-- 1 demo demo  73 May 31 12:58 description
-rw-rw-r-- 1 demo demo  23 May 31 12:58 HEAD
drwxrwxr-x 1 demo demo 328 May 31 12:58 hooks
drwxrwxr-x 1 demo demo  14 May 31 12:58 info
drwxrwxr-x 1 demo demo  16 May 31 12:58 objects
drwxrwxr-x 1 demo demo  18 May 31 12:58 refs
~~~~

Notice how rather than creating a `.git` directory for the repository, `git init --bare` simply treats the current directory as the `.git` directory.

There’s really not much to this repository. The only interesting things it contains are a `HEAD` reference which points to the `master` branch (which doesn’t exist yet), and a `config` file which has the `bare` flag set to `true`. The other files aren’t of much interest to us.

~~~~ {.no-highlight}
$ find . -type f
./info/exclude
./hooks/commit-msg.sample
./hooks/pre-commit.sample
./hooks/pre-push.sample
./hooks/pre-rebase.sample
./hooks/pre-applypatch.sample
./hooks/applypatch-msg.sample
./hooks/post-update.sample
./hooks/prepare-commit-msg.sample
./hooks/update.sample
./description
./HEAD
./config

$ cat HEAD 
ref: refs/heads/master
$ cat config 
[core]
    repositoryformatversion = 0
    filemode = true
    bare = true
~~~~

So what can we do with this repository? Well, nothing much right now. Git won’t let us modify the repository because it doesn’t have a working tree to modify. (Note: this isn’t strictly true. We could painstakingly use Git’s low-level commands to manually create and store objects in Git’s data store, but that is beyond the scope of this guide. If you’re *really* interested, read [*Git Internals – Git Objects*](http://git-scm.com/book/en/Git-Internals-Git-Objects)).

~~~~ {.no-highlight}
$ touch README
$ git add README 
fatal: This operation must be run in a work tree
~~~~

The intended use of this repository is for other collaborators to `clone` and `pull` changes from, as well as `push` their own changes to.

### Cloning

Now that we’ve set up a bare repository, let’s look at the concept of *cloning* a repository.

The `git clone` command is really just a shortcut which does a few things for you. With its default configuration, it will:

1.  Create remote-tracking branches for each branch in the remote.
2.  Check out the branch which is currently active (`HEAD`) on the remote.
3.  Perform a `git fetch` to update all remote-tracking branches.
4.  Perform a `git pull` to bring the current branch and working tree up-to-date with the remote.

The `clone` command takes a URL and supports a number of transport protocols including HTTP, SSH, and Git’s own protocol. It also supports plain old file paths, which is what we’ll use.

~~~~ {.no-highlight}
$ cd ..
$ git clone bare-repo/ clone-of-bare-repo
Cloning into 'clone-of-bare-repo'...
warning: You appear to have cloned an empty repository.
done.
~~~~

Let’s inspect this cloned repository to see how Git has set it up.

~~~~ {.no-highlight}
$ cd clone-of-bare-repo/
$ find . -type f
./.git/info/exclude
./.git/hooks/commit-msg.sample
./.git/hooks/pre-commit.sample
./.git/hooks/pre-push.sample
./.git/hooks/pre-rebase.sample
./.git/hooks/pre-applypatch.sample
./.git/hooks/applypatch-msg.sample
./.git/hooks/post-update.sample
./.git/hooks/prepare-commit-msg.sample
./.git/hooks/update.sample
./.git/description
./.git/HEAD
./.git/config

$ cat .git/HEAD
ref: refs/heads/master
$ ls -l .git/refs/heads/
total 0
$ cat .git/config
[core]
    repositoryformatversion = 0
    filemode = true
    bare = false
    logallrefupdates = true
[remote "origin"]
    url = /home/demo/bare-repo/
    fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
    remote = origin
    merge = refs/heads/master
~~~~

This is quite literally a clone of `bare-repo`. The only difference is that this repository contains a few extra lines in `.git/config`.

First, it contains a `remote` listing for “origin”, which is the default name given to a repository’s main remote. This tells Git the URL of the repository, and which references it should retrieve when performing a `git fetch`.

Below that is a `branch` listing. This is the configuration for a *remote-tracking branch*. But before we get into that, let’s store some data in the remote repository.

### Pushing

We’ve just cloned a completely empty repository, and we want to start working on it.

~~~~ {.no-highlight}
$ echo 'Project v1.0' > README
$ git add README 
$ git commit -m "Add readme"
[master (root-commit) 5d591d5] Add readme
 1 file changed, 1 insertion(+)
 create mode 100644 README
~~~~

Notice that even though it didn’t *technically* exist (there was nothing in `.git/refs/heads`), this commit has been made to the `master` branch. That’s because the `HEAD` of this repository pointed to `master`, so Git has gone ahead and created the branch for us.

~~~~ {.no-highlight}
$ cat .git/refs/heads/master 
5d591d5fafd538610291f45bec470d1b4e77891e
~~~~

Now that we’ve completed some work, we need to share this with our collaborators who have also cloned this repository. Git makes this really easy.

~~~~ {.no-highlight}
$ git push origin master
Counting objects: 3, done.
Writing objects: 100% (3/3), 231 bytes | 0 bytes/s, done.
Total 3 (delta 0), reused 0 (delta 0)
To /home/demo/bare-repo/
 * [new branch] master -> master
~~~~

Notice how we specified both the remote (`origin`) and the branch (`master`) that we want Git to push. It *is* possible to simply run `git push`, but this can be dangerous and is generally advised against. Running `git push` without any arguments can (depending on your configuration) push all remote-tracking branches. This is usually okay, but it can result in you pushing changes which you don’t want collaborators to pull. In the worst case, you can destroy other collaborators’ changes if you specify the `--force` flag.

So, let’s take a look at the remote repository to see what happened.

~~~~ {.no-highlight}
$ cd ../bare-repo/
$ cat refs/heads/master 
5d591d5fafd538610291f45bec470d1b4e77891e

$ git show 5d591d5
commit 5d591d5fafd538610291f45bec470d1b4e77891e
Author: Joseph Wynn <joseph@wildlyinaccurate.com>
Date: Sat May 31 14:08:34 2014 +0100

 Add readme

diff --git a/README b/README
new file mode 100644
index 0000000..5cecdfb
--- /dev/null
+++ b/README
@@ -0,0 +1 @@
+Project v1.0
~~~~

As we expected, the remote repository now contains a `master` branch which points to the commit that we just created.

Essentially what happened when we ran `git push`, is Git updated the remote’s references, and sent it any objects required to build those references. In this case, `git push` updated the remote’s `master` to point at `5d591d5`, and sent it the `5d591d5` commit object as well as any tree and blob objects related to that commit.

### Remote-Tracking Branches

As we saw in *Cloning*, a remote-tracking branch is essentially just a few lines in `.git/config`. Let’s take a look at those lines again.

~~~~ {.no-highlight}
[branch "master"]
    remote = origin
    merge = refs/heads/master
~~~~

The line `[branch "master"]` denotes that the following configuration applies to the *local* `master` branch.

The rest of the configuration specifies that when this remote-tracking branch is fetched, Git should fetch the `master` branch from the `origin` remote.

Besides storing this configuration, Git also stores a local copy of the remote branch. This is simply stored as a reference in `.git/refs/remotes/<remote>/<branch>`. We’ll see more about how this works in *Fetching*.

### Fetching

The `git fetch` command is fairly simple. It takes the name of a remote (unless used with the `--all` flag, which fetches all remotes), and retrieves any new references and all objects necessary to complete them.

Recall what a remote’s configuration looks like.

~~~~ {.no-highlight}
[remote "origin"]
    url = /home/demo/bare-repo/
    fetch = +refs/heads/*:refs/remotes/origin/*
~~~~

The `fetch` parameter here specifies a mapping of `<remote-refs>:<local-refs>`. The example above simply states that the references found in origin’s `refs/heads/*` should be stored locally in `refs/remotes/origin/*`. We can see this in the repository that we cloned earlier.

~~~~ {.no-highlight}
$ ls -l .git/refs/remotes/origin/
total 4
-rw-rw-r-- 1 demo demo 41 May 31 14:12 master
~~~~

Let’s see a fetch in action to get a better idea of what happens. First, we’ll create a new branch on the remote repository.

~~~~ {.no-highlight}
$ cd ../bare-repo/
$ git branch feature-branch
~~~~

Now we’ll run `git fetch` from the clone.

~~~~ {.no-highlight}
$ cd ../clone-of-bare-repo/
$ git fetch origin
From /home/demo/bare-repo
 * [new branch] feature-branch -> origin/feature-branch
~~~~

This has done a couple of things. First, it has created a reference for the remote branch in `.git/refs/remotes/origin`.

~~~~ {.no-highlight}
$ cat .git/refs/remotes/origin/feature-branch 
5d591d5fafd538610291f45bec470d1b4e77891e
~~~~

It has also updated a special file, `.git/FETCH_HEAD` with some important information. We’ll talk about this file in more detail soon.

~~~~ {.no-highlight}
$ cat .git/FETCH_HEAD 
5d591d5fafd538610291f45bec470d1b4e77891e branch 'master' of /home/demo/bare-repo
5d591d5fafd538610291f45bec470d1b4e77891e not-for-merge branch 'feature-branch' of /home/demo/bare-repo
~~~~

What is *hasn’t* done is created a local branch. This is because Git understands that even though the remote has a `feature-branch`, you might not want it in your local repository.

But what if we *do* want a local branch which tracks the remote `feature-branch`? Git makes this easy. If we run `git checkout feature-branch`, rather than failing because no local `feature-branch` exists, Git will see that there is a remote `feature-branch` available and create a local branch for us.

~~~~ {.no-highlight}
$ git checkout feature-branch

Branch feature-branch set up to track remote branch feature-branch from origin.
Switched to a new branch 'feature-branch'
~~~~

Git has done a couple of things for us here. First, it has created a local `feature-branch` reference which points to the same commit as the remote `feature-branch`.

~~~~ {.no-highlight}
$ cat .git/refs/remotes/origin/feature-branch 
5d591d5fafd538610291f45bec470d1b4e77891e
$ cat .git/refs/heads/feature-branch 
5d591d5fafd538610291f45bec470d1b4e77891e
~~~~

It has also created a remote-tracking branch entry in `.git/config`.

~~~~ {.no-highlight}
$ cat .git/config 
[core]
    repositoryformatversion = 0
    filemode = true
    bare = false
    logallrefupdates = true
[remote "origin"]
    url = /home/demo/bare-repo/
    fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
    remote = origin
    merge = refs/heads/master
[branch "feature-branch"]
    remote = origin
    merge = refs/heads/feature-branch
~~~~

### Pulling

The `git pull` command is, like `git clone`, a nice shortcut which essentially just runs a few lower-level commands. In short, with the format `git pull <remote> <branch>`, the `git pull` command does the following:

1.  Runs `git fetch <remote>`.
2.  Reads `.git/FETCH_HEAD` to figure out if `<branch>` has a remote-tracking branch which should be merged.
3.  Runs `git merge` if required, otherwise quits with an appropriate message.

At this point, it helps to understand Git’s `FETCH_HEAD`. Every time you run `git fetch`, Git stores information about the fetched branches in `.git/FETCH_HEAD`. This is referred to as a *short-lived reference*, because by default Git will override the contents of `FETCH_HEAD` every time you run `git fetch`.

Let’s introduce some new commits to our remote repository so that we can see this in practice.

~~~~ {.no-highlight}
$ git clone bare-repo/ new-clone-of-bare-repo
Cloning into 'new-clone-of-bare-repo'...
done.

$ cd new-clone-of-bare-repo/
$ git checkout feature-branch
Branch feature-branch set up to track remote branch feature-branch from origin.
Switched to a new branch 'feature-branch'

$ echo 'Some more information.' >> README 
$ git commit -am "Add more information to readme"
[feature-branch 7cd83c2] Add more information to readme
 1 file changed, 1 insertion(+)
$ git push origin feature-branch
Counting objects: 5, done.
Writing objects: 100% (3/3), 298 bytes | 0 bytes/s, done.
Total 3 (delta 0), reused 0 (delta 0)
To /home/demo/bare-repo/
   5d591d5..7cd83c2  feature-branch -> feature-branch
~~~~

Now, using the steps outlined earlier, let’s manually perform a `git pull` on the other clone to pull in the changes we just introduced.

~~~~ {.no-highlight}
$ cd ../clone-of-bare-repo/
$ git fetch origin
remote: Counting objects: 5, done.
remote: Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
From /home/demo/bare-repo
   5d591d5..7cd83c2  feature-branch -> origin/feature-branch
$ cat .git/FETCH_HEAD 
7cd83c29d7360dfc432d556fdbf03eb83ec5158d        branch 'feature-branch' of /home/demo/bare-repo
5d591d5fafd538610291f45bec470d1b4e77891e    not-for-merge   branch 'master' of /home/demo/bare-repo
~~~~

At this point, Git has updated our local copy of the remote branch, and updated the information in `FETCH_HEAD`.

~~~~ {.no-highlight}
$ cat .git/refs/heads/feature-branch 
5d591d5fafd538610291f45bec470d1b4e77891e
$ cat .git/refs/remotes/origin/feature-branch 
7cd83c29d7360dfc432d556fdbf03eb83ec5158d
~~~~

We know from `FETCH_HEAD` that the fetch introduced some changes to `feature-branch`. So all that’s left to do to complete the “pull” is perform a merge.

~~~~ {.no-highlight}
$ git merge FETCH_HEAD
Updating 5d591d5..7cd83c2
Fast-forward
 README | 1 +
 1 file changed, 1 insertion(+)
~~~~

And that’s it — we’ve just performed a `git pull` without actually running `git pull`. Of course, it is much easier to let Git take care of these details. Just to be sure that the outcome is the same, we can run `git pull` as well.

~~~~ {.no-highlight}
$ git reset --hard HEAD^1
HEAD is now at 5d591d5 Add readme
$ git pull origin feature-branch
From /home/demo/bare-repo
 * branch            feature-branch -> FETCH_HEAD
Updating 5d591d5..7cd83c2
Fast-forward
 README | 1 +
 1 file changed, 1 insertion(+)
~~~~

Toolkit
-------

With a solid understanding of Git’s inner workings, some of the more advanced Git tools start to make more sense.

### git-reflog

Whenever you make a change in Git that affects the tip of a branch, Git records information about that change in what’s called the reflog. Usually you shouldn’t need to look at these logs, but sometimes they can come in *very* handy.

Let’s say you have a repository with a few commits.

~~~~ {.no-highlight}
$ git log --oneline
d6f2a84 Add empty LICENSE file
51c4b49 Add some actual content to readme
3413f46 Add TODO note to readme
322c826 Add empty readme
~~~~

You decide, for some reason, to perform a destructive action on your `master` branch.

~~~~ {.no-highlight}
$ git reset --hard 3413f46
HEAD is now at 3413f46 Add TODO note to readme
~~~~

Since performing this action, you’ve realised that you lost some commits and you have no idea what their hashes were. You never pushed the changes; they were only in your local repository. `git log` is no help, since the commits are no longer reachable from `HEAD`.

~~~~ {.no-highlight}
$ git log --oneline
3413f46 Add TODO note to readme
322c826 Add empty readme
~~~~

This is where `git reflog` can be useful.

~~~~ {.no-highlight}
$ git reflog
3413f46 HEAD@{0}: reset: moving to 3413f46
d6f2a84 HEAD@{1}: commit: Add empty LICENSE file
51c4b49 HEAD@{2}: commit: Add some actual content to readme
3413f46 HEAD@{3}: commit: Add TODO note to readme
322c826 HEAD@{4}: commit (initial): Add empty readme
~~~~

The reflog shows a list of all changes to `HEAD` in reverse chronological order. The hash in the first column is the value of `HEAD` *after the action on the right was performed*. We can see, therefore, that we were at commit `d6f2a84` before the destructive change.

How you want to recover commits depends on the situation. In this particular example, we can simply do a `git reset --hard d6f2a84` to restore `HEAD` to its original position. However if we have introduced new commits since the destructive change, we may need to do something like `cherry-pick` all the commits that were lost.

Note that Git’s reflog is only a record of changes **for your local repository**. If your local repository becomes corrupt or is deleted, the reflog won’t be of any use (if the repository is deleted the reflog won’t exist at all!)

Depending on the situation, you may find `git fsck` more suitable for recovering lost commits.

### git-fsck

In a way, Git’s object storage works like a primitive file system — objects are like files on a hard drive, and their hashes are the objects’ physical address on the disk. The Git index is exactly like the index of a file system, in that it contains references which point at an object’s physical location.

By this analogy, `git fsck` is aptly named after `fsck` (“file system check”). This tool is able to check Git’s database and verify the validity and reachability of every object that it finds.

When a reference (like a branch) is deleted from Git’s index, the object(s) they refer to usually aren’t deleted, even if they are no longer reachable by any other references. Using a simple example, we can see this in practice. Here we have a branch, `feature-branch`, which points at `f71bb43`. If we delete `feature-branch`, the commit will no longer be reachable.

~~~~ {.no-highlight}
$ git branch
  feature-branch
* master
$ git rev-parse --short feature-branch      
f71bb43
$ git branch -D feature-branch 
Deleted branch feature-branch (was f71bb43).
~~~~

At this point, commit `f71bb43` still exists in our repository, but there are no references pointing to it. By searching through the database, `git fsck` is able to find it.

~~~~ {.no-highlight}
$ git fsck --lost-found
Checking object directories: 100% (256/256), done.
dangling commit f71bb43907bffe0bce2967504341a0ece7a8cb68
~~~~

For simple cases, `git reflog` may be preferred. Where `git fsck` excels over `git reflog`, though, is when you need to find objects which you never referenced in your local repository (and therefore would not be in your reflog). An example of this is when you delete a remote branch through an interface like GitHub. Assuming the objects haven’t been garbage-collected, you can clone the remote repository and use `git fsck` to recover the deleted branch.

### git-stash

// TODO

### git-describe

Git’s `describe` command is summed up pretty neatly in the documentation:

> git-describe – Show the most recent tag that is reachable from a commit

This can be helpful for things like build and release scripts, as well as figuring out which version a change was introduced in.

`git describe` will take any reference or commit hash, and return the name of the most recent tag. If the tag points at the commit you gave it, `git describe` will return only the tag name. Otherwise, it will suffix the tag name with some information including the number of commits since the tag and an abbreviation of the commit hash.

~~~~ {.no-highlight}
$ git describe v1.2.15
v1.2.15
$ git describe 2db66f
v1.2.15-80-g2db66f5
~~~~

If you want to ensure that only the tag name is returned, you can force Git to remove the suffix by passing `--abbrev=0`.

~~~~ {.no-highlight}
$ git describe --abbrev=0 2db66f
v1.2.15
~~~~

### git-rev-parse

`git rev-parse` is an ancillary plumbing command which takes a wide range of inputs and returns one or more commit hashes. The most common use case is figuring out which commit a tag or branch points to.

~~~~ {.no-highlight}
$ git rev-parse v1.2.15        
2a46f5e2fbe83ccb47a1cd42b81f815f2f36ee9d
$ git rev-parse --short v1.2.15        
2a46f5e
~~~~

### git-bisect

`git bisect` is an indispensable tool when you need to figure out which commit introduced a breaking change. The `bisect` command does a binary search through your commit history to help you find the breaking change as quickly as possible. To get started, simply run `git bisect start`, and tell Git that the commit you’re currently on is broken with `git bisect bad`. Then, you can give Git a commit that you know is working with `git bisect good <commit>`.

~~~~ {.no-highlight}
$ git bisect start
$ git bisect bad
$ git bisect good v1.2.15
Bisecting: 41 revisions left to test after this (roughly 5 steps)
[b87713687ecaa7a873eeb3b83952ebf95afdd853] docs(misc/index): add header; general links
~~~~

Git will then checkout a commit and ask you to test whether it’s broken or not. If the commit is broken, run `git bisect bad`. If the commit is fine, run `git bisect good`. After doing this a few times, Git will be able to pinpoint the commit which first introduced the breaking change.

~~~~ {.no-highlight}
$ git bisect bad
e145a8df72f309d5fb80eaa6469a6148b532c821 is the first bad commit
~~~~

Once the `bisect` is finished (or when you want to abort it), be sure to run `git bisect reset` to reset `HEAD` to where it was before the `bisect`.

Posted in [Git](http://wildlyinaccurate.com/category/git "View all posts in Git") and tagged [blob](http://wildlyinaccurate.com/tag/blob), [commit](http://wildlyinaccurate.com/tag/commit), [git](http://wildlyinaccurate.com/tag/git-2), [merge](http://wildlyinaccurate.com/tag/merge), [rebase](http://wildlyinaccurate.com/tag/rebase), [tag](http://wildlyinaccurate.com/tag/tag), [tree](http://wildlyinaccurate.com/tag/tree) on 25 May 2014 by Joseph.

« [Understanding JavaScript: Inheritance and the prototype chain](http://wildlyinaccurate.com/understanding-javascript-inheritance-and-the-prototype-chain)

-   chrismccoy

    i put together a list of git cheats that could be useful to some people [https://gist.github.com/chrismccoy/8775224](https://gist.github.com/chrismccoy/8775224)

-   guoc

    A typo\
     \> Now that we have a base on commit F, we can cherry-pick all of foo‘s commits on top if it.

    “if it” -\> “of it”

    -   wildlyinaccurate

        Thank you!

-   Sam Hopkins

    Great writeup so far. I encourage you to finish out the //TODO!

-   Jonathan M. Hethey

    Dude. This is like a distilled book tutorial overview cheat sheet on steroids! Good job :D

-   Victor Hom

    so helpful

-   ???

    Shed light on the ‘.git’ directory. Thanks.

-   rawryree

    great article, but I was truly confused by the directions of the arrows in the a-b-c-d-e-f diagrams of commits in rebase/cherry-pick. I read it, seeing the arrows as the flow of history forward in time, and more or less ignored that the letters were running backwards (after all, commit hashes are random looking things, I’m used to ignoring their names). I would suggest you have another arrow somewhere pointing which direction is forward to save on confusion.

-   Matt S

    I think you should add a section on the reset command before the cherry-pick section. Reading from start to finish, it was kind of confusing when you suddenly used a new command (which can be tricky in its own right) while explaining cherry-pick with only a quick explanation of what it does.

    Great guide so far, though. One of the clearer explanations of Git internals that I’ve seen.

-   Harro van der Klauw

    In the cherry pick example at the end you say that commits C and D are no longer reachable becaus eno branch points to them. But the commits are still there right?\
     If I have the revision of those specific commits I would still get them.

-   jerome\_gangneux

    Hey, how can I be notified when you will update this post?

-   Abdullah Mamun

    Very nice. Look forward to see using with SVN like git-svn.

-   http://ansimionescu.com/ Andrei Simionescu

    Great article, thanks!

-   progrock

    Helpful article and high quality comments. The best mix.

-   Victor Espíritu

    Excelente guia …..!

-   http://www.shakedos.com/ Shaked Klein Orbach

    Is it possible to suscribe somewhere so I will be able to get an update once you finish the article? Great writing.

-   Ruben Vereecken

    I really like the page so far, I hope you manage to finish it!\
     If you’re planning on adding to your ‘rebase’ section, like another comment suggested, might I request a bit on interactive git rebase and, related, commit squashing? I found reading up on those to be really helpful in practice.

-   trans

    I love Git because of GitHub, but beyond that I am not so taken. It’s not that there is something technically wrong with git, rather, it is technically very right, but it is in the wrong place. When you said “Subversion fits in nicely with our existing computing paradigms. Everybody understands files and folders.” That pretty much hits the nail on the head. Git has essentially built a file system on top of a file system. This limits access to ones files via the git gate keeper, so to speak, and a disconnect between the actual file system and the vcs (e.g. \`rm foo\` vs \`git rm foo\`). I am convinced the next generation of version control system will be the one that integrates the concepts of versioning, a la git, into the file system itself, allowing us to work once again in the conceptual paradigm of files and folders, but with all the benefits of version control, a la svn.

-   behemoth

    great job bro :)

-   gondoSVK

    would be helpful to mention how to deal with conflicts during merge and rebase

-   http://shime.github.com/ Hrvoje Šimi?

    Couldn’t a problem in a cherry picking example be solved in a simpler way? Maybe I’m crazy, but I usually just merge master into the feature branch.

    -   Sam Wyman

        I think the point is that it’s a simple, contrived example. Especially since that section is used as an introduction to the rebase section.

    -   Lemure

        Then you create a non-linear history in your branch, which is what you avoid with both cherry-pick and rebase.

        -   Guest

            How does cherry-picking directly onto the \`master\` branch create a non-linear history? I know it says in the article it does but I don’t see how.

            -   Lemure

                It doesn’t, and nobody said so. Merging does (unless it is strictly fast-forward, which it isn’t if you have to merge changes from master into your feature branch). Rebasing and cherry-picking is used to avoid non-linear history.

-   Kim Silkebækken

    Also, don’t forget to check out the man pages if you want to be a true git pro: [http://git-man-page-generator.lokaltog.net/](http://git-man-page-generator.lokaltog.net/)

-   http://madhur.github.com Madhur

    The article is good. But I feel there are some missing pieces:

    \$ git reset –hard foo-bar\
     \$ git branch -D foo-bar\
     What is “foo-bar” here? There is no mention of it in the text.

    Can you elaborate on difference between rebase and merge? In which scenarios you prefer one over another.

    -   wildlyinaccurate

        Thank you, that was supposed to be foo-tmp — I’ve fixed that.

        I’d certainly like to expand on merge & rebase; I’ll be adding more on that this week. For now though, my rule of thumb is that rebase is for bringing feature branches up-to-date with master. Merge is for bringing feature branches into master. There are other situations, of course, like wanting to bring a feature branch up-to-date with another feature branch. Usually in this case I’d rebase, but this really depends on the situation. Like I said, hopefully I’ll be able to expand on this in the guide later.

        -   David Shimon

            Hi, same problem (foo-bar instead of foo-tmp) under Rebasing (Continued) when listing the “manual rebase” commands.

            -   wildlyinaccurate

                Good save, thank you!

    -   tunesmith

        I tend to prefer merge over rebase when it is important to me to accurately track the dates of when changes were actually first committed. Like, when it’s important to see from the revision history that I implemented Feature X between 2 and 4pm on Tuesday afternoon.

        I tend to prefer rebase over merge when timeline isn’t so important, and when I instead want to optimize for gathering chunks of commits together into one conceptual whole. Like, if I have worked on a new feature privately over a two-week period, during a time when bunches of other commits have been pushed to origin. If I want to push my feature to origin and have its commits bundled together as a cohesive whole (for easier review), then rebase is better than merge.

        So it depends on whether you want to optimize for accurate history (merge), or clarity of conceptual change (rebase).

        -   mcagl

            Well, man git-rebase mentions this option:

            –committer-date-is-author-date, –ignore-date\
             These flags are passed to git am to easily change the dates of the rebased commits (see git-am(1)). Incompatible with the –interactive option.

            which is what you want to do when you choose merging instead of rebasing, if I understood correctly.

        -   http://madhur.github.com Madhur

            I feel what you are telling is reverse.

            “If I want to push my feature to origin and have its commits bundled\
             together as a cohesive whole (for easier review), then rebase is better\
             than merge.”

            I think rebase would preserve your commit history. So in this case, you should go with merge rather than rebase.

            See [http://git-scm.com/book/en/Git-Branching-Rebasing](http://git-scm.com/book/en/Git-Branching-Rebasing)

            If you examine the log of a rebased branch, it looks like a linear\
             history: it appears that all the work happened in series, even when it\
             originally happened in parallel.

-   Keshav Kini

    \>The reason you end up with a copy of commit F rather than commit F itself is due to the way commits are constructed. Recall that the parent commit is part of a commit’s hash. So despite containing the exact same changes, author information and timestamp; F’ will have a different parent to F, giving it a different hash.

    This is very misleading. Commits do not contain “changes”, they contain full snapshots of the codebase (or whatever files you’re tracking). F’ is not a copy of F in any way. F’ is a commit that is formed by taking the diff from E to F and applying that diff to D, just like 105 is a number formed by taking the difference between 7 and 12 and adding it to 100. 105 is not a “copy of 12″, and neither is F’ a copy of F.

    Furthermore, since commits contain snapshots and not diffs, the hash of F’ would be completely different from the hash of F even if their parent fields were identical, because they would contain completely different tree objects created from completely different blob objects. To imply that the reason their hashes are different is merely that they have different parents is, well, wildly inaccurate.

    -   wildlyinaccurate

        Thanks for the feedback; I guess the wording could be clearer. While a commit doesn’t actually contain a diff, when Git performs a cherry-pick it calculates the diff for that commit and re-applies it at HEAD. So (and bare with me here), given A \<– B \<– C, if you did \`git reset –hard B\`, reset the computer's clock to be the same time that C was committed, and then ran \`git cherry-pick C\`… C \*should\* have the exact same hash that it did before. At least that's my understanding of it — please correct me if I'm wrong!

        -   Keshav Kini

            C will have the exact same hash that it did before, of course – no object’s hash ever changes in the git data store. Also, and I guess this is what you meant to say, \`git cherry-pick\` will have “created” a commit with the same hash as C, and moved the current branch pointer to that commit. In practice this means that the current branch pointer will just move back to C.

            The “reset the computer’s clock to be the same time that C was committed” step can be avoided either by setting the GIT\_COMMITTER\_DATE environment variable to the date seen in the “committer” line of the output of \`git cat-file -p C\`, or by invoking \`git cherry-pick\` with the \`–ff\` flag. The only reason this step is even necessary is that the standard headers of a git commit object contain both an authoring date and a committing date. History surgery operations like cherry-pick, rebase, etc. tend to preserve the author date but update the committer date to the present moment, thus changing the hash.

            Note that this has nothing to do with the normal usage of \`git cherry-pick\`, which is to cherry pick a commit from one branch onto another one, not onto the commit’s own parent. My main point was that it’s wrong to say in general that C’ is a copy of C or to imply that the only thing distinguishing C’ from C is a few differences in the commit headers. That’s a fundamental conceptual error.

            -   Krishna Srinivas

                Keshav’s explanation makes sense. Looking forward to the other sections. Thanks!

-   http://www.scriptcrafty.com/ david karapetyan

    Well done. Looking forward to the section on remotes.

