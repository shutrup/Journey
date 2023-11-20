import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
    @Environment(\.dismiss) var dismiss
    @State private var isFavorite = Bool()
    @State var selectedImage: String? = nil
    
    @State var images: [String] = [
        "https://laguna-gunib.ru/images/3ddefe47aa74d485f1670a8147281672cfa4cd9b-DLIlcCM.jpg",
        "https://2spalnika.ru/wp-content/uploads/2022/12/sulakskiy-kanion-800x600.jpg",
        "https://2spalnika.ru/wp-content/uploads/2022/12/sulakskiy-kanion-800x600.jpg",
        "https://laguna-gunib.ru/images/3ddefe47aa74d485f1670a8147281672cfa4cd9b-DLIlcCM.jpg",
        "https://laguna-gunib.ru/images/3ddefe47aa74d485f1670a8147281672cfa4cd9b-DLIlcCM.jpg",
        "https://laguna-gunib.ru/images/3ddefe47aa74d485f1670a8147281672cfa4cd9b-DLIlcCM.jpg",
        "https://laguna-gunib.ru/images/3ddefe47aa74d485f1670a8147281672cfa4cd9b-DLIlcCM.jpg"
    ]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                if let image = selectedImage {
                    WebImage(url: URL(string: image)!)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.78)
                        .clipShape(RoundedRectangle(cornerRadius: 32))
                        .overlay(alignment: .top) {
                            headerButtonsImage
                        }
                        .overlay(alignment: .bottom) {
                            footerImagePicker
                        }
                }
                
                VStack(spacing: 20) {
                    detailDescription
                    
                    detailDescriptionCards
                    
                    detailOptions
                }
            }
        }
        .ignoresSafeArea()
        .onAppear {
            selectedImage = images[0]
        }
    }
}

#Preview {
    DetailView()
}

extension DetailView {
    private var headerButtonsImage: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Circle()
                    .fill(.white)
                    .frame(width: 36, height: 36)
                    .shadow(color: .black.opacity(0.15), radius: 5, x: 0, y: 0)
                    .zIndex(1.0)
                    .overlay {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.black)
                    }
            }
            
            Spacer()
            
            Button {
                isFavorite.toggle()
            } label: {
                Circle()
                    .fill(.white)
                    .frame(width: 36, height: 36)
                    .shadow(color: .black.opacity(0.15), radius: 5, x: 0, y: 0)
                    .zIndex(1.0)
                    .overlay {
                        Image(.bookmark)
                            .foregroundStyle(isFavorite ? Color.tabColor : .black)
                    }
                    .animation(.smooth, value: isFavorite)
            }
        }
        .padding(.horizontal)
        .padding(.top, 60)
    }
    private var footerImagePicker: some View {
        HStack(alignment: .top, spacing: 8) {
            ForEach(images.prefix(3), id: \.self) { image in
                WebImage(url: URL(string: image)!)
                    .resizable()
                    .frame(width: 54, height: 54)
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .clipped()
                    .overlay {
                        if selectedImage == image {
                            RoundedRectangle(cornerRadius: 16)
                                .inset(by: 0.5)
                                .stroke(Color.tabColor, lineWidth: 2)
                        }
                    }
                    .onTapGesture {
                        selectedImage = image
                    }
            }
            
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.tabColor)
                .frame(width: 54, height: 54)
                .overlay {
                    Text("+\(images.count - 3)")
                        .font(.montserratMedium(size: 14))
                        .foregroundColor(.white)
                }
        }
        .padding(8)
        .frame(width: 256, height: 70, alignment: .top)
        .background(.white.opacity(0.7))
        .cornerRadius(16)
        .padding(.bottom, 12)
    }
    private var detailDescription: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("Cулакский каньон")
                .font(.ptSansBold(size: 24))
                .foregroundColor(.black)
            
            HStack(spacing: 5) {
                Image(.location)
                    .resizable()
                    .frame(width: 16, height: 16)
                    .foregroundStyle(Color.tabColor)
                
                Text("Сулакский каньон")
                    .font(.ptSansRegular(size: 14))
                    .foregroundStyle(Color.detailGrayColor)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
    private var detailDescriptionCards: some View {
        HStack {
            DetailDescriptionCard(title: "Длительность")
                .overlay {
                    VStack(spacing: 0) {
                        Text("3 часа")
                            .font(.ptSansBold(size: 18))
                        
                        Text("30 мин")
                            .font(.ptSansRegular(size: 14))
                    }
                    .padding(.top)
                }
            
            Spacer()
            
            DetailDescriptionCard(title: "Мест")
                .overlay {
                    VStack(spacing: 0) {
                        Text("16")
                            .font(.ptSansBold(size: 18))
                    }
                    .padding(.top)
                }
            
            Spacer()
            
            DetailDescriptionCard(title: "Рейтинг")
                .overlay {
                    VStack(spacing: 0) {
                        HStack {
                            Text("4.2")
                                .font(.ptSansBold(size: 18))
                            
                            Image(.star)
                                .renderingMode(.original)
                                .resizable()
                                .frame(width: 16, height: 16)
                        }
                        
                        Text("234: отзыва")
                            .font(.ptSansRegular(size: 14))
                              .underline()
                    }
                    .foregroundColor(.black)
                    .padding(.top)
                }
        }
        .padding(.horizontal)
    }
    private var detailOptions: some View {
        VStack(alignment: .leading) {
            Text("Входит в тур")
                .font(.ptSansBold(size: 18))
                .foregroundColor(.black)
            
            ScrollView(.vertical, showsIndicators: false) {
                TagLayout(alignment: .leading, spacing: 10) {
                    ForEach(0..<5, id: \.self) { option in
                        DetailOptionsCell(image: "car", text: "транспорт")
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
}
