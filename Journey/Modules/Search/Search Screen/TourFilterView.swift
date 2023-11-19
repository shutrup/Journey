import SwiftUI

struct TourFilterView: View {
    @State var toDate: Date = .now
    @State var fromDate: Date = .now
    
    var body: some View {
        VStack {
            filterHeader
            
            HStack {
                FilterDataPicker(selectedDate: $toDate, placeholder: "От")
                
                Spacer()
                
                FilterDataPicker(selectedDate: $fromDate, placeholder: "До")
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
    TourFilterView()
}

extension TourFilterView {
    private var filterHeader: some View {
        HStack {
            Text("Фильтры")
                .font(.ptSansBold(size: 16))
                .foregroundStyle(.black)
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "xmark")
                    .foregroundStyle(.black)
                    .imageScale(.medium)
                    .bold()
            }
        }
        .padding(.top, 23)
    }
}
