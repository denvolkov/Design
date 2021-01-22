//
//  ContentView.swift
//  DesignExample
//
//  Created by Denis Volkov on 22.01.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
        HStack {
            VStack {
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
