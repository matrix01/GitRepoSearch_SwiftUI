//
//  RepoSearchModel.swift
//  GitSearch
//


import Foundation
import Combine

class RepoSearchViewModel: ObservableObject {
    @Published var itmes: [Item] = []
    @Published var searchText: String = ""

    private let networkService: NetworkService
    private var disposables = Set<AnyCancellable>()
    
    init(networkService: NetworkService = NetworkService(),
         scheduler: DispatchQueue = DispatchQueue(label: "RepoSearchViewModel")) {
        self.networkService = networkService
        $searchText
            .dropFirst(1)
            .throttle(for: 1, scheduler: scheduler, latest: false)
            .sink(receiveValue: fetchRepos(for:))
            .store(in: &disposables)
    }
    
    func fetchRepos(for text: String) {
        networkService.repositoryList(for: .search(searchText: text))
            .map { $0.items }
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink (receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure:
                    self.itmes = []
                case .finished:
                  break
                }
              },
                receiveValue: {[weak self] repoValue in
                guard let self = self else { return }
                self.itmes = repoValue ?? []
            })
            .store(in: &disposables)
    }
    
    func cancel() {
        self.disposables.forEach {
            $0.cancel()
        }
    }
}

public extension Array where Element: Hashable {
  static func removeDuplicates(_ elements: [Element]) -> [Element] {
    var seen = Set<Element>()
    return elements.filter{ seen.insert($0).inserted }
  }
}
