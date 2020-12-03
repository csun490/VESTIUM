//  SettingsSection.swift
//  SlideInTransition
//
//  Created by demi on 11/21/20.
//  Copyright © 2020 CSUN-Vestium. All rights reserved.
//

enum SettingsSection: Int, CaseIterable, CustomStringConvertible{
    case Social
    case Communications
    
    var description: String{
        switch self{
        case .Social: return "Profile"
        case .Communications: return "General"
        }
    }
}

enum SocialOptions: Int, CaseIterable, CustomStringConvertible{
    case editProfile
    case logout
    var description: String{
        switch self{
        case .editProfile: return "Change Profile Picture"
        case .logout: return "Logout"
        }
    }
}

enum CommunicationOptions: Int, CaseIterable, CustomStringConvertible{
    case useMetricSystem
    case email
    case reportCrashes
    var description: String{
        switch self{
        case .useMetricSystem: return "Use Metric System"
        case .email: return "Email"
        case .reportCrashes: return "Report Crashes"
        }
    }
}
