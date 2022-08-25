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
| starter process readStream execOkay |
	starter := OsProcessStarter shell: 'git cat-file commit ', aHash.
	starter workingDirectory: self repositoryPath.
	starter redirectOutputToPipe.
	process := starter start.
		
	process waitForCompletion.
	execOkay := process exitCode isZero.
	^execOkay ifTrue:[
		readStream := process outputStream upToEnd readStream.
		readStream contents] 
		ifFalse:['']
]

{ #category : 'accessing' }
WskGit >> catFileHead [

	^ self catFileCommit: 'HEAD'
]

{ #category : 'accessing' }
WskGit >> repositoryPath [
	^ repositoryPath
]

{ #category : 'accessing' }
WskGit >> repositoryPath: path [
	repositoryPath := path
]
