//
//  HomeView.swift
//  DesignExample
//
//  Created by Denis Volkov on 25.01.2021.
//

import SwiftUI

struct HomeView: View {
    @Binding var showProfile: Bool            //Связь с всплывающим меню из другого файла
    @Binding var showContent: Bool
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    AvatarView(showProfile: $showProfile)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.leading, 14)
                .padding(.top, 30)
          
                //MARK: - Меню выбора с горизонтальной прокруткой. Кольца
                
                ScrollView(.horizontal, showsIndicators: false) {
                    RingsView()
                        .padding(.horizontal, 30)
                        .padding(.bottom, 30)
                        .onTapGesture {
                            self.showContent = true
                        }
                }
                
                //MARK: - Меню выбора курсов с горизонтальной прокруткой

                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(sectionData) { item in
                            GeometryReader { geometry in    //Прокрутка с поворотом
                                SectionView(section: item)
                                    .rotation3DEffect(Angle(degrees: Double(geometry.frame(in: .global) .minX - 30) / -20), axis: (x: 0, y: 10, z: 0))
                            }
                            .frame(width: 275, height: 275)
                        }
                    }
                    .padding(30)
                    .padding(.bottom, 30)
                }
                .offset(y: -30)
                
                //MARK: - Отдельный курс
                
                HStack {
                    Text("Курсы")
                        .font(.title)
                        .bold()
                    
                    Spacer()
                }
                .padding(.leading, 30)
                .offset(y: -60)
                
                SectionView(width: screen.width - 60, height: 275, section: sectionData[1])
                    .offset(y: -60)
                
                Spacer()
                
                //MARK: -
            }
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showProfile: .constant(false), showContent: .constant(false))  //Должны указать State свойства 
    }
}

//MARK: - Струтура горизонтального меню выбора курсов

struct SectionView: View {
    var width: CGFloat = 275
    var height: CGFloat = 275
    var section: Section
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(section.title)
                    .font(.system(size: 20, weight: .bold))
                    .frame(width: 160, alignment: .leading)
                    .foregroundColor(.white)
                
                Spacer()
                
                Image(section.logo)
            }
            Text(section.text.uppercased())
                .frame(maxWidth: .infinity, alignment: .leading)
            
            section.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 210)
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(width: width, height: height)
        .background(section.color)
        .cornerRadius(30)
        .shadow(color: section.color.opacity(0.3), radius: 20, x: 0, y: 20)
        
    }
}


struct Section: Identifiable {
    var id = UUID()                     //Каждый экземляр имеет свой идентификатор с параментрами
    var title: String
    var text: String
    var logo: String
    var image: Image
    var color: Color
}


let sectionData = [
    Section(title: "Дизайн в SwiftUI", text: "50 уроков", logo: "Logo SwiftUI", image: Image("1"), color: Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))),
    Section(title: "Основы Swift", text: "30 уроков", logo: "Logo SwiftUI", image: Image("2"), color: Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))),
    Section(title: "Решение задач на языке Swift", text: "35 уроко", logo: "Logo SwiftUI", image: Image("4"), color: Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)))
]

//MARK: - Структура горизонтального меню с кольцами

struct RingsView: View {
    var body: some View {
        HStack(spacing: 30) {
            HStack(spacing: 12) {
                RingView(color1: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), color2: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), width: 44, height: 44, percent: 68, show: .constant(true))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Осталось 7 минут")
                        .font(.subheadline)
                        .bold()
                    
                    Text("Смотрел(а) 15 минут сегодня")
                        .font(.caption)
                }
            }
            .padding(8)
            .background(Color.white)
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
            
            
            HStack(spacing: 12) {
                RingView(color1: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), color2: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), width: 32, height: 32, percent: 54, show: .constant(true))
                
            }
            .padding(8)
            .background(Color.white)
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
            
            
            HStack(spacing: 12) { 
                RingView(color1: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), color2: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), width: 32, height: 32, percent: 32, show: .constant(true))
                
            }
            .padding(8)
            .background(Color.white) 
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
            
        }
    }
}
