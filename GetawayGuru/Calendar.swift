//  TripsView.swift
//  GetawayGuru
//
//  Created by Ankita Suresh Shanbhag on 12/1/23.
//
import Foundation
import SwiftUI

struct CalendarView: View {
    
@Environment(\.presentationMode) var presentationMode
let email: String
let ggblue = Color(red: 0.4627, green: 0.8392, blue: 1.0)
let llblue = Color(red: 218/255, green: 244/255, blue: 255/255)
@State private var selectedDates: Set<DateComponents> = []
@State private var formattedDates: [Date] = []
@State private var notes: [Date: String] = [:]
@State private var editingDate: Date?
@State private var tripName: String = ""
@State private var showTripsView = false
@State private var showAlert = false
@State private var destination: String = ""
let formatter = DateFormatter()
    
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
                
                ScrollView {
                    TextField("Trip Name", text: $tripName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    TextField("Destination", text: $destination)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    VStack {
                        MultiDatePicker("Single/Multiple Date Picker", selection: $selectedDates)
                        
                        Button(action: {
                            formatSelectedDates()
                        }, label: {
                            Text("Confirm Dates")
                                .font(.title3)
                        })
                        
                        ForEach(formattedDates, id: \.self) { date in
                            HStack {
                                Text("Day \((formattedDates.firstIndex(of: date) ?? 0) + 1): \(date.formatted(date: .abbreviated, time: .omitted))")
                                    .foregroundColor(.black)
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 10)
                                        .fill(llblue))
                                    .padding(4)
                                
                                Spacer()
                                
                                Button(action: {
                                    editingDate = editingDate == date ? nil : date // Toggle the editing state
                                }) {
                                    Image(systemName: "plus.circle")
                                        .foregroundColor(.black)
                                }
                            }
                            if editingDate == date {
                                TextField("Add notes here", text: Binding(
                                    get: { notes[date] ?? "" },
                                    set: { notes[date] = $0 }
                                ))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                            }
                        }
                    }
                }
                Button("Save Trip") {
                    if tripName.isEmpty {
                        showAlert = true
                    } else {
                        let newTrip = Trip(
                            location: destination,
                            totalBudget: nil,
                            BudgetSpent: nil,
                            FoodBudget: nil,
                            FoodBudgetSpent: nil,
                            GasBudget: nil,
                            GasBudgetSpent: nil,
                            HotelBudget: nil,
                            HotelBudgetSpent: nil,
                            startdates: formattedDates,
                            notes:notes
//                            tripName:"nil"
                        )

                        setTrip(email: email, trip: newTrip)
                        
                        // Dismiss the current view
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(llblue))
                .padding()
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Name the Trip"),
                message: Text("Please enter a name for the trip before saving."),
                dismissButton: .default(Text("OK"))
            )
        }
        .ignoresSafeArea()
    }
    private func formatSelectedDates() {
            formattedDates = selectedDates
                .compactMap { Calendar.current.date(from: $0) }
                .sorted()
        }
}


#Preview {
    CalendarView(email: email)
}
