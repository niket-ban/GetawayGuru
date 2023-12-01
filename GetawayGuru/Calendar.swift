import Foundation
import SwiftUI

struct Calendar: View {
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
                    Text("Calendar")
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
                
                Spacer()
                
                
            }
        }
        .ignoresSafeArea()
    }
}


#Preview {
    Calendar()
}

