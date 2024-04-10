import UIKit

class ViewController<V: UIView>: UIViewController {
    
    private(set) lazy var ui = V()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        view = ui
    }
}
