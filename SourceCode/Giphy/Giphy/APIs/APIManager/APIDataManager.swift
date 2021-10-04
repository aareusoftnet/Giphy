//
//  APIDataManager.swift
//  Giphy
//

import UIKit
import Combine

class APIDataManager {
    private var publisher: AnyPublisher<GiphyTrending, Error> {
        let trendingEndPoint = GiphyEndPoint.trending(parameters: ["api_key" : GiphyAPIKey])
        var url = URLComponents(string: trendingEndPoint.URL)!
        url.queryItems = [
            URLQueryItem(name: "api_key", value: GiphyAPIKey)
        ]
        url.percentEncodedQuery = url.percentEncodedQuery?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return URLSession.shared.dataTaskPublisher(for: url.url!)
            .map{ $0.data }
            .decode(type: GiphyTrending.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    private var subscriber: AnyCancellable?

    func fetchTrendingGiphies(_ completionBlock: ((GiphyTrending) -> ())? = nil) {
        subscriber = publisher.sink(receiveCompletion: {_ in} , receiveValue: {(giphyTrending) in
            DispatchQueue.main.async {completionBlock?(giphyTrending)}
        })
    }
}
