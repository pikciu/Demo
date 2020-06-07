import UIKit
import Domain
import RxSwift
import RxCocoa
import RxCells

final class PublicRepositoriesViewController: UIViewController, PublicRepositoriesView {

    private let disposeBag = DisposeBag()
    private let ui = PublicRepositoriesUI()
    private var presenter: PublicRepositoriesPresenter!
    
    var repositories: AnyObserver<[Repository]> {
        ui.tableView.rx.cells(type: RepositoryCell.self).disposed(by: disposeBag)
    }
    
    var isBusy: AnyObserver<Bool> {
        ui.tableView.apply(IncrementalLoadingDecorator()).asObserver()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        attach(ui: ui)
        presenter = PublicRepositoriesPresenter(view: self)
        
        ui.tableView.register(cellType: RepositoryCell.self)
    }
}
