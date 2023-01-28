//
//  Joke.swift
//  OneTableView
//
//  Created by  Mukhammed Ali Khamzayev on 06.11.2022.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct Joke: Codable {
    let error: Bool
    let category, type, joke: String
    let flags: Flags
    let id: Int
    let safe: Bool
    let lang: String
}

// MARK: - Flags
struct Flags: Codable {
    let nsfw, religious, political, racist: Bool
    let sexist, explicit: Bool
}

