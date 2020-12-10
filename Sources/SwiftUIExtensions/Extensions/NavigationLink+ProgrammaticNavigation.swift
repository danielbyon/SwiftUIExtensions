//
//  NavigationLink+ProgrammaticNavigation.swift
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

import SwiftUI

// https://fivestars.blog/swiftui/programmatic-navigation.html
public extension NavigationLink where Label == EmptyView {

    init?<V: Identifiable>(
        item: Binding<V?>,
        destination: @escaping (V) -> Destination) {
        guard let value = item.wrappedValue else { return nil }

        let isActive: Binding<Bool> = Binding(
            get: { item.wrappedValue != nil },
            set: { value in
                // There's shouldn't be a way for SwiftUI to set `true` here.
                if !value {
                    item.wrappedValue = nil
                }
            }
        )

        self.init(
            destination: destination(value),
            isActive: isActive,
            label: { EmptyView() }
        )
    }

}

public extension View {

    func navigation<V: Identifiable, Destination: View>(
        item: Binding<V?>,
        destination: @escaping (V) -> Destination) -> some View {
        background(NavigationLink(item: item, destination: destination))
    }

}
