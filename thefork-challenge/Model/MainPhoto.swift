//
//  MainPhoto.swift
//  thefork-challenge
//
//  Created by Fernando Menendez on 05/11/2021.
//

import Foundation

struct MainPhoto: Codable {
    let source, the612X344, the480X270, the240X135: String
    let the664X374, the1350X759, the160X120, the80X60: String
    let the92X92, the184X184: String

    enum CodingKeys: String, CodingKey {
        case source
        case the612X344 = "612x344"
        case the480X270 = "480x270"
        case the240X135 = "240x135"
        case the664X374 = "664x374"
        case the1350X759 = "1350x759"
        case the160X120 = "160x120"
        case the80X60 = "80x60"
        case the92X92 = "92x92"
        case the184X184 = "184x184"
    }
}
