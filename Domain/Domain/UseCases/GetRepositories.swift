import Foundation
import RxSwift

public struct GetRepositories: UseCase {
    private let githubRepository = Container.resolve(GithubRepository.self)
    
    public init() {
        
    }
    
    public func execute() -> Observable<[Repository]> {
        githubRepository.repositories(since: nil)
    }
}
