//
//  ContentView.swift
//  Guess The Flag
//
//  Created by Fauzi Achmad Bangsa Diria on 19/06/20.
//  Copyright © 2020 nooglersoon. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingAlert = false
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var points = 0
    @State private var num: Int = 0
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)

    var body: some View {
        
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            
            VStack (spacing: 30) {
                
                VStack (alignment: .center) {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                       //self.flagTapped(number)
                        self.num = self.flagTapped(number)
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Circle())
                    }
                }
            
                Text("Your Score is: \(points)")
                    .foregroundColor(.white)
                    .font(.headline)
                    .fontWeight(.bold)
            }
            .alert(isPresented: $showingScore) {
                Alert(title: Text(scoreTitle), message: Text("Wrong! That’s the flag of \(countries[num])"), dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                })
            }
        }
        
    }
    
    func flagTapped(_ number: Int) -> Int {
        if number == correctAnswer {
            scoreTitle = "Correct"
            points += 1
            self.askQuestion()
        } else {
            scoreTitle = "Wrong"
            points = 0
            showingScore = true
        }
        
        return number
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
    }
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
