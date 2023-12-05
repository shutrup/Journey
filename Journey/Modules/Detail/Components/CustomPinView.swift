
import SwiftUI

struct CustomPinView: View {
    var imageName: String
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFill()
            .frame(width: 100, height: 100)
            .shadow(radius: 3)
    }
}
