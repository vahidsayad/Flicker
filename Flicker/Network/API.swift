//
//  API.swift
//  Flicker
//
//  Created by Vahid Sayad on 27/5/2022 .
//

import Foundation

protocol API {
    var baseURL: String {get}
    var endPoint: String {get}
    var method: APIMethod {get}
    var auth: APIAuth {get}
}
