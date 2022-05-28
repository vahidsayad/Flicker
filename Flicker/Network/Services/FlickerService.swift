//
//  FlickerService.swift
//  Flicker
//
//  Created by Vahid Sayad on 27/5/2022 .
//

import Foundation

enum FlickerService {
    case search(page: Int, pageSize: Int)
}

extension FlickerService: API {
    var baseURL: String {
        Constant.flickerBaseUrl
    }
    
    var endPoint: String {
        switch self {
        case .search(let page, let pageSize):
            return "?api_key=903c9deaf4ebc493e9cd9d97a8e9512a&format=json&nojsoncallback=1&method=flickr.photos.getRecent&per_page=\(pageSize)&page=\(page)&extras=url_s"
        }
    }
    
    var method: APIMethod {
        switch self {
        case .search:
            return .get
        }
    }
    
    var auth: APIAuth {
        switch self {
        case .search:
            return .open
        }
    }
}
