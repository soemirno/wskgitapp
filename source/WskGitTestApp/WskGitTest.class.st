Class {
	#name : 'WskGitTest',
	#superclass : 'TestCase',
	#category : 'WskGitTestApp'
}

{ #category : 'Tests' }
WskGitTest >> testCatFileCommit [
	| git |
	git := WskGit newWith: 'C:\temp\test_repos\'.
	self assert: git catFileCommit  equals: ('tree 9d483075a9ff58767ee46d18f71376a4ea902af6
parent f9428058eae860ae5d389aad09bef8f8b4516c8d
author Comm Itter <committer@repos.com> 1661417275 +0200
committer Comm Itter <committer@repos.com> 1661417275 +0200

add header
' copyWithout: Character cr ).
	
]

{ #category : 'Tests' }
WskGitTest >> testRepositoryPath [
	| git |
	git := WskGit newWith: 'C:\temp\test_repos\'.
	self assert: (git repositoryPath) originalName equals: 'C:\temp\test_repos\'
]
