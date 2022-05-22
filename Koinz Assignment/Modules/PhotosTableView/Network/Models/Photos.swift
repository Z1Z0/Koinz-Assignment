//
//  Photos.swift
//  Koinz Assignment
//
//  Created by Ahmed Abd Elaziz on 22/05/2022.
//

import Foundation

struct Photos: Codable {
    var page, pages, perpage, total: Int?
    var photo: [Photo]?
}
