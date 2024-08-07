import SwiftUI

struct LegacyTextField: UIViewRepresentable {
    @Binding var text: String
    let configuration: (UITextField) -> Void
    let onSubmit: () -> Void

    func makeUIView(context: Context) -> UITextField {
        let view = TextField(configuration: configuration)
        view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        view.addTarget(context.coordinator, action: #selector(Coordinator.textFieldTextDidChange), for: .editingChanged)
        view.delegate = context.coordinator
        return view
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text, onSubmit: onSubmit)
    }

    final class Coordinator: NSObject, UITextFieldDelegate {
        var text: Binding<String>
        let onSubmit: () -> Void

        init(text: Binding<String>, onSubmit: @escaping () -> Void) {
            self.text = text
            self.onSubmit = onSubmit
        }

        @objc func textFieldTextDidChange(_ textField: UITextField) {
            text.wrappedValue = textField.text ?? ""
        }

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            onSubmit()
            return false
        }
    }

    private final class TextField: UITextField {

        let configuration: (UITextField) -> Void

        init(configuration: @escaping (UITextField) -> Void) {
            self.configuration = configuration
            super.init(frame: .zero)
        }

        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func didMoveToWindow() {
            super.didMoveToWindow()
            if window != nil {
                configuration(self)
            }
        }
    }
}
