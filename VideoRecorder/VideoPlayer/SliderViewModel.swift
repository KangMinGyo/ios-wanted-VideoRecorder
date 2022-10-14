//
//  SliderViewModel.swift
//  VideoRecorder
//
//  Created by CodeCamper on 2022/10/12.
//

import Foundation
import UIKit
import Combine

class SliderViewModel {
    // MARK: Input
    enum Action {
        case updateProgress(Double)
        case setIsEditingCurrentTime(Bool)
    }
    
    // MARK: Output
    @Published var progress: Double = 0.8
    @Published var isEditingCurrentTime: Bool = false
    
    // MARK: Properties
    var action = PassthroughSubject<Action, Never>()
    var subscriptions = [AnyCancellable]()
    
    // MARK: Life Cycle
    init() {
        action
            .sink(receiveValue: { [weak self] action in
                guard let self else { return }
                self.mutate(action: action)
            })
            .store(in: &subscriptions)
    }
    
    // MARK: Mutate
    func mutate(action: Action) {
        switch action {
        case .updateProgress(let progress):
            if self.progress != progress {
                self.progress = progress
            }
        case .setIsEditingCurrentTime(let isEditing):
            if isEditingCurrentTime != isEditing {
                isEditingCurrentTime = isEditing
            }
        }
    }
}