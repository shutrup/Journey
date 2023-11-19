//
//  FilterDataPicker.swift
//  Journey
//
//  Created by Шарап Бамматов on 19.11.2023.
//

import SwiftUI

struct FilterDataPicker: View {
    @Binding var selectedDate: Date
    @State var date: Date? = nil
    let placeholder: String
    
    var body: some View {
        Button {
        } label: {
            HStack {
                Image(.date)
                
                if let date = date?.isRuFormat {
                    Text(date)
                        .font(.ptSansRegular(size: 14))
                        .foregroundStyle(Color.filterColor)
                } else {
                    Text(placeholder)
                        .font(.ptSansRegular(size: 14))
                        .foregroundStyle(Color.filterColor)
                }
                    
                
                Spacer()
            }
            .padding(.leading, 13)
            .padding(.vertical, 12)
            .frame(width: 135)
            .foregroundStyle(Color.filterColor)
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(lineWidth: 0.5)
                    .fill(.black.opacity(0.2))
            }
        }
        .overlay {
            DatePicker(selection: $selectedDate, displayedComponents: .date) {}
                .labelsHidden()
                .padding(25)
                .contentShape(Rectangle())
                .opacity(0.011)
        }
        .onChange(of: selectedDate) { oldValue, newValue in
            date = newValue
        }
    }
}

#Preview {
    FilterDataPicker(selectedDate: .constant(.now), placeholder: "От")
}
