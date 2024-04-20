import SwiftUI
import Domain

struct UserView: View {
    
    let user: User
    
    var body: some View {
        HStack {
            AsyncImage(url: user.avatarURL) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)
            
            VStack(alignment: .leading) {
                Text(user.login)
                if let name = user.name {
                    Text(name)
                }
            }
        }
    }
}
