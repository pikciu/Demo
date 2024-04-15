import UIKit

class TableViewCell: UITableViewCell, Reusable {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setup() {
        localizeInterface()
        setupAppearance()
        setupAutoLayout()
        setupActionHandlers()
    }
    
    func localizeInterface() {
        
    }
    
    func setupAppearance() {
        
    }
    
    func setupAutoLayout() {
        
    }
    
    func setupActionHandlers() {
        
    }
}
