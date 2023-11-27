import SwiftUI

struct TourFilterView: View {
    @EnvironmentObject var viewModel: SearchViewModel
    @Binding var show: Bool
    @State var toDate: Date = .now
    @State var fromDate: Date = .now
    
    @State var toPrice = String()
    @State var fromPrice = String()
    
    @State private var selectedPlace: String? = nil
    @State private var selectedGroupSize: String? = nil

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
                    Task {
                        await viewModel.filter(startDate: nil, endDate: nil, minPrice: toPrice, maxPrice: fromPrice, startCity: selectedPlace, groupSize: selectedGroupSize)
                        show.toggle()
                    }
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
        .environmentObject(SearchViewModel(tourDataService: TourDataService.tourDataService))
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
        Menu {
            if selectedPlace != nil {
                Button("Пусто", action: { selectedPlace = nil })
            }
            Button("Махачкала", action: { selectedPlace = "Махачкала" })
            Button("Дербент", action: { selectedPlace = "Дербент" })
        } label: {
            HStack {
                Image(systemName: "location")
                
                Text(selectedPlace ?? "Место")
                    .font(.ptSansRegular(size: 14))
                    .foregroundStyle(Color.filterColor)
                
                Spacer()
            }
            .modifier(FilterModifier())
        }
    }
    private var groupSizePicker: some View {
        Menu {
            if selectedGroupSize != nil {
                Button("Пусто", action: { selectedGroupSize = nil })
            }
            Button("1", action: { selectedGroupSize = "1" })
            Button("5", action: { selectedGroupSize = "5" })
            Button("10", action: { selectedGroupSize = "10" })
            Button("15", action: { selectedGroupSize = "15" })
            Button("20", action: { selectedGroupSize = "20" })
        } label: {
            VStack {
                HStack {
                    Image(.people)
                    
                    Text(selectedGroupSize ?? "Численность группы / 1 минимум")
                        .font(.ptSansRegular(size: 14))
                        .foregroundStyle(Color.filterColor)
                    
                    Spacer()
                }
                .modifier(FilterModifier())
            }
        }
    }
}
