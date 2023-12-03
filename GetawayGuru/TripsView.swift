//
//  TripsView.swift
//  GetawayGuru
//
//  Created by Ankita Suresh Shanbhag on 12/3/23.
//

import SwiftUI

struct TripsView: View {
    var tripName: String
    var dates: [Date]
    var notes: [Date: String]

    var body: some View {
        VStack {
            Text(tripName)
                .font(.largeTitle)
                .padding()

            List(dates, id: \.self) { date in
                VStack(alignment: .leading) {
                    Text("Day \((dates.firstIndex(of: date) ?? 0) + 1): \(date.formatted(date: .abbreviated, time: .omitted))")
                    Text(notes[date] ?? "")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

struct TripsView_Previews: PreviewProvider {
    static var previews: some View {
        TripsView(tripName: "Sample Trip", dates: [Date()], notes: [Date(): "Sample Note"])
    }
}


