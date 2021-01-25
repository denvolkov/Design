//
//  ContentView.swift
//  DesignExample
//
//  Created by Denis Volkov on 22.01.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Сертификаты")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding()
                Spacer()
            }
            
            BackCardView()
                .background(Color(#colorLiteral(red: 1, green: 0.2980359225, blue: 0.5179235242, alpha: 1)))
                .cornerRadius(20)
                .offset(x: 0, y: -40)
                .scaleEffect(0.9)
                .rotationEffect(.degrees(10))
                .rotation3DEffect(.degrees(10), axis: (x: 10, y: 0, z: 0))
                .blendMode(.hardLight)
            
            BackCardView()
                .background(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
                .cornerRadius(20)
                .offset(x: 0, y: -20)
                .scaleEffect(0.95)
                .rotationEffect(.degrees(5))
                .rotation3DEffect(.degrees(5), axis: (x: 10, y: 0, z: 0))
                .blendMode(.hardLight)
            
            
            CardView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardView: View {
    var body: some View {
        
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Дизайн в SwiftUI")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    Text("Сертификат")
                        .foregroundColor(Color("Primary"))
                }
                
                Spacer()
                
                Image("Logo SwiftUI")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50)
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            
            Image("2")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 110, alignment: .top)
        }
        .frame(width: 340, height: 220)
        .background(Color.black)
        .cornerRadius(20)
        .shadow(radius: 20)
    }
}

struct BackCardView: View {
    var body: some View{
        VStack {
            Spacer()
        }
        .frame(width:340, height: 220)
    }
}
