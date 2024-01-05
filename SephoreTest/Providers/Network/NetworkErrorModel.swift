//
//  NetworkErrorModel.swift
//  SephoreTest
//
//  Created by Jeromin Lebon on 05/01/2024.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case badRequest
    case statusCode
    case serializing
    case other(Error)

    static func map(_ error: Error) -> NetworkError {
        return (error as? NetworkError) ?? .other(error)
    }
}
