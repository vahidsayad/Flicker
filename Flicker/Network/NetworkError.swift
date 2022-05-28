//
//  NetworkError.swift
//  Flicker
//
//  Created by Vahid Sayad on 27/5/2022 .
//

import Foundation

enum NetworkError: Error {
    case badRequest
    case encodingError
    case badUrl
    case timedout
    case serverIssue
}
