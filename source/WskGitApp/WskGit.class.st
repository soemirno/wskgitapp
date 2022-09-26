"
I execute git commands on a git repository
"
Class {
	#name : 'WskGit',
	#superclass : 'Object',
	#instVars : [
		'repositoryPath'
	],
	#category : 'WskGitApp'
}

{ #category : 'Creation' }
WskGit class >> newWith: reposPathString [

	^ self new repositoryPath: (CfsPath named: reposPathString) 
	
]

{ #category : 'accessing' }
WskGit >> catFileCommit: aHash [

	^ self executeCommand: 'git cat-file commit ' , aHash
]

{ #category : 'accessing' }
WskGit >> catFileHead [

	^ self catFileCommit: 'HEAD'
]

{ #category : 'accessing' }
WskGit >> commit: aMessage [

	^ self executeCommand: (OrderedCollection with:'git' with: 'commit' with:  ( '-m''%1''' bindWith: aMessage))  
]

{ #category : 'accessing' }
WskGit >> executeCommand: aCommandString [
	| starter process readStream execOkay commands |
	commands := aCommandString.
	starter := OsProcessStarter shell: commands.
	starter workingDirectory: self repositoryPath.
	starter redirectOutputToPipe.
	process := starter start.
	process waitForCompletion.
	execOkay := process exitCode isZero.
	^execOkay 
		ifTrue: 
			[readStream := process outputStream upToEnd readStream.
			readStream contents]
		ifFalse: ['error']
]

{ #category : 'running' }
WskGit >> push [

	^ self executeCommand: 'git push' 
]

{ #category : 'accessing' }
WskGit >> repositoryPath [
	^ repositoryPath
]

{ #category : 'accessing' }
WskGit >> repositoryPath: path [
	repositoryPath := path
]

{ #category : 'accessing' }
WskGit >> stageAllChanges [

	^ self executeCommand: 'git add .' 
]
