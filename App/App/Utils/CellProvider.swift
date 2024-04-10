import UIKit

protocol CellProvider {
    associatedtype Item
    
    func create() -> (UITableView, IndexPath, Item) -> UITableViewCell?
}
