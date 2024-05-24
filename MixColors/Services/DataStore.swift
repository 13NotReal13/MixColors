//
//  DataStore.swift
//  MixColors
//
//  Created by Иван Семикин on 24/05/2024.
//

import Foundation

final class DataStore {
    static let shared = DataStore()
    
    private init() {}
    
    let colors: [Color] = [
        Color(name: "Красный", color: .red),
        Color(name: "Синий", color: .blue),
        Color(name: "Зелёный", color: .green),
        Color(name: "Жёлтый", color: .yellow),
        Color(name: "Чёрный", color: .black),
        Color(name: "Белый", color: .white),
    ]
    
    let colorMixes: [MixColor] = [
        MixColor(color1: .red, color2: .red, resultName: "Красный"),
        MixColor(color1: .blue, color2: .blue, resultName: "Синий"),
        MixColor(color1: .green, color2: .green, resultName: "Зелёный"),
        MixColor(color1: .yellow, color2: .yellow, resultName: "Жёлтый"),
        MixColor(color1: .black, color2: .black, resultName: "Чёрный"),
        MixColor(color1: .white, color2: .white, resultName: "Белый"),
        MixColor(color1: .red, color2: .blue, resultName: "Фиолетовый"),
        MixColor(color1: .red, color2: .green, resultName: "Коричневый"),
        MixColor(color1: .red, color2: .yellow, resultName: "Оранжевый"),
        MixColor(color1: .red, color2: .black, resultName: "Тёмно-красный"),
        MixColor(color1: .red, color2: .white, resultName: "Розовый"),
        MixColor(color1: .blue, color2: .green, resultName: "Аквамарин"),
        MixColor(color1: .blue, color2: .yellow, resultName: "Зелёный"),
        MixColor(color1: .blue, color2: .black, resultName: "Тёмно-синий"),
        MixColor(color1: .blue, color2: .white, resultName: "Голубой"),
        MixColor(color1: .green, color2: .yellow, resultName: "Лайм"),
        MixColor(color1: .green, color2: .black, resultName: "Тёмно-зелёный"),
        MixColor(color1: .green, color2: .white, resultName: "Мятный"),
        MixColor(color1: .yellow, color2: .black, resultName: "Оливковый"),
        MixColor(color1: .yellow, color2: .white, resultName: "Светло-жёлтый"),
        MixColor(color1: .black, color2: .white, resultName: "Серый")
    ]
}
