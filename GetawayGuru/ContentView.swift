//
//  ContentView.swift
//  GetawayGuru
//
//  Created by Niket Bansal on 11/21/23.
//

import SwiftUI

class Trip{
    var location: String?
    var totalBudget = 0
    var BudgetSpent = 0
    var FoodBudget = 0
    var FoodBudgetSpent = 0
    var GasBudget = 0
    var GasBudgetSpent = 0
    var HotelBudget = 0
    var HotelBudgetSpent = 0
}


struct ContentView: View {
    let ggblue = Color(red: 0.4627, green: 0.8392, blue: 1.0)
    var body: some View {
        WelcomeView()
    }
}

struct WelcomeView: View {
    @State private var isPresented = false
    var body: some View {
        let ggblue = Color(red: 0.4627, green: 0.8392, blue: 1.0)
        NavigationStack{
            ZStack{
                Rectangle()
                    .foregroundStyle(ggblue)
                    .frame(height: 900)
                VStack {
                    Spacer()
                        .frame(height:200)
                    HStack{
                        Image("Travel symbols 1")
                            .frame(width:100, height:100)
                        Spacer()
                            .frame(width: 40)
                        Text("GetawayGuru")
                            .font(.title)
                            .foregroundStyle(.white)
                    }
                    Spacer()
                        .frame(height: 250)
                    Button(action: {
                        isPresented = true
                    }, label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 15.0)
                                .frame(width: 175, height: 58)
                                .foregroundStyle(.white)
                            
                            Text("Continue")
                                .foregroundStyle(.black)
                        }
                        
                    })
                    .navigationDestination(isPresented: $isPresented){
                        LogInView()
                    }
                }
                .padding()
            }
        }
    }
}

struct LogInView: View {
    var body: some View {
        let ggblue = Color(red: 0.4627, green: 0.8392, blue: 1.0)
        @State var username: String = ""
        @State var password: String = ""
        NavigationStack{
            ZStack{
                Rectangle()
                    .foregroundStyle(ggblue)
                    .frame(height: 950)
                VStack{
                    HStack{
                        Image("Travel symbols 1")
                            .frame(width:100, height:100)
                        Spacer()
                            .frame(width: 40)
                        Text("GetawayGuru")
                            .font(.title)
                            .foregroundStyle(.white)
                    }
                    Spacer()
                        .frame(height: 150)
                    TextField(
                        "Username",
                        text: $username
                    )
                    .frame(width: 336)
                    TextField(
                        "Password",
                        text: $password
                    )
                    .frame(width:336)
                    Spacer()
                        .frame(height: 120)
                    Button(action: {
                    }, label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 15.0)
                                .frame(width: 175, height: 58)
                                .foregroundStyle(.white)
                            Text("Sign Up")
                                .foregroundStyle(.black)
                        }
                    })
                    Button(action: {
                    }, label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 15.0)
                                .frame(width: 175, height: 58)
                                .foregroundStyle(.white)
                            Text("Log In")
                                .foregroundStyle(.black)
                        }
                    })
                }
                .textFieldStyle(.roundedBorder)
            }
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
//    LogInView()
    ContentView()
}
