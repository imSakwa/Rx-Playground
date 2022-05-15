import RxSwift

let disposebag = DisposeBag()

// next 이벤트를 무시하는 연산자
print("----ignoreElements----")
let 취침모드 = PublishSubject<String>()

취침모드
    .ignoreElements()
    .subscribe { _ in
        print("🔆")
    }
    .disposed(by: disposebag)

취침모드.onNext("⚡️")
취침모드.onNext("⚡️")
취침모드.onNext("⚡️")

취침모드.onCompleted() // subscribe에 이벤트가 방출됨 (completed 이벤트)


// 특정 인덱스에 해당하는 이벤트만 방출하는 필터링 연산자
print("----elementAt----")
let 두번울면깨는사람 = PublishSubject<String>()

두번울면깨는사람
    .element(at: 2)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposebag)


두번울면깨는사람.onNext("⚡️") // index 0
두번울면깨는사람.onNext("⚡️") // index 1
두번울면깨는사람.onNext("😭") // index 2
두번울면깨는사람.onNext("⚡️") // index 3


print("----filter----")
Observable.of(1,2,3,4,5,6,7,8)
    .filter { $0 % 2 == 0 }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposebag)


print("----skip----")
Observable.of("😀", "🤣", "😌", "😇", "😎")
    .skip(3)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposebag)

// 로직이 false된 이후로의 이벤트 방출
print("----skipWhile----")
Observable.of("😀", "🤣", "😌", "😇", "😎", "🥳", "🤩")
    .skip(while: {
        $0 != "😇"
    })
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposebag)


// 다른 옵저버블이 onNext 이벤트를 방출한 후에 현재 옵저버블의 이벤트를 방출
print("----skipUntil----")
let 손님 = PublishSubject<String>()
let 문여는시간 = PublishSubject<String>()

손님
    .skip(until: 문여는시간)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposebag)

손님.onNext("😀")
손님.onNext("😃")

문여는시간.onNext("문 열림")

손님.onNext("😁")

// skip과 반대 개념
print("----task----")
Observable.of("🏅", "🥈", "🥉", "😀", "🤩")
    .take(3)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposebag)

// skipWhile과 반대 개념
print("----taskWhile----")
Observable.of("🏅", "🥈", "🥉", "😀", "🤩")
    .take(while: {
        $0 != "🥉"
    })
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposebag)


// 방출된 요소의 인덱스를 참고하고 싶을 때 사용
print("----enumerated----")
Observable.of("🏅", "🥈", "🥉", "😀", "🤩")
    .enumerated()
    .takeWhile {
        $0.index < 3
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposebag)


// SkipUntil과 반대 개념
print("----takeUntil----")
let 수강신청 = PublishSubject<String>()
let 신청마감 = PublishSubject<String>()

수강신청
    .take(until: 신청마감)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposebag)

수강신청.onNext("📕")
수강신청.onNext("👹")

신청마감.onNext("마감")
수강신청.onNext("🤠")

// 연달아 이어지는 중복된 값들을 무시
print("----distinctUntilChanged----")
Observable.of("가", "가", "나", "나", "나", "다", "다", "다", "라", "마", "마", "가")
    .distinctUntilChanged()
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposebag)
