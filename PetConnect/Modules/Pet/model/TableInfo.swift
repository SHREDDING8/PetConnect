//
//  TableInfo.swift
//  PetConnect
//
//  Created by Leonid Romanov on 17.08.2023.
//

import Foundation

struct TableInfo {
  let text: String
  static let dataSource = [
    TableInfo(text: "Имя*"), TableInfo(text: "Тип*"),
    TableInfo(text: "Порода*"), TableInfo(text: "Дата рождения*")
  ]
}
