import UIKit
import Combine
import Domain

final class UserCell: TableViewCell, Configurable {
    
    func configure(with user: User) {
        var userContent = UserContentConfiguration()
        userContent.name = user.name
        userContent.login = user.login
        userContent.avatarURL = user.avatarURL
        contentConfiguration = userContent
    }
}

private final class UserContentView: View, UIContentView {
    
    private var imageTask: Cancellable?
    
    let avatarImageView = UIImageView()
    let nameLabel = UILabel()
    let loginLabel = UILabel()
    
    var configuration: any UIContentConfiguration {
        didSet {
            apply(configuration: configuration)
        }
    }
    
    init(configuration: UserContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        apply(configuration: configuration)
    }
    
    override func setupAutoLayout() {
        add(subviews: [
            avatarImageView,
            nameLabel,
            loginLabel
        ])
        
        let padding = 15.0
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: 50),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor)
                .withPriority(.defaultHigh),
            
            nameLabel.topAnchor.constraint(greaterThanOrEqualTo: avatarImageView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: padding),
            nameLabel.bottomAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            loginLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            loginLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            loginLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            loginLabel.bottomAnchor.constraint(lessThanOrEqualTo: avatarImageView.bottomAnchor),
        ])
    }
    
    private func apply(configuration: UIContentConfiguration) {
        guard let configuration = configuration as? UserContentConfiguration else {
            return
        }
        nameLabel.text = configuration.name
        loginLabel.text = configuration.login
        imageTask = avatarImageView.loadImage(with: configuration.avatarURL)
    }
}

private struct UserContentConfiguration: UIContentConfiguration {
    
    var name = ""
    var login = ""
    var avatarURL: URL?
    
    func makeContentView() -> any UIView & UIContentView {
        UserContentView(configuration: self)
    }
    
    func updated(for state: any UIConfigurationState) -> UserContentConfiguration {
        self
    }
}
