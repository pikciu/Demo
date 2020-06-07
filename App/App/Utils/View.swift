import UIKit

class View: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupAutoLayout()
        localizeInterface()
        setupAppearance()
        setupActionHandlers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupAppearance() {
        
    }
    
    func setupAutoLayout() {
        
    }
    
    func localizeInterface() {
        
    }
    
    func setupActionHandlers() {
        
    }
    
    func attach(to viewController: UIViewController) {
        viewController.view.add(subviews: self)
        
        activate(
            topAnchor.constraint(equalTo: viewController.view.topAnchor),
            bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor),
            leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
            trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor)
        )
    }
}
