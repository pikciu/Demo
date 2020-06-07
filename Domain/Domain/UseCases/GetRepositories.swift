import Foundation
import RxSwift

struct GetRepositories: UseCase {
    private let githubRepository = Container.resolve(GithubRepository.self)
    
    func execute() -> Observable<[Repository]> {
        githubRepository.repositories(since: nil)
    }
}
