//
//  ContentView.swift
//  GetawayGuru
//
//  Created by Niket Bansal on 11/21/23.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

let db = Firestore.firestore()
var email = ""

struct Trip: Codable{
    var location: String
    var totalBudget: Int?
    var BudgetSpent: Int?
    var FoodBudget: Int?
    var FoodBudgetSpent: Int?
    var GasBudget: Int?
    var GasBudgetSpent: Int?
    var HotelBudget: Int?
    var HotelBudgetSpent: Int?
}

func signUpWithEmailPassword(email: String, password: String) async -> Bool {
    do {
        try await Auth.auth().createUser(withEmail: email, password: password)
        return true
    }
    catch {
        print(error)
        return false
    }
}

func signInWithEmailPassword(email: String, password: String) async -> Bool {
    do {
        try await Auth.auth().signIn(withEmail: email, password: password)
        return true
    }
    catch {
        print(error)
        return false
    }
}

func signOut(){
    do {
        try Auth.auth().signOut()
    }
    catch {
        print(error)
    }
}

func setTrip(email: String, trip: Trip){
    do{
        try db.collection(email).document(trip.location).setData(from: trip)
    } catch let error {
        print("error \(error)")
    }
}

func getTrip(email: String, location: String) async -> Trip {
    let collectionRef = db.collection(email).document(location)

    do {
        let documentsSnapshot = try await collectionRef.getDocument(as: Trip.self)
        return documentsSnapshot
    } catch {
        print("Error fetching document names: \(error.localizedDescription)")
        return Trip(location: "fail get")
    }
}

func getAllTripsNames(email: String) async -> [String] {
    let collectionRef = db.collection(email)

    do {
        let documentsSnapshot = try await collectionRef.getDocuments()
        let documentNames = documentsSnapshot.documents.compactMap { $0.documentID }
        return documentNames
    } catch {
        print("Error fetching document names: \(error.localizedDescription)")
        return []
    }
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
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isPresented = false
    var body: some View {
        let ggblue = Color(red: 0.4627, green: 0.8392, blue: 1.0)
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
                        "Email",
                        text: $username
                    )
                    .frame(width: 336)
                    SecureField(
                        "Password",
                        text: $password
                    )
                    .frame(width:336)
                    Spacer()
                        .frame(height: 120)
                    Button(action: {
                        Task {
                            await signUpWithEmailPassword(email: username, password: password)
                        }
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
                        Task{
                            await isPresented = signInWithEmailPassword(email:username, password:password)
                            email = username.lowercased()
                        }
                        
                    }, label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 15.0)
                                .frame(width: 175, height: 58)
                                .foregroundStyle(.white)
                            Text("Log In")
                                .foregroundStyle(.black)
                        }
                    })
                    .navigationDestination(isPresented: $isPresented){
                        ProfileView()
                    }
                }
                .textFieldStyle(.roundedBorder)
            }
        }.navigationBarBackButtonHidden(true)
    }
}

struct ProfileView: View {
    @State private var isLoginPresented = false
    @State private var isCalendarPresented = false //Calendar
    @State private var locations: [String] = []
    @State private var isNavPresented = false
    var body: some View {
        let ggblue = Color(red: 0.4627, green: 0.8392, blue: 1.0)
        NavigationStack{
            ZStack{
                VStack{
                    HStack{
                        //profile header
                        Image("image 5")
                            .frame(width:100, height:100)
                        Text("My Profile")
                            .font(.largeTitle)
                            .foregroundStyle(ggblue)
                        Spacer()
                            .frame(width: 10)
                        VStack{
                            Spacer()
                                .frame(height: 70)
                            Button(action: {
                                signOut()
                                isLoginPresented = true
                            }, label: {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 15.0)
                                        .frame(width: 105, height: 27)
                                        .foregroundStyle(ggblue)
                                    Text("Log Out")
                                        .foregroundStyle(.white)
                                }
                            })
                            .navigationDestination(isPresented: $isLoginPresented){
                                LogInView()
                            }
                        }
                    }
                    Spacer()
                        .frame(height: 50)
                    HStack{
                        Spacer()
                            .frame(width: 15)
                        Text("My Trips")
                            .font(.largeTitle)
                            .foregroundStyle(ggblue)

                        Spacer()
                    }

                    List(locations, id:\.self){ loc in
                        NavigationLink(destination: NavView(location: loc)) {
                            Text(loc)
                        }
                    }
//                  Create New Trips
                    Button(action: {
//                        let trip = Trip(location: "beep")
//                        setTrip(email: email, trip: trip)
                        
                        isCalendarPresented = true
                    }) {
                        HStack{
                            ZStack {
                                Circle()
                                    .foregroundColor(ggblue)
                                    .frame(width: 60, height: 60)
                                Image(systemName: "plus")
                                    .foregroundColor(.white)
                                    .font(.largeTitle)
                            }
                            Text("Add")
                                .foregroundColor(ggblue)
                                .font(.title)
                        }
                    }
                    .padding()
                    .sheet(isPresented: $isCalendarPresented) {
                         CalendarView()
                    }

                    //trip links
                    
                    Spacer()
                }
            }
        }.navigationBarBackButtonHidden(true)
            .task {
                await locations = getAllTripsNames(email: email)
            }
    }
}

struct NavView: View {
    var location: String
    @State var trip: Trip = Trip(location: "trip")
    var body: some View {
        let ggblue = Color(red: 0.4627, green: 0.8392, blue: 1.0)
        NavigationStack{
            ZStack{
                Rectangle()
                    .foregroundStyle(ggblue)
                    .frame(height: 950)
                VStack{
                    Text(trip.location)
                        .font(.largeTitle).bold()
                    Spacer()
                        .frame(height: 300)
                    Button(action: {
                    }, label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 15.0)
                                .frame(width: 293, height: 62)
                                .foregroundStyle(.white)
                            Text("Expenses")
                                .foregroundStyle(.black)
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        }
                    })
                    Button(action: {
                    }, label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 15.0)
                                .frame(width: 293, height: 62)
                                .foregroundStyle(.white)
                            Text("Preparation Items")
                                .foregroundStyle(.black)
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        }
                    })
                    Button(action: {
                    }, label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 15.0)
                                .frame(width: 293, height: 62)
                                .foregroundStyle(.white)
                            Text("Calendar")
                                .foregroundStyle(.black)
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        }
                    })
                    
                }
            }
        }
        .task {
            await trip = getTrip(email: email, location: location)
        }
//        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
//    ProfileView()
//    LogInView()
//    NavView(trip: Trip(location: "Kelp"))
    ContentView()
}
