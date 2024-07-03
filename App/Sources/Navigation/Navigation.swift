import Combine

final class Navigation: ObservableObject {
    @Published var stack = [AppRoute]()

    func push(_ route: AppRoute) {
        stack.append(route)
    }

    func popToRoot() {
        stack.removeAll()
    }
}
