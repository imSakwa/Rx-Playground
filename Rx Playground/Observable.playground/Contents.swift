import Foundation
import RxSwift

// Observable은 정의다. Subscribe하기 전까지는..
// just -> 단 하나의 요소만 갖는 옵져버블 시퀀스 생성
print("----just----")
Observable<Int>.just(1)
    .subscribe(onNext: {
        print($0)
    })

print("----of----")
// of -> 1개 이상의 이벤트들을 갖는 옵져버블 시퀀스 생성
Observable<Int>.of(1,2,3,4,5)
    .subscribe(onNext: {
        print($0)
    })

print("----of? just?----")
// 이건 just연산자 사용과 동일하다. 타입은 추론.
Observable.of([1,2,3,4,5])
    .subscribe(onNext: {
        print($0)
    })

print("----from----")
// from -> array형태의 요소만 갖음, 배열에서 하나씩 뽑아서 방출
Observable.from([1,2,3,4,5])  .subscribe(onNext: {
        print($0)
    })

print("----subscribe1----")
Observable.of(1,2,3)
    .subscribe {
        print($0)
    }

print("----subscribe2----")
Observable.of(1,2,3)
    .subscribe {
        if let element = $0.element {
            print(element)
        }
    }

print("----subscribe3----")
Observable.of(1,2,3)
    .subscribe(onNext: {
        print($0)
    })


// empty는 이벤트를 방출하지 않음
print("----empty----")
Observable.empty()
    .subscribe{
        print($0)
    }

// never는 아무것도 방출하지 않음. Complted조차. .debug를 통해 동작하는지 확인 가능
print("----never---")
Observable.never()
    .subscribe(
        onNext: {
            print($0)
        },
        onCompleted: {
            print("Completed")
        }
    )

// range는 1...9 반복해서 방출
print("----range----")
Observable.range(start: 1, count: 9)
    .subscribe(onNext: {
        print("2*\($0) = \(2*$0)")
    })


// dispose -> subscribe를 취소
print("----dispose----")
Observable.of(1,2,3)
    .subscribe(onNext: {
        print($0)
    })
    .dispose()


// disposeBag ->
print("----disposeBag----")
let disposeBag = DisposeBag()
Observable.of(1,2,3)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("----create1----")
Observable.create { observer -> Disposable in
    observer.onNext(1)
    observer.onCompleted()
    observer.onNext(2)
    return Disposables.create()
}
.subscribe {
    print($0)
}
.disposed(by: disposeBag)

print("----create2----")
enum MyError: Error {
    case anError
}

Observable.create { observer -> Disposable in
    observer.onNext(1)
    observer.onError(MyError.anError)
    observer.onCompleted()
    observer.onNext(2)
    return Disposables.create()
}
.subscribe(
    onNext: {
        print($0)
    },
    onError: {
        print($0.localizedDescription)
    },
    onCompleted: {
        print("Completed")
    },
    onDisposed: {
        print("Disposed")
    }
)
.disposed(by: disposeBag)


// deffered -> Observable 안에 Observable 생성 가능
print("----deffered1----")
Observable.deferred {
    Observable.of(1,2,3)
}
.subscribe {
    print($0)
}
.disposed(by: disposeBag)

print("----deffered2----")
var 뒤집기: Bool = false

let factory: Observable<String> = Observable.deferred {
    뒤집기 = !뒤집기
    
    if 뒤집기 {
        return Observable.of("👍")
    } else {
        return Observable.of("👎")
    }
}

for _ in 0...3 {
    factory.subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
}
