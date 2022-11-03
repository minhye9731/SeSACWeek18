//
//  ViewController.swift
//  SeSACWeek18
//
//  Created by 강민혜 on 11/2/22.
//

import UIKit
import RxSwift

// Index out of range .... 런타임 오류는 못참지..

class ViewController: UIViewController {

//    let api = APIService() // 11/2
    
    @IBOutlet weak var label: UILabel!
    
    let viewModel = ProfileViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // subscript 구조체 확장 실습
        let phone = Phone()
        print(phone.numbers[2])
        print(phone[2]) // 직역하면 '구조체에서 2번을 부르고 싶어'. 어색하게 들리겠지만 확장해서 하면 가능.
        
//        api.login() 11/2
//        api.profile() 11/2
        
        viewModel.profile // <Single>, Syntax Sugar
            .withUnretained(self)
            .subscribe { (vc, value) in
//                print(value.user.email)
//                print(value.user.username)
                vc.label.text = value.user.email
            } onError: { error in
                print(error.localizedDescription)
            }
            .disposed(by: disposeBag)
        
        // subscribe , bind , drive
        // driver vs. singal
        
        viewModel.getProfile()
        checkCOW()
    }
    
    // MARK: - copy-on-write 개념
    // 값 타입, 참조 타입 (8회차)
    // but 값 타입임에도 참조하는 경우가 있다!
    func checkCOW() {
        
        var test = "jack"
        // inout 매개변수, &
        address(&test) // 0x16b353828, struct는 값타입
        
        print(test[2])
        print(test[200])
                
        var test2 = test
        address(&test2) // 0x16b353818, struct는 값타입이고, 값만 줬으니까 새로운 주소 출력됨
        
        test2 = "sesac"
        address(&test) // 0x16b353828
        address(&test2) // 0x16b353818
        
        print("=========")
        var array = Array(repeating: "A", count: 100) // Array, Dictionary, Set == Collection
        address(&array) // 0x128827e20
        
        // index를 indices로 이렇게 가져오면 index out of range 안나고 안전하고 좋다~
        print(array[safe: 99])
        print(array[safe: 199])
        
        var newArray = array
        address(&newArray) // 0x128827e20 -> 신규 메모리주소일 줄 알았는데,, 같은 주소가 나온다?
        // 왜냐? 실제로 복사 안함! 원본을 공유하고 있음! -> 메모리 효율성을 위해서 같은 메모리를 공유함. 성능향상을 위해 자체적으로 그렇게 작동함! 와우 스마트하다
        
        newArray[0] = "B"
        
        address(&array) // 0x128827e20
        address(&newArray) // 0x12882a820
        
        
    }

    func address(_ value: UnsafeRawPointer) {
        let address = String(format: "%p", Int(bitPattern: value))
        print(address)
    }

}

