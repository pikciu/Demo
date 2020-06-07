import UIKit
import Domain
import RxSwift
import RxCocoa

final class MyRepositoriesViewController: UIViewController, MyRepositoriesView {

    private let disposeBag = DisposeBag()
    private let ui = MyRepositoriesUI()
    private var presenter: MyRepositoriesPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        attach(ui: ui)
        presenter = MyRepositoriesPresenter(view: self)
    }
}
