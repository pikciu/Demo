import SwiftUI

public struct Symbol {

    public let name: String

    public var image: Image {
        Image(systemName: name)
    }

    public var fill: Symbol {
        Symbol(name: "\(name).fill")
    }

    public static var person2 = Symbol(name: "person.2")
    public static var heart = Symbol(name: "heart")
    public static var star = Symbol(name: "star")
    public static var branch = Symbol(name: "arrow.triangle.branch")
    public static var eye = Symbol(name: "eye")
    public static var plus = Symbol(name: "plus")
    public static var trash = Symbol(name: "trash")
}

extension Image {

    public init(symbol: Symbol) {
        self.init(systemName: symbol.name)
    }

    public static func symbol(_ symbol: Symbol) -> Image {
        symbol.image
    }
}

extension String {

    public static func symbol(_ symbol: Symbol) -> String {
        symbol.name
    }
}
