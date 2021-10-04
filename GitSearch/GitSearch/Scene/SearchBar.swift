//
//  SearchBar.swift
//  GitSearch
//


import SwiftUI
import Combine

struct SearchBar: UIViewRepresentable {

    var title: String
    @Binding var text: String

    class Coordinator: NSObject, UISearchBarDelegate {
        var title: String
        @Binding var text: String

        init(title: String, text: Binding<String>) {
            self.title = title
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }
    
    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(title: title, text: $text)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.autocapitalizationType = .none
        searchBar.placeholder = title
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}
