//
//  Array.swift
//  Giphy
//

//MARK: - Array Opetation(s)
extension Array where Element: Equatable {

    /// It will remove an element from existing array.
    /// - Parameter element: Equatable protocol object, which you want to remove.
    public mutating func remove(_ element: Element) {
        if let index = firstIndex(of: element) {
            remove(at: index)
        }
    }
    
    /// It will remove multiple elements from existing array.
    /// - Parameter elements: Equatable protocol objects, which you want to remove.
    public mutating func remove(_ elements: [Element]) {
        for element in elements {
            remove(element)
        }
    }
}
