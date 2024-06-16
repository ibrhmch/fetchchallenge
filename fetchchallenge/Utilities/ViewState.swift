//
//  ViewState.swift
//  fetchchallenge
//
//  Created by octopus on 6/15/24.
//

import Foundation

enum ViewState<T> {
    case loading
    case success(T)
    case failure(String)
}
