import Combine

public protocol ReposViewModelInput { }
public protocol ReposViewModelOutput {
    var title: String { get }
    var snapshot: AnyPublisher<Snapshot<ReposSnapshot>, Never> { get }
}

public protocol ReposViewModel {
    
    var input: ReposViewModelInput { get }
    var output: ReposViewModelOutput { get }
}
