import Foundation
import Domain
import RxSwift

struct MockGithubRepository: Domain.GithubRepository {
    
    func repositories(since: Int?) -> Observable<[Repository]> {
        Mock(filename: "github").load(mapper: ArrayMapper(GithubRepositoryMapper()))
    }
}
