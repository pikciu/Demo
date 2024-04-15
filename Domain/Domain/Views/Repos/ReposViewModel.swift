import Combine

public protocol ReposViewModelInput { }
public protocol ReposViewModelOutput {
    var title: String { get }
    var snapshot: AnyPublisher<ReposSnapshot, Never> { get }
}

public protocol ReposViewModel {
    
    var input: ReposViewModelInput { get }
    var output: ReposViewModelOutput { get }
}
