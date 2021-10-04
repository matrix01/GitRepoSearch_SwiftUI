//
//  NetworkRequest.swift
//  GitSearch
//


import Foundation
import Combine

// protocol
protocol RepoFetchable {
    func repositoryList(for endPoint: GitAPIs) -> AnyPublisher<Repository, RepoSearchError>
}

class NetworkService {
  private let session: URLSession
  
  init(session: URLSession = .shared) {
    self.session = session
  }
}

extension NetworkService: RepoFetchable {
    func repositoryList(for endPoint: GitAPIs) -> AnyPublisher<Repository, RepoSearchError> {
        return fetcher(with: endPoint)
    }
    
    private func fetcher<T>(with endPoint: GitAPIs) -> AnyPublisher<T, RepoSearchError> where T: Decodable {
        guard let request = endPoint.request else {
            let error = RepoSearchError.network(description: "Couldn't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        return session.dataTaskPublisher(for: request)
          .map { $0.data }
          .decode(type: T.self, decoder: JSONDecoder())
          .mapError { error in
            .parsing(description: error.localizedDescription)
          }
          .eraseToAnyPublisher()
    }
}
