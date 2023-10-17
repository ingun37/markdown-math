//
//  AppState.swift
//  markdown-math
//
//  Created by Ingun Jon on 10/17/23.
//

import Foundation
class AppState: ObservableObject {
    @Published var markdownContent: String
    init(_ markdownContent: String) {
        self.markdownContent = markdownContent
    }
}
