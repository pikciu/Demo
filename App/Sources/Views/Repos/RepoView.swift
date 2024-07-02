import SwiftUI
import Domain
import Resources

struct RepoView: View {
    
    let repo: RepoItem
    let toggleFavorite: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text(repo.name)
                HStack {
                    couter(symbol: .eye, count: repo.watchers)
                    couter(symbol: .branch, count: repo.forks)
                    couter(symbol: .star, count: repo.stars)
                }
                .frame(maxWidth: .infinity)
            }
            Button {
                toggleFavorite()
            } label: {
                repo.heartImage.image
            }
            .buttonStyle(.borderless)
        }
    }
    
    @ViewBuilder
    private func couter(symbol: Symbol, count: Int) -> some View {
        Text("\(symbol.image) \(count)")
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}
