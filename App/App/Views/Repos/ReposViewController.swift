import UIKit
import Domain
import Combine

final class ReposViewController: ViewController<UITableView> {
    
    typealias DataSource = UITableViewDiffableDataSource<ReposSection, Repo>
    
    private var cancellables = Set<AnyCancellable>(minimumCapacity: 1)
    private let viewModel: ReposViewModel
    private let cellProvider = RepoCellProvider()
    private lazy var dataSource = DataSource(tableView: ui, cellProvider: cellProvider.create())
    
    init(viewModel: ReposViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.output.title
        setupTableView()
        bind()
    }
    
    private func bind() {
        viewModel.output.snapshot.sink(with: dataSource) { $0.apply($1.data, animatingDifferences: $1.animate) }
            .store(in: &cancellables)
    }
    
    private func setupTableView() {
        ui.register(RepoCell.self)
        ui.delegate = self
    }
}

extension ReposViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let repo = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        debugPrint(repo)
    }
}
