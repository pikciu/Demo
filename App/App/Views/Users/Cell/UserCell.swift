import UIKit
import Combine
import Domain

final class UserCell: TableViewCell, Configurable {
    
    override func setupAppearance() {
        automaticallyUpdatesBackgroundConfiguration = false
    }
    
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
    private lazy var stackView = UIStackView(arrangedSubviews: [loginLabel, nameLabel])
    
    let avatarImageView = UIImageView()
    let loginLabel = UILabel()
    let nameLabel = UILabel()
    
    var configuration: UIContentConfiguration {
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
        stackView.axis = .vertical
        stackView.spacing = 2
    }
    
    override func setupAutoLayout() {
        add(subviews: [
            avatarImageView,
            stackView,
        ])
        
        let padding = 15.0
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: 50),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor)
                .withPriority(.defaultHigh),
            
            stackView.topAnchor.constraint(greaterThanOrEqualTo: avatarImageView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: padding),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: avatarImageView.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    private func apply(configuration: UIContentConfiguration) {
        guard let configuration = configuration as? UserContentConfiguration else {
            return
        }
        loginLabel.text = configuration.login
        nameLabel.text = configuration.name
        imageTask = avatarImageView.loadImage(with: configuration.avatarURL)
        nameLabel.isHidden = configuration.isNameHidden
    }
}

private struct UserContentConfiguration: UIContentConfiguration {
    
    var login = ""
    var name: String?
    var avatarURL: URL?
    
    var isNameHidden: Bool {
        name?.isEmpty != false
    }
    
    func makeContentView() -> any UIView & UIContentView {
        UserContentView(configuration: self)
    }
    
    func updated(for state: any UIConfigurationState) -> UserContentConfiguration {
        self
    }
}
