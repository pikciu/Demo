import UIKit

final class RepositoryCellUI: View {
    let nameLabel = UILabel()
    let ownerNameLabel = UILabel()
    let ownerAvatar = UIImageView()
    let sourceLogo = UIImageView()
    let shadowView = UIView()
    
    override func setupAppearance() {
        nameLabel.font = .systemFont(ofSize: 18, weight: .medium)
        ownerNameLabel.font = .systemFont(ofSize: 16, weight: .regular)
        ownerAvatar.apply(AvatarDecorator())
        shadowView.apply(RoundCorners(radius: 6))
        shadowView.apply(Shadow())
    }
    
    override func setupAutoLayout() {
        add(subviews: shadowView, nameLabel, ownerNameLabel, ownerAvatar, sourceLogo)
        
        let margin = CGFloat(16)
        
        activate(
            ownerAvatar.topAnchor.constraint(equalTo: topAnchor, constant: margin),
            ownerAvatar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            ownerAvatar.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -margin),
            ownerAvatar.widthAnchor.constraint(equalToConstant: 60),
            ownerAvatar.heightAnchor.constraint(equalTo: ownerAvatar.widthAnchor).with(priority: .defaultHigh),
            
            shadowView.topAnchor.constraint(equalTo: ownerAvatar.topAnchor),
            shadowView.bottomAnchor.constraint(equalTo: ownerAvatar.bottomAnchor),
            shadowView.leadingAnchor.constraint(equalTo: ownerAvatar.leadingAnchor),
            shadowView.trailingAnchor.constraint(equalTo: ownerAvatar.trailingAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: ownerAvatar.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: ownerAvatar.trailingAnchor, constant: margin),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),
            
            ownerNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            ownerNameLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            ownerNameLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            sourceLogo.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            sourceLogo.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        )
    }
}
