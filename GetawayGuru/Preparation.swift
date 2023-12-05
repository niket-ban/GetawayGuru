//
//  Preparation.swift
//  GetawayGuru
//
//  Created by Jonathan Saleh on 11/22/23.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

struct Item: Codable, Hashable{
    var header: String
    var tasks: [String]
}

struct Preparation: View {
let ggblue = Color(red: 0.4627, green: 0.8392, blue: 1.0)
    @State private var trip: Trip = Trip(location: "Placeholder")
    @State private var isAddingItem = false
    @State private var newItem : Item = Item(header: "", tasks: [])
    var email: String
    var location: String
    var body: some View{
        NavigationStack{
            ZStack{
                ggblue
                VStack {
                    HStack{
                        
                        Spacer()
                        Text("Preparation Items")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(20)
                        Spacer()
                        Button(action: {
                            isAddingItem.toggle()
                        }) {
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .font(.system(size: 30))
                        }
                        .alert("Add New Item", isPresented: $isAddingItem, actions: {
                            TextField("item", text: $newItem.header)
                            Button("Add", action: {
                                if !newItem.header.isEmpty {
                                    if trip.PreparationItems == nil {
                                                trip.PreparationItems = []
                                    }
                                    trip.PreparationItems?.append(newItem)
                                    newItem = Item(header: "", tasks: [])
                                    setTrip(email: email, trip: trip)
                                }
                            })
                            Button("Cancel", role: .cancel, action: {})
                        })
                        Spacer()
                        
                        
                    }
                    .padding(.top, 40)
                    ForEach((trip.PreparationItems ?? []), id: \.self) { item in
                        if let index = trip.PreparationItems?.firstIndex(of: item),
                           let itemAtIndex = trip.PreparationItems?[index] {
                            ItemView(item: Binding.constant(itemAtIndex), trip: $trip, email:email)
                        }
                    }
                    Spacer()
                    
                    
                }
            }
            .ignoresSafeArea()
        }
        .task {
            trip = await getTrip(email: email, location: location)
        }

    }
}
struct ItemView: View {
    @Binding var item: Item
    @Binding var trip: Trip
    var email: String
    var body: some View {
        NavigationLink(
            destination: ItemList(item: $item, tasks: $item.tasks, trip: $trip, email:email)) {
                RectangleSelector(item: item, items: Binding.constant(trip.PreparationItems ?? []), trip: $trip, email:email)
        }
    }
}

struct RectangleSelector: View {
    let ggblue = Color(red: 0.4627, green: 0.8392, blue: 1.0)
    var item : Item
    @Binding var items: [Item]
    @Binding var trip: Trip
    var email: String
    var body: some View{
        Rectangle()
            .foregroundStyle(.white)
            .frame(width: 320, height: 80)
            .shadow(radius: 5)
            .cornerRadius(10)
            .padding()
            .overlay(
                HStack{
                    Spacer()
                    Button(action: {
                        if let index = items.firstIndex(of: item) {
                           items.remove(at: index)
                            if let tripIndex = trip.PreparationItems?.firstIndex(of: item) {
                                   trip.PreparationItems?.remove(at: tripIndex)
                            }
                            setTrip(email: email, trip: trip)
                       }
                    }) {
                        Image(systemName: "trash")
                    }

                    Text(item.header)
                        .font(.system(size: 24))
                        .foregroundColor(ggblue)
                        .frame(maxWidth: 250)
                    Image(systemName: "chevron.right")
                        .foregroundColor(.black)
                    Spacer()
                
                }
            )
    }
}
struct ItemList: View {
    @Binding var item: Item
    @Binding var tasks: [String]
    @Binding var trip: Trip
    var email: String
    let ggblue = Color(red: 0.4627, green: 0.8392, blue: 1.0)
    @State private var newTask = ""
    @State private var localTasks: [String] = []

    var body: some View {
        ZStack {
            ggblue
                .ignoresSafeArea()
            VStack {
                List {
                    ForEach(localTasks, id: \.self) { task in
                        ItemBar(task: task, tasks: $tasks, localTasks: $localTasks, trip:$trip, email:email, item: $item)
                            .listRowBackground(ggblue)
                    }
                }
                .scrollContentBackground(.hidden)
                HStack {
                    TextField("New Task", text: $newTask)
                    Button(action: {
                        if !newTask.isEmpty {
                            localTasks.append(newTask)
                            tasks.append(newTask)
                            if let index = trip.PreparationItems?.firstIndex(where: { $0.header == item.header }) {
                                trip.PreparationItems?[index].tasks.append(newTask)
                            }
                            newTask = ""
                            setTrip(email: email, trip: trip)
                        
                        }
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 70, height: 30)
                                .foregroundStyle(.white)
                            Text("Add")
                                .foregroundStyle(.black)
                        }
                    }
                }
                .padding(24)
            }
            .navigationTitle(item.header)
            .onAppear {
                localTasks = tasks
            }
        }
    }
}

struct ItemBar: View {
    @State private var filled: Bool = false
    var task: String
    @Binding var tasks: [String]
    @Binding var localTasks: [String]
    @Binding var trip: Trip
    var email: String
    @Binding var item: Item
    var body: some View {
        HStack {
            Button(action: {
                filled.toggle()
                if filled {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        if let index = localTasks.firstIndex(of: task) {
                            localTasks.remove(at: index)
                            tasks.remove(at: index)
                            if let index = trip.PreparationItems?.firstIndex(where: { $0.header == item.header }) {
                                if let taskIndex = trip.PreparationItems?[index].tasks.firstIndex(of: task) {
                                    trip.PreparationItems?[index].tasks.remove(at: taskIndex)
                                }
                            }
                            setTrip(email: email, trip: trip)
                        }
                    }
                }
            }) {
                Image(systemName: filled ? "circle.fill" : "circle")
                    .foregroundColor(.blue)
            }
            Text(task)
                .opacity(filled ? 0.4 : 1)
        }
    }
}
#Preview {
    Preparation(email: "a@a.com", location: "Barcelona")
}
