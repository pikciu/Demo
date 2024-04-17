import UIKit
import Domain
import Resources
import Combine

final class RepoCell: TableViewCell, Configurable {
    
    private let nameLabel = UILabel()
    private let infoLabel = UILabel()
    private let favoriteButton = UIButton(configuration: .plain())
    private lazy var stackView = UIStackView(arrangedSubviews: [nameLabel, infoLabel])
    private var cancellables = Set<AnyCancellable>(minimumCapacity: 2)
    
    override func setupAppearance() {
        automaticallyUpdatesBackgroundConfiguration = false
        stackView.axis = .vertical
        stackView.spacing = 2
        
        favoriteButton.setContentHuggingPriority(.required, for: .horizontal)
        favoriteButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        nameLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
        nameLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        infoLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        infoLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
    }
    
    override func setupAutoLayout() {
        contentView.add(subviews: [stackView, favoriteButton])
        
        let padding = 15.0
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            
            favoriteButton.leadingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: padding),
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            favoriteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    func configure(with viewModel: RepoViewModel) {
        cancellables.removeAll(keepingCapacity: true)
        nameLabel.text = viewModel.name
        infoLabel.attributedText = viewModel.info
        
        viewModel.heart.sink(with: self) { $0.setImage(symbol: $1) }
            .store(in: &cancellables)
        
        favoriteButton.publisher(for: .touchUpInside)
            .sink { _ in viewModel.toggleFavorite() }
            .store(in: &cancellables)
    }
    
    private func setImage(symbol: Symbol) {
        var config = favoriteButton.configuration
        config?.image = symbol.image
        favoriteButton.configuration = config
    }
}
