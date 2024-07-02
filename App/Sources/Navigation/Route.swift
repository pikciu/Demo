import SwiftUI

protocol Route: Hashable {
    associatedtype Destination
    
    @ViewBuilder @MainActor var destination: Destination { get }
}
