//
//  Pet.swift
//  PetConnect
//
//  Created by Leonid Romanov on 19.08.2023.
//

import Foundation

struct Chip {
  let number: String
  let date: String
  let mesto: String
}

struct Cleimo {
  let number: String
  let date: String
}

struct PetHim {
  let name: String
  let age: String
  let poroda: String
  let imageGender: String
  let imagePet: String
  let chip: Chip?
  let cleimo: Cleimo?
  
  static let dataSource = [
    PetHim(name: "Беляш", age: "2 года 3 месяца", poroda: "Мопс", imageGender: "male", imagePet: "mops",
        chip: Chip(number: "DSSDF7V6AA", date: "22.07.2020", mesto: "Задняя левая лапа"),
        cleimo: Cleimo(number: "DSSDF7V6AA", date: "22.07.2020")),
    PetHim(name: "Бэлла", age: "1 год", poroda: "Пудель", imageGender: "female", imagePet: "pudel", chip: nil, cleimo: nil)
  ]
}

