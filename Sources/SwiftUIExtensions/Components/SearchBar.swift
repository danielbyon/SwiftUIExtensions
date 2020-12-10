//
//  SearchBar.swift
//
//  Copyright 2020 Daniel Byon.
//
//  Permission is hereby granted, free of charge, to any person obtaining a
//  copy of this software and associated documentation files (the "Software"),
//  to deal in the Software without restriction, including without limitation
//  the rights to use, copy, modify, merge, publish, distribute, sublicense,
//  and/or sell copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
//  DEALINGS IN THE SOFTWARE.
//

#if os(iOS) || os(tvOS)

import SwiftUI
import UIKit

public struct SearchBar: UIViewRepresentable {

    @Binding public var text: String
    public var placeholder: String

    public class Coordinator: NSObject, UISearchBarDelegate {

        @Binding var text: String

        private var pendingUpdate: DispatchWorkItem?

        init(text: Binding<String>) {
            _text = text
        }

        public func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
            searchBar.setShowsCancelButton(true, animated: true)
            return true
        }

        public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            pendingUpdate?.cancel()
            if searchText.isEmpty {
                // Immediately update if the text is empty
                text = searchText
            } else {
                pendingUpdate = DispatchWorkItem {
                    self.text = searchText
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: pendingUpdate!)
            }
        }

        public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            text = ""
            searchBar.setShowsCancelButton(false, animated: true)
            searchBar.searchTextField.resignFirstResponder()
        }

        public func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
            searchBar.setShowsCancelButton(false, animated: true)
            return true
        }

    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }

    public func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = placeholder
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        return searchBar
    }

    public func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }

}

#endif
