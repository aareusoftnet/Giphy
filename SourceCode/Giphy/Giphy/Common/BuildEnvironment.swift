//
//  BuildEnvironment.swift
//  Giphy
//

//MARK: - Enum BuildEnvironment
enum BuildEnvironment {
    case debug, inHouse, release
    static let isProduction: Bool = {
        #if DEBUG || INHOUSE
            return false
        #else
            return true
        #endif
    }()

}
