import Foundation

public protocol UseCase {
    associatedtype Result
    
    func execute() -> Result
}
