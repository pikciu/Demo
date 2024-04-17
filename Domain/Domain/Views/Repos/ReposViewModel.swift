import Combine

public protocol ReposViewModel {
    var title: String { get }
    var snapshot: AnyPublisher<Snapshot<ReposSnapshot>, Never> { get }
}
