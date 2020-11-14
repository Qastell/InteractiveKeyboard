//
//  Vibration.swift
//  101group
//
//  Created by Yuri Kudrinetskiy on 27.10.2019.
//  Copyright © 2019 Yuri Kudrinetskiy. All rights reserved.
//

import AVFoundation
import UIKit

enum Vibration {
    case error
    case success
    case warning

    case selection

    case light
    case medium
    case heavy

    @available(iOS 13.0, *)
    case soft

    @available(iOS 13.0, *)
    case rigid

    case oldSchool

    func vibrate() {
        guard isHapticsSupported, !isIphone6sOr6sPlus else {
            switch self {
            case .light,
                 .soft:
                if isIphone6sOr6sPlus {
                    Taptics.pop.vibrate()
                }
            case .selection:
                if isIphone6sOr6sPlus {
                    Taptics.peek.vibrate()
                }
            case .success:
                if isIphone6sOr6sPlus {
                    Taptics.pop.vibrate()
                } else {
                    Taptics.basic.vibrate()
                }
            case .warning,
                 .medium,
                 .heavy,
                 .rigid,
                 .oldSchool:
                Taptics.basic.vibrate()
            case .error:
                Taptics.alert.vibrate()
            }
            return
        }

        switch self {
        case .error:
            UINotificationFeedbackGenerator().notificationOccurred(.error)
        case .success:
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        case .warning:
            UINotificationFeedbackGenerator().notificationOccurred(.warning)
        case .selection:
            UISelectionFeedbackGenerator().selectionChanged()
        case .light:
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        case .medium:
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        case .heavy:
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        case .soft:
            if #available(iOS 13.0, *) {
                UIImpactFeedbackGenerator(style: .soft).impactOccurred()
            }
        case .rigid:
            if #available(iOS 13.0, *) {
                UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
            }
        case .oldSchool:
            Taptics.basic.vibrate()
        }
    }

    private var isHapticsSupported: Bool {
        let feedback = UIImpactFeedbackGenerator(style: .heavy)
        feedback.prepare()
        return !UIImpactFeedbackGenerator(style: .heavy).debugDescription.contains("prepared=0")
    }

    private var isIphone6sOr6sPlus: Bool {
        var sysinfo = utsname()
        uname(&sysinfo)
        let model = String(bytes: Data(bytes: &sysinfo.machine,
                                       count: Int(_SYS_NAMELEN)),
                           encoding: .ascii)?
            .trimmingCharacters(in: .controlCharacters)
        return model == "iPhone8,1" || model == "iPhone8,2"
    }

    public enum Taptics: Int {
        /// Basic 1-second vibration
        case basic = 4095
        /// Two short consecutive vibrations
        case alert = 1011

        /// Weak boom
        case peek = 1519

        /// Strong boom
        case pop = 1520

        /// Three sequential weak booms
        case cancelled = 1521

        /// Weak boom then strong boom
        case tryAgain = 1102

        func vibrate(completion: (() -> Void)? = nil) {
            AudioServicesPlaySystemSoundWithCompletion(SystemSoundID(rawValue)) {
                completion?()
            }
        }
    }
}
