import SwiftUI

struct FilterPricePicker: View {
    @Binding var numberText: String
    let placeholder: String
    
    var body: some View {
        HStack {
            Image(.ruble)
            
            TextField(placeholder, text: $numberText)
                .font(.ptSansRegular(size: 14))
                .foregroundStyle(Color.filterColor)
                .keyboardType(.numberPad)
                .onReceive(numberText.publisher.collect()) {
                    let filtered = String($0).filter { "0123456789".contains($0) }
                    if filtered.count > 7 {
                        numberText = String(filtered.prefix(7))
                    } else if filtered.hasPrefix("0") && filtered.count > 1 {
                        numberText = String(filtered.dropFirst())
                    } else {
                        numberText = filtered
                    }
                }
            
            Spacer()
        }
        .modifier(FilterModifier())
    }
}

#Preview {
    FilterPricePicker(numberText: .constant(""), placeholder: "От")
}
