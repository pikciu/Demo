import Foundation
import Domain
import RxSwift

struct BitbucketRepository: Domain.BitbucketRepository {
    
    func repositories(after: Date?) -> Observable<[Repository]> {
        APIClient()
            .execute(
                request: BitbucketRepositoriesRequest(after: after),
                responseMapper: BitbucketPageMapper(BitbucketRepositoryMapper())
            )
    }
}
