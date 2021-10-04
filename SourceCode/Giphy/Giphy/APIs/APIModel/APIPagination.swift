//
//  APIPagination.swift
//  Giphy
//

//MARK: - Structure APIPagination
/// It will used to get more datas from server
struct APIPagination {
    var pageNumber = 1
    var isAllLoaded = false
    var limit = 20
    var isLoading = false
    var offSet: Int {return pageNumber * limit}
    
    init(_ pageNumber: Int = 1, limit: Int = 10) {
        self.pageNumber = pageNumber
        self.limit = limit
    }
    
    func getRequestParameters() -> [String : Any] {
        return ["offset" : offSet, "limit" : limit]
    }
    
    mutating func increasePageNumberBy(_ number: Int) {
        self.pageNumber += number
    }
    
    mutating func setISAllLoaded(_ isAllLoaded: Bool) {
        self.isAllLoaded = isAllLoaded
    }
}
