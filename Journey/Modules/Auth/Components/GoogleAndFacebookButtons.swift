//
//  GoogleAndFacebookButtons.swift
//  Journey
//
//  Created by Шарап Бамматов on 14.11.2023.
//

import SwiftUI

struct GoogleAndFacebookButtons: View {
    let googleAction: () -> ()
    let facebookAction: () -> ()
    
    var body: some View {
        VStack {
            Text("Или")
                .font(.rubikRegular(size: 18))
                .foregroundStyle(.white)
            
            HStack(spacing: 20) {
                Button {
                    googleAction()
                } label: {
                    RoundedRectangle(cornerRadius: 23)
                        .fill(.white)
                        .frame(width: 60, height: 60)
                        .overlay {
                            Image("googleIcon")
                                .resizable()
                                .frame(width: 36, height: 36)
                        }
                }
                
                Button {
                    facebookAction()
                } label: {
                    RoundedRectangle(cornerRadius: 23)
                        .fill(.white)
                        .frame(width: 60, height: 60)
                        .overlay {
                            Image("facebookIcon")
                                .resizable()
                                .frame(width: 24, height: 30)
                        }
                }
            }
        }
        .padding(.bottom, 20)
    }
}

#Preview {
    GoogleAndFacebookButtons(googleAction: {}, facebookAction: {})
}
