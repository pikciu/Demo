import Foundation
import RxSwift

struct GetRepositories: UseCase {
    private let githubRepository = Container.resolve(GithubRepository.self)
    private let bitbucketRepository = Container.resolve(BitbucketRepository.self)
    
    let since: Int?
    let after: Date?
    
    func execute() -> Observable<[Repository]> {
        let github = githubRepository.repositories(since: since)
        let bitbucket = bitbucketRepository.repositories(after: after)
        return Observable.merge(github, bitbucket)
    }
}
