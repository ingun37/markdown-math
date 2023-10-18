//
//  AppState.swift
//  markdown-math
//
//  Created by Ingun Jon on 10/17/23.
//

import Foundation
import SwiftDown
class AppState: ObservableObject {
    @Published var markdownContent: String
    @Published var selectedrange: (NSRange, MarkdownNode?) = (NSRange(), nil)

    init(_ markdownContent: String) {
        self.markdownContent = markdownContent
    }
}
