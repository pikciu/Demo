import Combine
import Container

public final class AddUserViewModel {
    
    private var cancellables = Set<AnyCancellable>(minimumCapacity: 2)
    private let textSubject = CurrentValueSubject<String, Never>("")
    private let addUserSubject = PassthroughSubject<Void, Never>()
    private let isErrorSubject = CurrentValueSubject<Bool, Never>(false)
    
    public var isError: AnyPublisher<Bool, Never> {
        isErrorSubject.eraseToAnyPublisher()
    }
    
    public var text: AnyPublisher<String?, Never> {
        textSubject.removeDuplicates()
            .map { $0 }
            .eraseToAnyPublisher()
    }
    
    init() {
        addUserSubject.withLatestFrom(textSubject)
            .map { Container.resolve(UserCreator.self).tryCreateUser(withName: $0) }
            .switchToLatest()
            .receive(on: DispatchQueue.main)
            .sink(with: self) { $0.handle(success: $1) }
            .store(in: &cancellables)
        
        textSubject.sink(with: isErrorSubject) { $0.send(false) }
            .store(in: &cancellables)
    }
    
    public func setText(_ text: String) {
        textSubject.send(text)
    }
    
    public func addUser() {
        addUserSubject.send()
    }
    
    private func handle(success: Bool) {
        if success {
            textSubject.send("")
        } else {
            isErrorSubject.send(true)
        }
    }
}
