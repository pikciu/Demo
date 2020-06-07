import Foundation
import Domain
import RxSwift

struct MockBitbucketRepository: Domain.BitbucketRepository {
    
    func repositories(after: Date?) -> Observable<[Repository]> {
        Mock(filename: "bitbucket").load(mapper: BitbucketPageMapper(BitbucketRepositoryMapper()))
    }
}
