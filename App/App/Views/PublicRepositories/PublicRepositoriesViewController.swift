import UIKit
import Domain
import RxSwift
import RxCocoa

final class PublicRepositoriesViewController: UIViewController, PublicRepositoriesView {

    private let ui = PublicRepositoriesUI()
    private var presenter: PublicRepositoriesPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        ui.attach(to: self)
        presenter = PublicRepositoriesPresenter(view: self)
    }
}
