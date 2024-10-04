import Observation
import Foundation

@Observable
final class TabState {

    var selectedTab: TabItem = .users {
        didSet {
            if selectedTab == oldValue {
                shouldPopToRoot.removeAll()
                shouldPopToRoot[selectedTab] = UUID()
            }
        }
    }

    var shouldPopToRoot = [TabItem: UUID]()
}
