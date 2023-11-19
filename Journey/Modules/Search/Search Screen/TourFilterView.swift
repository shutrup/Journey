import SwiftUI

struct TourFilterView: View {
    @Binding var show: Bool
    @State var toDate: Date = .now
    @State var fromDate: Date = .now
    
    @State var toPrice = String()
    @State var fromPrice = String()
    
    var body: some View {
        VStack(spacing: 16) {
            filterHeader
            
            VStack(spacing: 10) {
                HStack(spacing: 12) {
                    FilterDataPicker(selectedDate: $toDate, placeholder: "От")
                    
                    FilterDataPicker(selectedDate: $fromDate, placeholder: "До")
                }
                
                HStack(spacing: 12) {
                    FilterPricePicker(numberText: $toPrice, placeholder: "От")
                    
                    FilterPricePicker(numberText: $fromPrice, placeholder: "До")
                }
                
                placePicker
                
                groupSizePicker
                
                Spacer()
                
                
                Button {
                    
                } label: {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.tabColor)
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .overlay {
                            Text("Поиск")
                                .font(.ptSansBold(size: 16))
                                .foregroundStyle(.white)
                        }
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .frame(width: UIScreen.main.bounds.width - 60, height: UIScreen.main.bounds.height / 2.24, alignment: .center)
        .background {
            RoundedRectangle(cornerRadius: 32)
                .fill(.white)
                .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 0)
        }
    }
}

#Preview {
    TourFilterView(show: .constant(true))
}

extension TourFilterView {
    private var filterHeader: some View {
        HStack {
            Text("Фильтры")
                .font(.ptSansBold(size: 16))
                .foregroundStyle(.black)
            
            Spacer()
            
            Button {
                withAnimation {
                    show = false
                }
            } label: {
                Image(systemName: "xmark")
                    .foregroundStyle(.black)
                    .imageScale(.medium)
                    .bold()
            }
        }
        .padding(.top, 23)
    }
    private var placePicker: some View {
        VStack {
            HStack {
                Image(.location)
                
                Text("Место")
                    .font(.ptSansRegular(size: 14))
                    .foregroundStyle(Color.filterColor)
                
                Spacer()
            }
            .modifier(FilterModifier())
        }
    }
    private var groupSizePicker: some View {
        VStack {
            HStack {
                Image(.people)
                
                Text("Численность группы / 1 минимум")
                    .font(.ptSansRegular(size: 14))
                    .foregroundStyle(Color.filterColor)
                
                Spacer()
            }
            .modifier(FilterModifier())
        }
    }
}
