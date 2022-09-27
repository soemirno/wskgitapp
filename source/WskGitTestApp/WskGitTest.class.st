Class {
	#name : 'WskGitTest',
	#superclass : 'TestCase',
	#instVars : [
		'tempFolder'
	],
	#category : 'WskGitTestApp'
}

{ #category : 'Resources',
 #vaCategories : ['Resources','Tests'] }
WskGitTest >> executeCommand: aCommandString [
	| starter process readStream execOkay commands |
	commands := aCommandString.
	starter := OsProcessStarter shell: commands.
	starter workingDirectory: tempFolder.
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

{ #category : 'Resources' }
WskGitTest >> headCommit [
	^
'tree 9d483075a9ff58767ee46d18f71376a4ea902af6
parent f9428058eae860ae5d389aad09bef8f8b4516c8d
author Comm Itter <committer@repos.com> 1661417275 +0200
committer Comm Itter <committer@repos.com> 1661417275 +0200

add header
' 
		copyWithout: Character cr
]

{ #category : 'Not categorized' }
WskGitTest >> setUp [
		
	| stream |

	tempFolder  := ( OsProcessEnvironment current at: 'TEMP' ) , '\gitrepostest', 1000 atRandom printString .
	
	CfsDirectoryDescriptor mkdir: tempFolder.
	self executeCommand: 'git init'.
	
	stream := CfsReadWriteFileStream openEmpty: (tempFolder, '\readme.md').
	stream nextPutAll: 'temp'; close.
	
	self executeCommand: 'git add .'.
	
]

{ #category : 'Not categorized' }
WskGitTest >> tearDown [
	(CfsPath named: tempFolder) deleteAll
	
]

{ #category : 'Tests' }
WskGitTest >> testCatFileCommit [
	| git |
	git := WskGit newWith: 'C:\temp\test_repos\'.
	self assert: git catFileHead equals: self headCommit
]

{ #category : 'Tests' }
WskGitTest >> testCommitMessage [
	| git output firstLine |
	git := WskGit newWith: tempFolder.
	output := git commit: 'a message'.
	firstLine :=  (ReadStream on: output) nextLine.
	self assert:  ( firstLine endsWithSubCollection: 'a message') .
]

{ #category : 'Tests' }
WskGitTest >> testRepositoryPath [
	| git |
	git := WskGit newWith: 'C:\temp\test_repos\'.
	self assert: (git repositoryPath) originalName equals: 'C:\temp\test_repos\'
]
