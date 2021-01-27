//
//  ContentView.swift
//  DesignExample
//
//  Created by Denis Volkov on 22.01.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var show = false                 // Изменение состояния по нажатию на карточку
    @State var viewState = CGSize.zero      // Перемещение карточек по экрану
    @State var showCard = false             // Всплывающая карточка при нажатии на основную
    @State var bottomState = CGSize.zero    // Перемещение всплывающей карточки
    @State var showFull = false             // Всплывающая карточка на весь экран
    
    var body: some View {
        ZStack {
            
            // MARK: - Название View
            
            TitleView()
                .blur(radius: show ? 20 : 0)
                .opacity(showCard ? 0.4 : 1)
                .offset(y: showCard ? -200 : 0)
                .animation(
                    Animation
                        .default    //Вид анимации
                        .delay(0.1) //Задержка анимации
                    //                        .speed(2)
                    //                        .repeatCount(5, autoreverses: false)
                )
            // MARK: - Карточка на заднем плане
            
            BackCardView()
                .frame(width: showCard ? 300 : 340, height: 220)
                .background(show ? Color(#colorLiteral(red: 1, green: 0.2980359225, blue: 0.5179235242, alpha: 1)) : Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -400 : -40)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -180 : 0)
                .scaleEffect(showCard ? 1 : 0.9)
                .rotationEffect(.degrees(show ? 0 : 10))
                .rotationEffect(.degrees(showCard ? -10 : 0))
                .rotation3DEffect(.degrees(showCard ? 0 : 10), axis: (x: 10, y: 0, z: 0))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.5))
            
            BackCardView()
                .frame(width: 340, height: 220)
                .background(show ? Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)) : Color(#colorLiteral(red: 1, green: 0.2980359225, blue: 0.5179235242, alpha: 1)))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -200 : -20)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -140 : 0)
                .scaleEffect(showCard ? 1 : 0.95)
                .rotationEffect(.degrees(show ? 0 : 5))
                .rotationEffect(.degrees(showCard ? -5 : 0))
                .rotation3DEffect(.degrees(showCard ? 0 : 5), axis: (x: 10, y: 0, z: 0))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.3))
            
            // MARK: - Основная карточка
            
            CardView()
                .frame(width: showCard ? 375 : 340, height: 220)
                .background(Color.black)
                //                .cornerRadius(20)
                .clipShape(RoundedRectangle(cornerRadius: showCard ? 30 : 20, style: .continuous))
                .shadow(radius: 20)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -100 : 0)
                .blendMode(.hardLight)
                .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0))
                .onTapGesture {
                    self.showCard.toggle()
                }
                .gesture(
                    DragGesture().onChanged { value in
                        self.viewState = value.translation
                        self.show = true
                    }
                    .onEnded { value in
                        self.viewState = .zero
                        self.show = false
                    }
                )
            
//                        Text("\(bottomState.height)")         //Значение для определения положения всплывающей карточки
//                            .offset(y: -300)
            
            // MARK: - Всплывающая картачка
            
            BottomCardView(show: $showCard)
                .offset(x: 0, y: showCard ? 360 : 1000)
                .offset(y: bottomState.height)
                .blur(radius: show ? 20 : 0)
                .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            self.bottomState = value.translation
                            if self.showFull {
                                self.bottomState.height += -300
                            }
                            if self.bottomState.height < -300 {
                                self.bottomState.height = -300
                            }
                        }
                        .onEnded { value in
                            if self.bottomState.height > 50 {
                                self.showCard = false
                            }
                            if (self.bottomState.height < -100  &&
                                    !self.showFull) || (self.bottomState.height < 250 && self.showFull) {
                                self.bottomState.height = -300
                                self.showFull = true
                            } else {
                                self.bottomState = .zero
                                self.showFull = false
                            }
                        }
                )
        }
    }
}

// MARK: -

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
// MARK: - Структура основной карточки

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
    }
}

// MARK: - Структура карточки на заднем плане

struct BackCardView: View {
    var body: some View{
        VStack {
            Spacer()
        }
    }
}

// MARK: - Структура названия View
struct TitleView: View {
    var body: some View {
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
    }
}

// MARK: - Структура всплывающей карточки

struct BottomCardView: View {
    @Binding var show: Bool         //Связь с другим файлом
    
    var body: some View {
        VStack(spacing: 20) {
            Rectangle()
                .frame(width: 40, height: 5)
                .cornerRadius(3)
                .opacity(0.1)
            Text("Изучение особенностей разработки адаптивного дизайна в SwiftUI")
                .multilineTextAlignment(.center)
                .font(.subheadline)
                .lineSpacing(4)
            
            HStack(spacing: 20) {
                RingView(color1: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), color2: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), width: 88, height: 88, percent: 78, show: $show)
                    .animation(Animation.easeInOut.delay(0.1))
                
                VStack(alignment: .leading, spacing: 9) {
                    Text("Дизайн в SwiftUI")
                        .bold()
                    Text("39 из 50 уроков завершено")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                .padding(20)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 10)
            }
            
            Spacer()
        }
        .padding(.top, 8)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
        .background(Color("Background 3"))
        .cornerRadius(30)
        .shadow(radius: 20)
        
    }
}
