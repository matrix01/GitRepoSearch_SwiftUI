//
//  GitSearchApp.swift
//  GitSearch
//


import SwiftUI

@main
struct GitSearchApp: App {
    var body: some Scene {
        WindowGroup<RepoSearchListView> {
            RepoSearchListView(viewModel: RepoSearchViewModel())
        }
    }
}
