//
//  Superhero.swift
//  RAWGUI
//
//  Created by Marius Malyshev on 09.02.2022.
//

struct Superhero: Codable {
    let name: String?
    let images: Images?
}

struct Images: Codable {
    let xs: String
    let sm: String
    let md: String
    let lg: String
}

enum Links: String {
    case superheoesUrl = "https://cdn.rawgit.com/akabab/superhero-api/0.2.0/api/all.json"
}
