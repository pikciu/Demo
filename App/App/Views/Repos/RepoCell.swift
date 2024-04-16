import UIKit
import Domain
import Resources

final class RepoCell: TableViewCell, Configurable {
    
    private let nameLabel = UILabel()
    private let infoLabel = UILabel()
    private let favoriteButton = UIButton(configuration: .plain())
    private lazy var stackView = UIStackView(arrangedSubviews: [nameLabel, infoLabel])
    private let infoMapper = RepoInfoMapper()
    
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
    
    func configure(with repo: Repo) {
        nameLabel.text = repo.name
        infoLabel.attributedText = infoMapper.map(from: repo)
        var config = favoriteButton.configuration
        config?.image = repo.isFavorite ? .symbol(.heart.fill) : .symbol(.heart)
        favoriteButton.configuration = config
    }
}

struct RepoInfoMapper: Mapper {
    
    func map(from repo: Repo) -> NSAttributedString {
        let text = NSMutableAttributedString()
        if let eye = UIImage.symbol(.eye) {
            text.append(NSTextAttachment(image: eye))
            text.append(string(for: repo.watchers))
        }
        if let branch = UIImage.symbol(.branch) {
            text.append(NSTextAttachment(image: branch))
            text.append(string(for: repo.forks))
        }
        if let star = UIImage.symbol(.star) {
            text.append(NSTextAttachment(image: star))
            text.append(" \(repo.stars)")
        }
        return text
    }
    
    private func string(for value: Int) -> String {
        " \(value)".padding(toLength: 10, withPad: " ", startingAt: 0)
    }
}

extension NSMutableAttributedString {
    
    func append(_ attachment: NSTextAttachment) {
        append(NSAttributedString(attachment: attachment))
    }
    
    func append(_ string: String) {
        append(NSAttributedString(string: string))
    }
}
