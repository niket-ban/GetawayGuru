import Foundation
import SwiftUI

struct CalendarView: View {
    
let ggblue = Color(red: 0.4627, green: 0.8392, blue: 1.0)
let llblue = Color(red: 218/255, green: 244/255, blue: 255/255)
@State private var selectedDates: Set<DateComponents> = []
@State private var formattedDates: [String] = []
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
                VStack {
                    MultiDatePicker("Single/Multiple Date Picker", selection: $selectedDates)

                    Button(action: {
                        formatSelectedDates()
                    }, label: {
                        Text("OK")
                            .font(.title3)
                    })
                    

                    ForEach(formattedDates, id: \.self) { date in
                        Text(date)
                            .foregroundColor(.black)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10)
                                            .fill(llblue))
                            .padding(4)
                    }
                }
                .padding()
            }
        }
        .ignoresSafeArea()
    }
    private func formatSelectedDates() {
            let sortedDates = selectedDates
                .compactMap { Calendar.current.date(from: $0) }
                .sorted()

            formattedDates = sortedDates.enumerated().map { (index, date) in
                "Day \(index + 1): \(date.formatted(date: .abbreviated, time: .omitted))"
            }
        }
}


#Preview {
    CalendarView()
}

