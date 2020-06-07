import Foundation
import RxSwift
import RxCocoa

public final class MyRepositoriesPresenter {
    private let disposeBag = DisposeBag()
    private let activityIndicator = ActivityIndicator()

    public unowned let view: MyRepositoriesView

    public init(view: MyRepositoriesView) {
        self.view = view
    }
}
