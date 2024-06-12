//
//  OnboardingViewModel.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 12.06.2024.
//

import Foundation

extension OnboardingView {
    final class OnboardingViewModel: ObservableObject {
        @Published var showPrivacyPolicy = false
        let privacyPolicyURL = URL(string: "https://www.google.com")
    }
    
    enum OnboardingItem: Int, CaseIterable {
        case first = 0
        case second
        case third
        
        var imageName: String {
            switch self {
            case .first:
                return Asset.onboarding1.name
            case .second:
                return Asset.onboarding2.name
            case .third:
                return Asset.onboarding3.name
            }
        }
        
        var title: String {
            switch self {
            case .first:
                return "Добро пожаловать в мир финансовой ответственности!"
            case .second:
                return "С нами вы сможете оптимизировать ваш пассивный доход."
            case .third:
                return "Мы предоставим вам анализ вашего финансового состояния."
            }
        }
        
        var subtitle: String {
            switch self {
            case .first:
                return "Здесь вы вводите свои доходы, а мы поможем вам построить путь к финансовому процветанию."
            case .second:
                return "Получайте индивидуальные советы и прогнозы для достижения ваших финансовых целей!"
            case .third:
                return "Давайте вместе достигнем успеха!"
            }
        }
        
        var position: Int {
            rawValue
        }
        
        var count: Int {
            OnboardingItem.allCases.count
        }
    }
}
