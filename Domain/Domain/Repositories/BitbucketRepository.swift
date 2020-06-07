import Foundation
import RxSwift

public protocol BitbucketRepository {
    
    func repositories(after: Date?) -> Observable<[Repository]>
}
