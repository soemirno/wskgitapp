# wskgitapp

A VA Smalltalk wrapper for git commands.

# Why?
* To have a workflow with the ability to view and edit Smalltalk without a Smalltalk IDE. For example reviewing code changes could be done using standard Gitlab/Github functionality. Audits can be done by non-programmers.
* To integrate documentation and project tasks in a single repository. Using md files documentation is automatically published on Gitlab/Github and we can easily link changes to an issue tracker.
* To use a git repository to control the CI/CD pipeline. 
* To have a single repository for the whole project including both Smalltalk and non-Smalltalk resources.

# Installing
Clone this repository locally and use tonel to load the applications.

# Usage
Sample workspace script for pushing changes from the image to the remote repository.

```smalltalk
commitMessage := 'feat: push something'.
localClone := 'C:\xxx\repositories\WskGitApp'.

TonelWriter new
  applications:  (#('WskGitApp' 'WskGitTestApp') collect:[:each|  Smalltalk classAt: each asSymbol   ]);
  writeProjectInto: (CfsPath named: localClone. 

git := WskGit newWith: localClone.
output := git stageAllChanges.
Transcript cr; show: output.

output := git commit: commitMessage.
Transcript cr; show: output.

output := git push.
Transcript cr; show: output
```
