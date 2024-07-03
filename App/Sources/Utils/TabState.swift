import Combine
import Foundation

final class TabState: ObservableObject {

    @Published var selectedTab: TabItem = .users {
        didSet {
            if selectedTab == oldValue {
                shouldPopToRoot.removeAll()
                shouldPopToRoot[selectedTab] = UUID()
            }
        }
    }

    @Published var shouldPopToRoot = [TabItem: UUID]()
}
