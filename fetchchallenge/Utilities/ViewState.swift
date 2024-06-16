//
//  ViewState.swift
//  fetchchallenge
//
//  Created by octopus on 6/15/24.
//

import Foundation

enum ViewState<T: Equatable>: Equatable {
    case loading
    case success(T)
    case failure(String)
    
    static func ==(lhs: ViewState<T>, rhs: ViewState<T>) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case (.success(let lhsData), .success(let rhsData)):
            return lhsData == rhsData
        case (.failure(let lhsMessage), .failure(let rhsMessage)):
            return lhsMessage == rhsMessage
        default:
            return false
        }
    }
}
