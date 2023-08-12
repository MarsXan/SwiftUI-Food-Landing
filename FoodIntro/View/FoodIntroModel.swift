//
//  FoodIntroModel.swift
//  SnappFoodIntro
//
//  Created by mohsen mokhtari on 8/12/23.
//

import Foundation

struct FoodIntroModel:Identifiable,Hashable{
    var id = UUID().uuidString
    var title:String
    var desc:String
    var image:String
}

var introModels:[FoodIntroModel] = [
   
    .init(title: "غذا و نوشیدنی", desc: "خرید غذا و نوشیدنی از بهترین های شهرتان",image: "Food_1"),
    .init(title: "نان و شیرینی", desc: "خرید نان و شیرینی روزانه تازه ",image: "Food_4"),
    .init(title:  "گوشت و لبنیات", desc: "خرید گوشت و لبنیات، تحویل درب منزلتان",image: "Food_2"),
    .init(title: "میوه و سبزیجات", desc: "خرید میوه و سبزی نزدیکتان",image: "Food_3"),
    .init(title: "میوه و سبزیجات", desc: "خرید میوه و سبزی نزدیکتان",image: "Food_3"),
       
]
