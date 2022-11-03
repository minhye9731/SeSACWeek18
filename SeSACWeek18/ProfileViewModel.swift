//
//  ProfileViewModel.swift
//  SeSACWeek18
//
//  Created by 강민혜 on 11/3/22.
//

import Foundation
import RxSwift

class ProfileViewModel {
    
    let profile = PublishSubject<Profile>()
    
    func getProfile() {
        
        let api = SeSACAPI.profile
        Network.share.requestSeSAC(type: Profile.self, url: api.url, headers: api.headers) { [weak self] response in
            
            switch response {
            case .success(let success):
                self?.profile.onNext(success)
            case .failure(let failure):
                self?.profile.onError(failure)
            }
        }
    }
    
    
}
