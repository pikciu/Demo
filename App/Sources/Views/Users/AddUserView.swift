import SwiftUI

struct AddUserView: View {
    
    @Binding var text: String
    let isError: Bool
    
    let onSubmit: () async -> Void
    
    var body: some View {
        VStack {
            Spacer() 
            VStack {
                VStack(alignment: .leading, spacing: 2) {
                    LegacyTextField(text: $text) { textField in
                        textField.returnKeyType = .search
                        textField.placeholder = String(localized: .localizable.username)
                        textField.overrideUserInterfaceStyle = .light
                        textField.becomeFirstResponder()
                    } onSubmit: {
                        Task {
                            await onSubmit()
                        }
                    }
                    .padding(8)
                    .background(textFieldBackground)
                    
                    Text(.localizable.userNotFound)
                        .font(.footnote)
                        .foregroundStyle(.red)
                        .opacity(isError ? 1 : 0)
                }
                .padding()
                .animation(.easeInOut(duration: 0.2), value: isError)
            }
            .background(.white)
            .clipShape(.rect(cornerRadii: RectangleCornerRadii(topLeading: 15, topTrailing: 15)))
        }
        .transition(.move(edge: .bottom))
    }
    
    @ViewBuilder
    private var textFieldBackground: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4).fill(.white)
            RoundedRectangle(cornerRadius: 4).stroke(lineWidth: 1).fill(isError ? .red : .gray)
        }
    }
}
