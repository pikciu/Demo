import UIKit
import Reusable
import RxCells
import Domain
import Kingfisher

final class RepositoryCell: UITableViewCell, Reusable, RxCells.Configurable {
    
    private let ui = RepositoryCellUI()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attach(ui: ui)
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        super.setSelected(false, animated: animated)
    }
    
    func configure(with model: Repository) {
        ui.ownerAvatar.kf.setImage(with: model.owner.avatarURL)
        ui.ownerNameLabel.text = model.owner.name
        ui.nameLabel.text = model.name
        ui.sourceLogo.image = model.source.logo
    }
}
