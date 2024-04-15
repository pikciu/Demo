import UIKit
import Domain
import Combine

final class UsersViewController: ViewController<UsersView> {
    
    private var cancellables = Set<AnyCancellable>(minimumCapacity: 1)
    private let viewModel: UsersViewModel
    private let cellProvider = UsersCellProvider()
    private lazy var dataSource = UsersDataSource(tableView: ui.tableView, cellProvider: cellProvider.create())
    
    init(viewModel: UsersViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = String(localized: .localizable.users)
        setupTableView()
        bind()
    }
    
    private func bind() {
        viewModel.output.snapshot.sink(with: dataSource) { $0.apply($1) }
            .store(in: &cancellables)
        
        viewModel.output.isEditing.sink(with: self) { $0.setMode(isEditing: $1) }
            .store(in: &cancellables)
        
        ui.editButton.publisher.sink(with: viewModel) { $0.input.edit() }
            .store(in: &cancellables)
        
        ui.doneButton.publisher.sink(with: viewModel) { $0.input.endEditing() }
            .store(in: &cancellables)
    }
    
    private func setMode(isEditing: Bool) {
        ui.tableView.setEditing(isEditing, animated: true)
        let button = isEditing ? ui.doneButton : ui.editButton
        navigationItem.setRightBarButton(button, animated: true)
    }
    
    private func setupTableView() {
        ui.tableView.register(AddUserCell.self)
        ui.tableView.register(UserCell.self)
        ui.tableView.delegate = self
    }
}

extension UsersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if case .user = dataSource.itemIdentifier(for: indexPath) {
            return .delete
        } else {
            return .insert
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard case .user(let user) = dataSource.itemIdentifier(for: indexPath) else {
            return nil
        }
        let deleteAction = UIContextualAction(style: .destructive, title: String(localized: .localizable.delete)) { [weak viewModel] action, view, completion in
            viewModel?.input.delete(user: user)
            completion(true)
        }
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard case .user(let user) = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        viewModel.input.showDetails(user: user)
    }
}
