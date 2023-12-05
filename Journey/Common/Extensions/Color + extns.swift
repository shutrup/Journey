import SwiftUI

extension Color {
    static var tabColor: Color {
        return Color("TabColor")
    }
    static var filterColor: Color {
        return Color("FilterColor")
    }
    static var detailGrayColor: Color {
        return Color("DetailGrayColor")
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
}
