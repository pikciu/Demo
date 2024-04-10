import UIKit
import Combine
import Domain

final class AddUserCell: TableViewCell, Configurable {
    
    private var cancellables = Set<AnyCancellable>(minimumCapacity: 4)
    private let textField = UITextField()
    
    override func setupAppearance() {
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.returnKeyType = .search
        textField.autocapitalizationType = .none
    }
    
    override func localizeInterface() {
        textField.placeholder = String(localized: .localizable.nickname)
    }
    
    override func setupAutoLayout() {
        contentView.add(subviews: [textField])
        
        let padding = 15.0
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cancellables.removeAll(keepingCapacity: true)
    }
    
    func configure(with viewModel: AddUserViewModel) {
        textField.publisher(for: .editingChanged)
            .compactMap(\.text)
            .sink(with: viewModel) { $0.input.setText($1) }
            .store(in: &cancellables)
        
        viewModel.output.isError.map { $0 ? UIColor.systemPink : UIColor.systemBackground }
            .assign(to: \.backgroundColor, on: textField)
            .store(in: &cancellables)
        
        viewModel.output.text.assign(to: \.text, on: textField)
            .store(in: &cancellables)
        
        textField.publisher(for: .editingDidEndOnExit)
            .sink(with: viewModel) { $0.input.addUser() }
            .store(in: &cancellables)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if editing {
            textField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
    }
}
