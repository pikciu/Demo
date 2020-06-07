import Foundation
import RxSwift

public protocol GithubRepository {
    
    func repositories(since: Int?) -> Observable<[Repository]>
}
