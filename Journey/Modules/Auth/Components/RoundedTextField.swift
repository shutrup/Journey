import SwiftUI

struct RoundedTextField: View {
    var placeholder: String
    @Binding var text: String
    var imageName = String()
    var isSecure = false
    var isCapitalization = false
    var imageColor: Color = .primary
    @State private var isSecured = true
    @State private var hideTitle = false
    var isImageVisible = true
    
    var body: some View {
        ZStack {
            TextField(NSLocalizedString(placeholder, comment: "placeholder for TextField"), text: $text)
                .opacity(isSecured ? 0 : 1)
            
            SecureField(NSLocalizedString(placeholder, comment: "placeholder for TextField"), text: $text)
                .opacity(isSecured ? 1 : 0)
        }
        .font(.system(size: 14))
        .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 45))
        .textFieldStyle(.plain)
        .keyboardType(isSecure ? .alphabet : .default)
        .autocapitalization(isCapitalization ? .sentences : .none)
        .disableAutocorrection(isSecure)
        .frame(width: UIScreen.main.bounds.width - 32, height: 54)
        .background((hideTitle ? Color.white : Color.white).cornerRadius(16))
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
        .overlay(
            Image(systemName: isSecure ? (isSecured ? "eye.fill" : "eye.slash.fill") : imageName)
                .foregroundColor(imageColor)
                .padding()
                .onTapGesture {
                    guard isSecure else {
                        return
                    }
                    
                    isSecured.toggle()
                },
            alignment: .trailing
        )
        .onChange(of: text) {
            hideTitle = !$0.isEmpty
        }
        .onAppear {
            isSecured = isSecure
        }
    }
}

#Preview {
    RoundedTextField(placeholder: "Почта", text: .constant(""))
}
