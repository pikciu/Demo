import Foundation
import RxSwift
import RxCocoa

public final class PublicRepositoriesPresenter {
    private let disposeBag = DisposeBag()
    private let activityIndicator = ActivityIndicator()

    public unowned let view: PublicRepositoriesView
    
    private let repositories = BehaviorRelay(value: [Repository]())

    public init(view: PublicRepositoriesView) {
        self.view = view
        
        activityIndicator.drive(view.isBusy).disposed(by: disposeBag)
        
        GetRepositories(since: nil, after: nil)
            .execute()
            .trackActivity(activityIndicator)
            .subscribe(with: self, onNext: { (context, repositories) in
                context.append(repositories: repositories)
            })
            .disposed(by: disposeBag)
        
        repositories.map({ $0.sorted() })
            .bind(to: view.repositories)
            .disposed(by: disposeBag)
    }
    
    private func append(repositories newRepositories: [Repository]) {
        repositories.accept(repositories.value + newRepositories)
    }
}
