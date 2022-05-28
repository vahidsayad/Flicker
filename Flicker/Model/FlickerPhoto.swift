//
//  FlickerPhoto.swift
//  Flicker
//
//  Created by Vahid Sayad on 27/5/2022 .
//

import Foundation

struct FlickerPhotoResponse: Decodable {
    var photos: Photos
    var stat: String
    
    struct Photos: Decodable {
        var photo: [FlickerPhoto]
    }
}

struct FlickerPhoto: Decodable, Hashable {
    var id: String
    var owner: String
    var title: String
    var url_s: String
}
