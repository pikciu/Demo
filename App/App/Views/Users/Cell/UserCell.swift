import UIKit
import Combine
import Domain

final class UserCell: TableViewCell, Configurable {
    
    func configure(with user: User) {
        var userContent = UserContentConfiguration()
        userContent.login = user.login
        userContent.name = user.name
        userContent.avatarURL = user.avatarURL
        contentConfiguration = userContent
    }
}

private final class UserContentView: View, UIContentView {
    
    private var imageTask: Cancellable?
    
    let avatarImageView = UIImageView()
    let loginLabel = UILabel()
    let nameLabel = UILabel()
    
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
    
    override func setupAppearance() {
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.clipsToBounds = true
        avatarImageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    }
    
    override func setupAutoLayout() {
        add(subviews: [
            avatarImageView,
            loginLabel,
            nameLabel
        ])
        
        let padding = 15.0
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: 50),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor)
                .withPriority(.defaultHigh),
            
            loginLabel.topAnchor.constraint(greaterThanOrEqualTo: avatarImageView.topAnchor),
            loginLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: padding),
            loginLabel.bottomAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            loginLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            nameLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 2),
            nameLabel.leadingAnchor.constraint(equalTo: loginLabel.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: loginLabel.trailingAnchor),
            nameLabel.bottomAnchor.constraint(lessThanOrEqualTo: avatarImageView.bottomAnchor),
        ])
    }
    
    private func apply(configuration: UIContentConfiguration) {
        guard let configuration = configuration as? UserContentConfiguration else {
            return
        }
        loginLabel.text = configuration.login
        nameLabel.text = configuration.name
        imageTask = avatarImageView.loadImage(with: configuration.avatarURL)
    }
}

private struct UserContentConfiguration: UIContentConfiguration {
    
    var login = ""
    var name: String?
    var avatarURL: URL?
    
    func makeContentView() -> any UIView & UIContentView {
        UserContentView(configuration: self)
    }
    
    func updated(for state: any UIConfigurationState) -> UserContentConfiguration {
        self
    }
}
