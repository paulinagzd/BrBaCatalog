//
//  Model.swift
//  BrBaFlink
//
//  Created by Paulina González Dávalos on 09/02/22.
//

import SwiftUI

struct Response: Codable {
    var characters: [Characters]
}

struct Characters: Codable {
    let char_id: Int
    let name: String
    let birthday: String
    let occupation: Array<String>
    let img: String
    let status: String
    let nickname: String
    let appearance: Array<Int>
    let portrayed: String
    let category: String
    let better_call_saul_appearance: Array<Int>
}

