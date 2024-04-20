import Combine

public struct ReposUpdater {
    
    let localRepository: RepoLocalRepository
    let remoteRepository: RepoRemoteRepository
    
    func updateRepos(forUser user: String) async {
        do {
            let repos = try await remoteRepository.repos(user: user)
            try localRepository.add(repos: repos)
        } catch {
            debugPrint(error)
        }
    }
}
