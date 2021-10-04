//
//  RepoModel.swift
//  GitSearch
//


import Foundation

// MARK: - Repository
struct Repository: Codable {
    let totalCount: Int?
    let incompleteResults: Bool?
    let items: [Item]?

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
    
    init(totalCount: Int? = 0, isIncomplete: Bool? = false, items: [Item]? = []) {
        self.totalCount = totalCount
        self.incompleteResults = isIncomplete
        self.items = items
    }
}

// MARK: - Item
struct Item: Codable, Identifiable {
    let id: Int?
    let owner: Owner?
    let htmlURL: String?

    enum CodingKeys: String, CodingKey {
        case id
        case owner
        case htmlURL = "html_url"
    }
}

extension Item: Hashable {
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Owner
struct Owner: Codable {
    let id: Int?
    let avatarURL: String?

    enum CodingKeys: String, CodingKey {
        case id
        case avatarURL = "avatar_url"
    }
}
