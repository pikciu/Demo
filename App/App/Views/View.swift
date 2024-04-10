import UIKit

class View: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
        localizeInterface()
        setupAutoLayout()
        setupActionHandlers()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func setupAppearance() {
        
    }
    
    func setupAutoLayout() {
        
    }
    
    func localizeInterface() {
        
    }
    
    func setupActionHandlers() {
        
    }
}
