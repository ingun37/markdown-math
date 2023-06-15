//
//  Delimeter.swift
//  markdown-math
//
//  Created by Ingun Jon on 2023/05/27.
//

import Foundation

struct Delimeter {
    var start: String
    var end: String
}

struct DelimeterStyle {
    var inline: Regex<Substring>
    var block: Delimeter
}

enum DelimeterType: String, CaseIterable, Identifiable {
    func style() -> DelimeterStyle {
        switch self {
        case .GitLab: return DelimeterStyle(inline: /\$`.+?`\$/, block: Delimeter(start: "```math", end: "```"))
        }
    }

    var id: Self { self }
    case GitLab
}

enum MathFormatType: String, CaseIterable, Identifiable {
    func header() -> String {
        switch self {
        case .Katex:
            return """
            <!DOCTYPE html>
            <head>
                <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/katex@0.16.7/dist/katex.min.css" integrity="sha384-3UiQGuEI4TTMaFmGIZumfRPtfKQ3trwQE2JgosJxCnGmQpL/lJdjpcHkaaFwHlcI" crossorigin="anonymous">

                <!-- The loading of KaTeX is deferred to speed up page rendering -->
                <script defer src="https://cdn.jsdelivr.net/npm/katex@0.16.7/dist/katex.min.js" integrity="sha384-G0zcxDFp5LWZtDuRMnBkk3EphCK1lhEf4UEyEM693ka574TZGwo4IWwS6QLzM/2t" crossorigin="anonymous"></script>

                <!-- To automatically render math in text elements, include the auto-render extension: -->
                <script defer src="https://cdn.jsdelivr.net/npm/katex@0.16.7/dist/contrib/auto-render.min.js" integrity="sha384-+VBxd3r6XgURycqtZ117nYw44OOcIax56Z4dCRWbxyPt0Koah1uHoK0o4+/RRE05" crossorigin="anonymous"
                    onload="renderMathInElement(document.body);"></script>
              </head>
            """
        }
    }

    var id: Self { self }
    case Katex
}
