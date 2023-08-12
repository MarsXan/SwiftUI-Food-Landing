//
//  RadialView.swift
//  SnappFoodIntro
//
//  Created by mohsen mokhtari on 8/12/23.
//

import SwiftUI

struct RadialLayout<Content:View, Item:RandomAccessCollection, ID:Hashable> : View where Item.Element : Identifiable {
    var content: (Item.Element,Int, CGFloat) -> Content
    var keyPathID: KeyPath<Item.Element, ID>
    var items: Item
    var spacing: CGFloat?
    var onIndexChange: (Int) -> ()
    
    @Binding var dragRotation:Angle
     var scaleIndex:Int
    @State var lastDragRotation:Angle = .zero
    @State var activeIndex: Int = 0
    
    
    
    
    init(items: Item, id: KeyPath<Item.Element, ID>, spacing: CGFloat? = nil,dragRotation:Binding<Angle>,scaleIndex:Int , @ViewBuilder
         content: @escaping (Item.Element,Int, CGFloat) -> Content, onIndexChange: @escaping (Int) -> ()) {
        self.content = content
        self.onIndexChange = onIndexChange
        self.spacing = spacing
        self.keyPathID = id
        self.items = items
        self._dragRotation = dragRotation
        self.scaleIndex = scaleIndex
    
    }
    
    var body: some View {
        GeometryReader (content: { geometry in
            let size = geometry.size
            let width = size.width
            let count = CGFloat (items.count)
            let spacing: CGFloat = self.spacing ?? 0
            let viewSize = ( width - spacing) / (count/2)
           
            ZStack (content: {
                ForEach(items, id: keyPathID) { item in
                    let index = getItemIndex(item)
                    let rotation = (CGFloat (index) / count ) * 360.0
                    
                    content (item,index,viewSize)
                        .rotationEffect(.init(degrees: 90))
                        .rotationEffect(.init(degrees: -rotation))
                       
                        .frame(width: viewSize,height: viewSize)
                        .offset(x:(width-viewSize) / 2)
                        .rotationEffect(.init(degrees: -90))
                        .rotationEffect(.init(degrees: rotation))
                        .scaleEffect(index == scaleIndex ? 1.1 : 0.8 )
                }
            })
            .frame (width: width, height: width)
            .contentShape(Rectangle())
            .rotationEffect(dragRotation)
            .onChange(of: dragRotation){ _ in
                calculateIndex(count)
            }
            
            .gesture(
                DragGesture()
                    .onChanged({value in
                        let translationX = value.translation.width
                        let progress = translationX / (viewSize * 2)
                        let rotationFraction = 360.0 / count
                        
                        dragRotation = .init(degrees:(rotationFraction * progress) + lastDragRotation.degrees)
                        calculateIndex(count)
                        
                    }).onEnded({value in
                        let translationX = value.translation.width
                        let progress = (translationX / (viewSize * 2)).rounded()
                        let rotationFraction = 360.0 / count
                        
                        withAnimation {
                            dragRotation = .init(degrees:(rotationFraction * progress) + lastDragRotation.degrees)
                        }
                        lastDragRotation = dragRotation
                        calculateIndex(count)
                    })
            
            )
        })
       
        }
    
    func getItemIndex(_ item: Item.Element) -> Int {
        if let index = items.firstIndex(where: {$0.id == item.id}) as? Int {
            return index
            
        }
        return 0
    }
    
    func calculateIndex(_ count:CGFloat){
        var activeIndex = (dragRotation.degrees / 360.0 * count).rounded().truncatingRemainder(dividingBy: count)
        activeIndex = activeIndex == 0 ? 0 : (activeIndex < 0 ? -activeIndex : count - activeIndex)
        
        self.activeIndex = activeIndex == count ? 0 : Int(activeIndex)
        
        onIndexChange(self.activeIndex)
    
    }
                
}
