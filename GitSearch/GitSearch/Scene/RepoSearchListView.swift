//
//  RepoSearchList.swift
//  GitSearch
//


import SwiftUI
import Combine

struct RepoSearchListView: View {
    @ObservedObject var viewModel = RepoSearchViewModel()
    
    init(viewModel: RepoSearchViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Git search")
                    .font(Font.title.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                SearchBar(title: "Type your repo name...", text: $viewModel.searchText)
                List (viewModel.itmes, id: \.id) { item in
                    Text(item.htmlURL ?? "")
                }
            }
            .navigationBarHidden(true)
        }
        
    }
}

struct Repo_Previews: PreviewProvider {
    static var previews: some View {
        RepoSearchListView(viewModel: RepoSearchViewModel())
    }
}
