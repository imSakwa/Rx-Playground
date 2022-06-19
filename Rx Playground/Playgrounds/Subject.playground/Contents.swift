import RxSwift

let disposeBag = DisposeBag()

print("----PublishSubject----")
let publishSubject = PublishSubject<String>()

publishSubject.onNext("1. 안녕하세요.")

let 구독자1 = publishSubject
    .subscribe (onNext: {
        print("첫번째 구독자: \($0)")
    })

publishSubject.onNext("2. 감사해요.")
publishSubject.onNext("3. 잘있어요.")

구독자1.dispose()

let 구독자2 = publishSubject
    .subscribe(onNext: {
        print("두번째 구독자: \($0)")
    })

publishSubject.onNext("4. 다시만나요.")
publishSubject.onCompleted()

// Completed 된 이후에 방출된 이벤트는 읽지못함
publishSubject.onNext("5. 끝")

구독자2.dispose()

publishSubject.subscribe {
    print("세번째 구독:", $0.element ?? $0)
}
.disposed(by: disposeBag)

// pusblishSubject가 이미 끝나서 못 받음
publishSubject.onNext("6. 찍히나?")


print("----BehaviorSubject----")
enum SubjectError: Error {
    case error1
}

let behaviorSubject = BehaviorSubject<String>(value: "초기값")

behaviorSubject.onNext("1. 첫번째값")

behaviorSubject.subscribe {
    print("첫번째 구독:", $0.element ?? $0)
}
.disposed(by: disposeBag)

behaviorSubject.onError(SubjectError.error1)

behaviorSubject.subscribe {
    print("두번째 구독:", $0.element ?? $0)
}
.disposed(by: disposeBag)

let value = try? behaviorSubject.value()
print(value)


print("----ReplaySubject-----")
let replaySubject = ReplaySubject<String>.create(bufferSize: 2)

replaySubject.onNext("1. 하나")
replaySubject.onNext("2. 둘")
replaySubject.onNext("3. 셋")

replaySubject.subscribe {
    print("첫번째 구독:", $0.element ?? $0)
}
.disposed(by: disposeBag)

replaySubject.subscribe {
    print("두번째 구독:", $0.element ?? $0)
}
.disposed(by: disposeBag)

replaySubject.onNext("4. 넷")
replaySubject.onError(SubjectError.error1)
replaySubject.dispose()

replaySubject.subscribe {
    print("세번째 구독:", $0.element ?? $0)
}
.disposed(by: disposeBag)
