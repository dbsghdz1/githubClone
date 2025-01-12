//
//  Project+Ex.swift
//  Manifests
//
//  Created by 김윤홍 on 1/12/25.
//

import ProjectDescription

extension Configuration {
    public static func build(_ type: BuildTarget, name: String = "") -> Self {
        let buildName = type.rawValue
        switch type {
        case .dev:
            return .debug(
                name: BuildTarget.dev.configurationName,
                xcconfig: .relativeToXCConfig(type: .dev)
            )
        case .prd:
            return .release(
                name: BuildTarget.prd.configurationName,
                xcconfig: .relativeToXCConfig(type: .prd)
            
            )
        }
    }
}
