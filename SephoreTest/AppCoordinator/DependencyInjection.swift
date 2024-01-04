//
//  DependencyInjection.swift
//  SephoreTest
//
//  Created by Jeromin Lebon on 05/01/2024.
//

import Foundation

final class Resolver {
    private var dependencies = [String: AnyObject]()
    private static var shared = Resolver()

    static func register<T>(_ dependency: T) {
        shared.register(dependency)
    }

    static func resolve<T>() -> T {
        shared.resolve()
    }

    private func register<T>(_ dependency: T) {
        let key = String(describing: T.self)
        dependencies[key] = dependency as AnyObject
    }

    private func resolve<T>() -> T {
        let key = String(describing: T.self)
        let dependency = dependencies[key] as? T

        assert(dependency != nil, "No dependency found")

        return dependency!
    }
}

@propertyWrapper
struct Inject<T> {
    var wrappedValue: T

    init() {
        self.wrappedValue = Resolver.resolve()
    }
}
