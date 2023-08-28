//
//  MyScriptSampleDelegate.swift
//  markdown-math
//
//  Created by Ingun Jon on 2023/08/24.
//

import Foundation

protocol MyScriptSampleDelegate {
    func cancel()
    func done(tex:String)
}
