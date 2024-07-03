import Domain
import Resources
import SwiftUI

struct UsersView: View {

    @StateObject var viewModel: UsersViewModel
    @EnvironmentObject var navigation: Navigation
    @State var selectedUser: User?

    var body: some View {
        List(viewModel.users, id: \.self, selection: $selectedUser) { user in
            UserView(user: user)
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button(role: .destructive) {
                        viewModel.delete(user: user)
                    } label: {
                        Image.symbol(.trash)
                    }
                }
        }
        .onChange(of: selectedUser) { user in
            if let user {
                navigation.push(.repos(user))
                selectedUser = nil
            }
        }
        .popup(isPresented: $viewModel.isEditing) {
            AddUserView(text: $viewModel.text, isError: viewModel.isError) {
                await viewModel.addUser()
            }
        }
        .navigationTitle(Text(.localizable.users))
        .toolbar {
            Button {
                viewModel.isEditing = true
            } label: {
                Image(symbol: .plus)
            }
        }
    }
}
