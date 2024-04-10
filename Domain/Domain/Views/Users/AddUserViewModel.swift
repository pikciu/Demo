import Combine
import Container

public final class AddUserViewModel: ViewModel {
    public struct Input {
        private let textSubject: CurrentValueSubject<String, Never>
        private let addUserSubject: PassthroughSubject<Void, Never>
        
        init(
            textSubject: CurrentValueSubject<String, Never>,
            addUserSubject: PassthroughSubject<Void, Never>
        ) {
            self.textSubject = textSubject
            self.addUserSubject = addUserSubject
        }
        
        public func setText(_ text: String) {
            textSubject.send(text)
        }
        
        public func addUser() {
            addUserSubject.send()
        }
    }
    public struct Output {
        public let isError: AnyPublisher<Bool, Never>
        public let text: AnyPublisher<String?, Never>
    }
    
    public private(set) lazy var input = Input(
        textSubject: textSubject,
        addUserSubject: addUserSubject
    )
    public private(set) lazy var output = Output(
        isError: isErrorSubject.removeDuplicates()
            .eraseToAnyPublisher(),
        text: textSubject.removeDuplicates()
            .map { $0 }
            .eraseToAnyPublisher()
    )
    
    private var cancellables = Set<AnyCancellable>(minimumCapacity: 2)
    private let textSubject = CurrentValueSubject<String, Never>("")
    private let addUserSubject = PassthroughSubject<Void, Never>()
    private let isErrorSubject = CurrentValueSubject<Bool, Never>(false)
    
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
    
    private func handle(success: Bool) {
        if success {
            textSubject.send("")
        } else {
            isErrorSubject.send(true)
        }
    }
}
