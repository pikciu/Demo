import UIKit

extension UIImage {
    
    public struct Symbol {
        let name: String
        
        public var fill: Symbol {
            Symbol(name: "\(name).fill")
        }
        
        public static var person2 = Symbol(name: "person.2")
        public static var heart = Symbol(name: "heart")
        public static var star = Symbol(name: "star")
        public static var branch = Symbol(name: "arrow.triangle.branch")
        public static var eye = Symbol(name: "eye")
            
    }
    
    public static func symbol(_ symbol: Symbol) -> UIImage? {
        UIImage(systemName: symbol.name)
    }
}
