import Foundation
import RxSwift
import RxCocoa

public final class PublicRepositoriesPresenter {
    private let disposeBag = DisposeBag()
    private let activityIndicator = ActivityIndicator()

    public unowned let view: PublicRepositoriesView

    public init(view: PublicRepositoriesView) {
        self.view = view
        
        GetRepositories(since: nil, after: nil)
            .execute()
            .subscribe(with: self, onNext: { (context, repositories) in
                log.debug(repositories)
            }, onError: { (context, error) in
                log.warning(error)
            }, onCompleted: { _ in
                log.verbose("complted")
            }, onDisposed: { _ in
                log.verbose("disposed")
            }).disposed(by: disposeBag)
    }
}
