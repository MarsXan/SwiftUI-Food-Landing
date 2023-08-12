//
//  ContentView.swift
//  SnappFoodIntro
//
//  Created by mohsen mokhtari on 8/12/23.
//

import SwiftUI

struct IntroView: View {
        
    @State private var activeIndex: Int = 0
    @State private var dragRotation:Angle = .zero
    @State private var timer = Timer.publish(every: 2, on: .main, in: .default).autoconnect()
    @State var currentIndex = 0
    @State var scaleIndex = introModels.count / 2
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack{
                    RadialLayout(items: introModels, id: \.self, spacing: 200, dragRotation:$dragRotation,scaleIndex: scaleIndex) { item, index, size in
                        Image(item.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 170, height: 170)
                            .tag(index)
                            
                        
                            
                    } onIndexChange: { index in
                        activeIndex = index
                    }
                    .frame(width: geometry.size.width * 1.8, height: geometry.size.width * 1.8)
                    .offset(x:-80,y:-160)
                    .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.width)
                    Image(Images.logo)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120)
                        .vAlign(.top)
                        .hAlign(.leading)
                        .padding(32)
                    
                }
               
                            
                VStack(spacing: 0){
                    Text("سفارش آنلاین از")
                        .font(.custom(iranSansRegular, size: 16))
                        .foregroundColor(.gray.opacity(0.7))
                        .hAlign(.trailing)
                    
                    Text(introModels[currentIndex].title)
                        .font(.custom(iranSansBold, size: 32))
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.top)
                    .hAlign(.trailing)
                    
                    Text(introModels[currentIndex].desc)
                        .font(.custom(iranSansRegular, size: 14))
                        .padding(.top)
                    .hAlign(.trailing)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity,maxHeight: .infinity)
                .padding()
                
                Spacer()
                
                VStack{
                    Button{
                        
                    }label:{
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.pColor)
                        
                    }.frame(height: 40)
                        .overlay{
                            Text("شروع سفارش از اسنپ‌ فود")
                                .font(.custom(iranSansBold, size: 16).bold())
                            
                                .foregroundColor(.white)
                               
                        }
                        .padding(.top)
                        .padding(.horizontal)
                        
                    Button{
                        
                    }label:{
                        Text("ادامه به عنوان میهمان")
                            .font(.custom(iranSansBold, size: 16))
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                    }.frame(height: 40)
                        .padding(.horizontal)
                        
                }
                .padding(.top,32)
                .background(.white)
                
            
            }
            .onReceive(timer) { _ in
                withAnimation(.easeInOut(duration: 1.5)) {
                    
                    if scaleIndex > 0 {
                        scaleIndex -= 1
                    }else{
                        scaleIndex = 4
                    }
                    if currentIndex < introModels.count - 1 {
                        currentIndex += 1
                    }else{
                        currentIndex = 0
                    }
                    dragRotation = .init(degrees: dragRotation.degrees + 360.0 / CGFloat(introModels.count))
                    }
                }
            
            
        }
        
        .vAlign(.top)
        .background(.gray.opacity(0.1))
        
    }
            
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
