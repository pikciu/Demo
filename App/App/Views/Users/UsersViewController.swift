import UIKit
import Domain
import Combine

final class UsersViewController: ViewController<UsersView> {
    
    typealias DataSource = UITableViewDiffableDataSource<UsersSection, User>
    
    private var cancellables = Set<AnyCancellable>(minimumCapacity: 1)
    private let viewModel: UsersViewModel
    private let cellProvider = UsersCellProvider()
    private lazy var dataSource = DataSource(tableView: ui.tableView, cellProvider: cellProvider.create())
    
    init(viewModel: UsersViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ui.tableView.register(UserCell.self)
        bind()
        view.backgroundColor = .gray
    }
    
    private func bind() {
        viewModel.output.snapshot.sink(with: dataSource) { $0.apply($1) }
            .store(in: &cancellables)
    }
}
