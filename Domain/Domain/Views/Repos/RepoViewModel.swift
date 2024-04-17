import Resources
import UIKit
import Combine

public struct RepoViewModel: Hashable {
    
    private let repo: Repo
    private let toggleFavoriteSubject = PassthroughSubject<Repo, Never>()
    private let favoriteReposProvider: FavoriteReposProvider
    private let cancellables = Box(Set<AnyCancellable>(minimumCapacity: 1))
    private var isFavorite: AnyPublisher<Bool, Never> {
        favoriteReposProvider.isFavorite(id: repo.id)
    }
    
    public var name: String {
        repo.name
    }
    
    public var info: NSAttributedString {
        let text = NSMutableAttributedString()
        if let eye = Symbol.eye.image {
            text.append(NSTextAttachment(image: eye))
            text.append(string(for: repo.watchers))
        }
        if let branch = Symbol.branch.image {
            text.append(NSTextAttachment(image: branch))
            text.append(string(for: repo.forks))
        }
        if let star = Symbol.star.image {
            text.append(NSTextAttachment(image: star))
            text.append(" \(repo.stars)")
        }
        return text
    }
    
    public var heart: AnyPublisher<Symbol, Never> {
        isFavorite.map { $0 ? .heart.fill : .heart }
            .eraseToAnyPublisher()
    }
    
    init(repo: Repo, favoriteReposProvider: FavoriteReposProvider) {
        self.repo = repo
        self.favoriteReposProvider = favoriteReposProvider
        
        toggleFavoriteSubject.withLatestFrom(isFavorite) { ($0, $1) }
            .sink(with: favoriteReposProvider) { $0.toggleFavorite(repo: $1.0, isFavorite: $1.1) }
            .store(in: &cancellables.value)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(repo)
    }
    
    public func toggleFavorite() {
        toggleFavoriteSubject.send(repo)
    }
    
    private func string(for value: Int) -> String {
        " \(value)".padding(toLength: 10, withPad: " ", startingAt: 0)
    }
    
    public static func == (lhs: RepoViewModel, rhs: RepoViewModel) -> Bool {
        lhs.repo == rhs.repo
    }
}

final class Box<T> {
    
    var value: T
    
    init(_ value: T) {
        self.value = value
    }
}
