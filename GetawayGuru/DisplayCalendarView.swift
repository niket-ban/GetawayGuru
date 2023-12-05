//
//  DisplayCalendarView.swift
//  GetawayGuru
//
//  Created by Ankita Suresh Shanbhag on 12/4/23.


import Foundation
import SwiftUI

struct DisplayCalendarView: View {
    var email: String
    var trip: Trip
    let ggblue = Color(red: 0.4627, green: 0.8392, blue: 1.0)

    var body: some View {
        ZStack {
            ggblue.edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                if let startdates = trip.startdates, !startdates.isEmpty {
                    ForEach(startdates, id: \.self) { date in
                        VStack(alignment: .leading) {
                            Text("Date: \(date.formatted(date: .long, time: .omitted))")
                                .font(.headline)
                            
                            if let note = trip.notes?[date] {
                                Text("Note: \(note)")
                                    .font(.subheadline)
                            } else {
                                Text("No note for this date")
                                    .font(.subheadline)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    }
                } else {
                    Text("No dates available")
                        .font(.headline)
                }

                Spacer()
            }
            .padding(.horizontal)
        }
        .navigationTitle(trip.location + " Calendar")
    }
}

extension DisplayCalendarView {
    static var exampleTrip: Trip {
        Trip(location: "Example Location",
             startdates: [Date()],
             notes: [Date(): "Example Note"])
    }
}

struct DisplayCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayCalendarView(email: "example@example.com", trip: DisplayCalendarView.exampleTrip)
    }
}


