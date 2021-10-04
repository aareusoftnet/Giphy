//
//  Dictionary.swift
//  Giphy
//

//MARK: - Dictionary Extension(s)
extension Dictionary {
    
    /// It will merge existing dictionary with provided dictionary.
    /// - Parameter other: A `Dictionary` type object to merge with existance dictionary.
    public mutating func merge(_ other: Dictionary) {
        for (key,value) in other {
            updateValue(value, forKey:key)
        }
    }
}
