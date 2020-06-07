import Foundation
import RxSwift

public protocol PublicRepositoriesView: class {
    var repositories: AnyObserver<[Repository]> { get }
    var isBusy: AnyObserver<Bool> { get }
}
