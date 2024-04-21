import SwiftUI

extension View {
    
    func popup<PopupView: View>(
        isPresented: Binding<Bool>,
        popupView: @escaping () -> PopupView
    ) -> some View {
        modifier(PopupModifier(isPresented: isPresented, popupView: popupView))
    }
    
    fileprivate func clearBackground(didMoveToWindow: @escaping () -> Void) -> some View {
        background(ClearBackgroundView(didMoveToWindow: didMoveToWindow))
    }
}

struct PopupModifier<PopupView: View>: ViewModifier {
    
    @Binding private var isPresented: Bool
    private let popupView: () -> PopupView
    
    @State private var isFullScreenCoverPresented: Bool
    @State private var isContentPresented: Bool
    
    init(isPresented: Binding<Bool>, popupView: @escaping () -> PopupView) {
        self._isPresented = isPresented
        self.popupView = popupView
        self.isFullScreenCoverPresented = isPresented.wrappedValue
        self.isContentPresented = isPresented.wrappedValue
    }
    
    func body(content: Content) -> some View {
        content
            .onChange(of: isPresented) { newValue in
                if newValue {
                    isFullScreenCoverPresented = true
                } else {
                    isContentPresented = false
                }
            }
            .fullScreenCover(isPresented: $isFullScreenCoverPresented) {
                ZStack {
                    Color.black.opacity(isContentPresented ? 0.15 : 0)
                        .transition(.opacity)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation {
                                isContentPresented = false
                            }
                        }
                        .zIndex(0)
                    if isContentPresented {
                        popupView()
                            .onDisappear {
                                withoutAnimation {
                                    isFullScreenCoverPresented = false
                                    isPresented = false
                                }
                            }
                            .zIndex(1)
                    }
                }
                .clearBackground {
                    withAnimation {
                        isContentPresented = true
                    }
                }
            }
    }
}

private struct ClearBackgroundView: UIViewRepresentable {
    
    let didMoveToWindow: () -> Void
    
    func makeUIView(context: Context) -> UIView {
        let backgroundView = BackgroundView()
        backgroundView.action = didMoveToWindow
        return backgroundView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
    
    private class BackgroundView: UIView {
        
        var action: () -> Void = { }
        
        override func didMoveToWindow() {
            super.didMoveToWindow()
            
            superview?.superview?.backgroundColor = .clear
            superview?.superview?.layer.removeAllAnimations()
            if window != nil {
                action()
            }
        }
    }
}
