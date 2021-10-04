//
//  GitSearchError.swift
//  GitSearch
//


import Foundation

enum RepoSearchError: Error {
  case parsing(description: String)
  case network(description: String)
}
