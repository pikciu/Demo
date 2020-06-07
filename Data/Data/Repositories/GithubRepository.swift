import Foundation
import Domain
import RxSwift

struct GithubRepository: Domain.GithubRepository {
    
    func repositories(since: Int?) -> Observable<[Repository]> {
        APIClient()
            .execute(
                request: GithubRepositoriesRequest(since: since),
                elementMapper: GithubRepositoryMapper()
            )
    }
}
