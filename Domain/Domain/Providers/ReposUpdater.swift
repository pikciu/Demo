import Combine

public struct ReposUpdater {
    
    let localRepository: RepoLocalRepository
    let remoteRepository: RepoRemoteRepository
    
    public init(localRepository: RepoLocalRepository, remoteRepository: RepoRemoteRepository) {
        self.localRepository = localRepository
        self.remoteRepository = remoteRepository
    }
    
    func updateRepos(forUser user: String) -> Cancellable {
        remoteRepository.repos(user: user)
            .tryMap { repos in
                try localRepository.add(repos: repos)
            }
            .sink { completion in
                debugPrint(completion)
            }
    }
}
