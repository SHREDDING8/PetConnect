//
//  Section.swift
//  PetConnect
//
//  Created by Leonid Romanov on 19.08.2023.
//

import Foundation

struct Section {
  var nameSection: String
  var description: [String]
  var isExpanded: Bool
  
  static var dataSource = [
    Section(nameSection: "Добавить чип",
            description: ["Номер чипа", "Дата имплонтации", "Место имплотации"],
            isExpanded: false),
    Section(nameSection: "Добавить клеймо",
            description: ["Номер клейма", "Дата клеймирования"],
            isExpanded: false)
  ]
  
}
