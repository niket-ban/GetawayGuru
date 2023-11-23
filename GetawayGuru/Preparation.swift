//
//  Preparation.swift
//  GetawayGuru
//
//  Created by Jonathan Saleh on 11/22/23.
//

import Foundation
import SwiftUI

struct Preparation: View {
let ggblue = Color(red: 0.4627, green: 0.8392, blue: 1.0)
    var body: some View{
        ZStack{
            ggblue
            VStack {
                HStack{
                    Spacer()
                    Button(action:{
                    }) {
                        Image(systemName: "text.justify")
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                    }
                     Spacer()
                    Text("Preparation")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(20)
                    Spacer()
                    Button(action:{
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                    }
                    Spacer()
                    
                }
                .padding(.top, 40)

                RectangleSelector()
                RectangleSelector()
                RectangleSelector()
                
                Spacer()
                
                
            }
        }
        .ignoresSafeArea()
    }
}

struct RectangleSelector: View {
    let ggblue = Color(red: 0.4627, green: 0.8392, blue: 1.0)
    var body: some View{
        Rectangle()
            .foregroundStyle(.white)
            .frame(width: 300, height: 80)
            .shadow(radius: 5)
            .cornerRadius(10)
            .padding()
            .overlay(
                HStack{
                    Text("Item 1")
                        .foregroundColor(ggblue)
                        .frame(maxWidth: 250)
                    Button(action:{
                    }) {
                        Image(systemName: "chevron.right")
                            .foregroundColor(.black)
                    }
                }
            )
    }
}
#Preview {
    Preparation()
}
