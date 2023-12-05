//
//  Budget.swift
//  GetawayGuru
//
//  Created by Mahathi Ryali on 11/26/23.
//
import SwiftUI



struct Budget: View {
    @State private var isFoodExpenseEntryPresented = false
    @State private var isGasExpenseEntryPresented = false
    @State private var isHotelExpenseEntryPresented = false
    

    @State var myTrip: Trip
    let bgProgress = Color(red:0.9294117647058824, green:0.9294117647058824, blue: 0.9294117647058824)
    let fgProgress = Color(red: 0.43529411764705883, green: 0.8274509803921568, blue: 1)
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("☰")
                        .foregroundColor(.black)
                        .font(.system(size: 32))
                        
                })
                Spacer().frame(width:90)
                Text("Expenses").font(.system(size: 32))
                Spacer().frame(width:90)
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("+")
                        .foregroundColor(.black)
                        .font(.system(size: 32))
                })
            }
            HStack {
                Text(myTrip.location)
                    .font(Font.custom("JosefinSans", size: 32))
                Spacer().frame(width: 280)
            }
                
            HStack {
                if let unwrappedTotalLeft = myTrip.totalLeft {
                    Text("$\(unwrappedTotalLeft)")
                        .font(.system(size: 64))
                        .fontWeight(.semibold)
                }
                    
                Text("Left")
                    .fontWeight(.semibold)
                    .font(.system(size: 20))
                    .foregroundColor(.black)
                    .padding().frame(height:30)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.black, lineWidth: 5)
                    )
                
                Spacer().frame(width: 100)
                
            }
//            ProgressView(value: 0.5).frame(width: 250)
            HStack {
                if let totalBudget = myTrip.totalBudget {
                    if let totalSpent = myTrip.BudgetSpent {
                        let width = CGFloat(totalSpent * 341 / totalBudget)
                        RoundedRectangle(cornerRadius: 75.0).frame(width: 341, height: 25).foregroundColor(Color(red:0, green: 0.2784313725490196, blue:0.3686274509803922))
                            .overlay(
                                RoundedRectangle(cornerRadius: 75.0)
                                    .frame(width: width, height: 25)
                                    .offset(x: -(341 - width) / 2, y: 0).foregroundColor(Color(red:0, green: 0.6392156862745098, blue:1)))
                    }
                }
                Spacer().frame(width: 20)
            }
            HStack {
                if let totalBudget = myTrip.totalBudget {
                    if let totalSpent = myTrip.BudgetSpent {
                        Text("$\(totalSpent) of $\(totalBudget) spent")
                    }
                }
                Spacer().frame(width: 160)
            }
                .font(.system(size: 20))
            Spacer()
        }.frame(width:900, height: 300)
            .background(Color(red: 0.6627450980392157, green: 0.8980392156862745, blue: 1.0))
        Spacer()
            VStack {
                VStack {
                    HStack {
                        Image("FoodIcon")
                            .resizable()
                            .frame(width: 40.0, height: 40)
                        Text("Food")
                            .font(.system(size: 32))
                        Spacer().frame(width:200)
                        Button(action: {isFoodExpenseEntryPresented.toggle()}, label: {
                            Image("EditIcon")
                                .resizable()
                                .frame(width: 25, height: 25)
                        })
                        
                        
                    }.sheet(isPresented: $isFoodExpenseEntryPresented, content: {
                        editFoodExpense(isPresented: $isFoodExpenseEntryPresented, currTrip: $myTrip)
                    })
                    if let foodBudget = myTrip.FoodBudget {
                        if let foodSpent = myTrip.FoodBudgetSpent {
                            let width = CGFloat(foodSpent * 329/foodBudget)
                            Rectangle()
                                .frame(width: 329, height: 35)
                                .foregroundColor(bgProgress)
                                .overlay(
                                    Rectangle()
                                        .frame(width: width, height:35)
                                        .foregroundColor(fgProgress)
                                        .offset(x: (width - 329)/2, y:0)
                                )
                        }
                    }
                    HStack {
                        if let foodBudget = myTrip.FoodBudget {
                            if let foodSpent = myTrip.FoodBudgetSpent {
                                Text("$\(foodSpent)")
                                    .font(.system(size: 20))
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                Text("of $\(foodBudget)")
                                    .font(.system(size: 20))
                                    .foregroundColor(Color.gray)
                                Spacer()
                                    .frame(width:130)
                                Text("$\(foodBudget - foodSpent) left")
                                    .font(.system(size: 20))
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            }
                        }
                        
                    }
                }
            
                VStack {
                    HStack {
                        Image("GasIcon")
                            .resizable()
                            .frame(width: 40.0, height: 40)
                        Text("Gas")
                            .font(.system(size: 32))
                        Spacer().frame(width:210)
                        Button(action: {isGasExpenseEntryPresented.toggle()}, label: {
                            Button(action: {isGasExpenseEntryPresented.toggle()}, label: {
                                Image("EditIcon")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                            })
                        })
                        
                    }.sheet(isPresented: $isGasExpenseEntryPresented, content: {
                        editGasExpense(isPresented: $isGasExpenseEntryPresented, currTrip: $myTrip)
                    })
                    if let gasBudget = myTrip.GasBudget {
                        if let gasSpent = myTrip.GasBudgetSpent {
                            let width = CGFloat(gasSpent * 329/gasBudget)
                            Rectangle()
                                .frame(width: 329, height: 35)
                                .foregroundColor(bgProgress)
                                .overlay(
                                    Rectangle()
                                        .frame(width: width, height:35)
                                        .foregroundColor(fgProgress)
                                        .offset(x: (width - 329)/2, y:0))
                            }
                        }
                    HStack {
                        if let gasBudget = myTrip.GasBudget {
                        if let gasSpent = myTrip.GasBudgetSpent {
                            Text("$\(gasSpent)")
                                .font(.system(size: 20))
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            Text("of $\(gasBudget)")
                                .font(.system(size: 20))
                                .foregroundColor(Color.gray)
                            Spacer()
                                .frame(width:130)
                            Text("$\(gasBudget - gasSpent) left")
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                            }
                        }
                        
                    }
                }
                
                VStack {
                    HStack {
                        Image("HotelIcon")
                            .resizable()
                            .frame(width: 40.0, height: 40)
                        Text("Hotel")
                            .font(.system(size: 32))
                        Spacer().frame(width:190)
                        Button(action: {isHotelExpenseEntryPresented.toggle()}, label: {
                            Image("EditIcon")
                                .resizable()
                                .frame(width: 25, height: 25)
                        })
                        
                    }.sheet(isPresented: $isHotelExpenseEntryPresented, content: {
                        editHotelExpense(isPresented: $isHotelExpenseEntryPresented, currTrip: $myTrip)
                    })
                    if let hotelBudget = myTrip.HotelBudget {
                        if let hotelSpent = myTrip.HotelBudgetSpent {
                            let width = CGFloat(hotelSpent * 329/hotelBudget)
                            Rectangle()
                                .frame(width: 329, height: 35)
                                .foregroundColor(bgProgress)
                                .overlay(
                                    Rectangle()
                                        .frame(width: width, height:35)
                                        .foregroundColor(fgProgress)
                                        .offset(x: (width - 329)/2, y:0))
                        }
                    }
                    HStack {
                        if let hotelBudget = myTrip.HotelBudget {
                        if let hotelSpent = myTrip.HotelBudgetSpent {
                            Text("$\(hotelSpent)")
                                .font(.system(size: 20))
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                       
                        
                            Text("of $\(hotelBudget)")
                                .font(.system(size: 20))
                                .foregroundColor(Color.gray)
                            Spacer()
                                .frame(width:100)
                            Text("$\(hotelBudget - hotelSpent) left")
                                .font(.system(size: 20))
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        }
                        }
                        
                    }
                }
                 
            
        }
    }
}

struct editFoodExpense: View {
    @Binding var isPresented: Bool
    @Binding var currTrip: Trip
    @State private var expenseAmount: String = ""
    
    var body: some View {
        VStack {
            TextField("Enter Food Expense Amount", text: $expenseAmount)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
            Button("Save Expense") {
                if let amount = Int(expenseAmount) {
                                    // Handle saving the expense with the entered amount
                    if let budget = currTrip.BudgetSpent {
                        currTrip.BudgetSpent = budget + amount
                    }
                    if let spent = currTrip.totalLeft {
                        currTrip.totalLeft = spent - amount
                    }
                    if let foodSpent = currTrip.FoodBudgetSpent {
                        currTrip.FoodBudgetSpent = foodSpent + amount
                    }
                                    print("Expense Amount: \(amount)")
                                    isPresented.toggle()
                                } else {
                                    // Handle invalid input (non-integer)
                                    print("Invalid Expense Amount")
                                }
                            }
        }
    }
}

struct editGasExpense: View {
    @Binding var isPresented: Bool
    @Binding var currTrip: Trip
    @State private var expenseAmount: String = ""
    
    var body: some View {
        VStack {
            TextField("Enter Gas Expense Amount", text: $expenseAmount)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
            Button("Save Expense") {
                if let amount = Int(expenseAmount) {
                                    // Handle saving the expense with the entered amount
                    if let budget = currTrip.BudgetSpent {
                        currTrip.BudgetSpent = budget + amount
                    }
                    if let spent = currTrip.totalLeft {
                        currTrip.totalLeft = spent - amount
                    }
                    if let gasSpent = currTrip.GasBudgetSpent {
                        currTrip.GasBudgetSpent = gasSpent + amount
                    }
                                    print("Expense Amount: \(amount)")
                                    isPresented.toggle()
                                } else {
                                    // Handle invalid input (non-integer)
                                    print("Invalid Expense Amount")
                                }
                            }
        }
    }
}

struct editHotelExpense: View {
    @Binding var isPresented: Bool
    @Binding var currTrip: Trip
    @State private var expenseAmount: String = ""
    
    var body: some View {
        VStack {
            TextField("Enter Hotel Expense Amount", text: $expenseAmount)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
            Button("Save Expense") {
                if let amount = Int(expenseAmount) {
                                    // Handle saving the expense with the entered amount
                    if let budget = currTrip.BudgetSpent {
                        currTrip.BudgetSpent = budget + amount
                    }
                    if let spent = currTrip.totalLeft {
                        currTrip.totalLeft = spent - amount
                    }
                    if let hotelSpent = currTrip.HotelBudgetSpent {
                        currTrip.HotelBudgetSpent = hotelSpent + amount
                    }
                                    print("Expense Amount: \(amount)")
                                    isPresented.toggle()
                                } else {
                                    // Handle invalid input (non-integer)
                                    print("Invalid Expense Amount")
                                }
                            }
        }
    }
}

#Preview {
    Budget(myTrip: Trip(location: "Maui", totalBudget: 2670, totalLeft: 1811, BudgetSpent: 859, FoodBudget: 300, FoodBudgetSpent: 209, GasBudget: 420, GasBudgetSpent: 50, HotelBudget: 1950, HotelBudgetSpent: 600))
}

