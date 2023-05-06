//
//  ApiErrors.swift
//  JobLess
//
//  Created by Cédric Bahirwe on 12/09/2022.
//

import Foundation

enum ApiErrors: Error {
    case genericError
    case internetError
    case timeout
    case localUserNotFound
    case dataBaseError
    case apiError(code: Int, message: String, reason: String)
    case retryError(message: String, retryAction: () -> Void)
    case unauthorized
    case userNotFound
    case invalidUser
    case parseData
    case noDataFound
    case unknownError(_ error: Error?)
}
