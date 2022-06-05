import RxSwift

let disposeBag = DisposeBag()

print("--------startWith---------")
let 노랑반 = Observable.of("A","B","C")

노랑반
    .enumerated()
    .map { index, element in
        return "\(index)" + "." + element + " 다음"
    }
    .startWith("내가 먼저") // 동일한 타입이여야 함
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("--------concat1---------")
let 노랑반애들 = Observable.of("A","B","C")
let 선생님 = Observable.of("선생님")

let 줄서서걷기 = Observable
    .concat([선생님, 노랑반애들])

줄서서걷기
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("--------concat1---------")
선생님
    .concat(노랑반애들)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("--------concatMap---------")
let 어린이집: [String:Observable<String>] = [
    "노랑반" : Observable.of("A","B","C"),
    "파랑반" : Observable.of("a","b","c")
]

Observable.of("노랑반", "파랑반")
    .concatMap { 반 in
        어린이집[반] ?? .empty()
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("--------merge1---------")
let 강북 = Observable.from(["강북구","성북구","동대문구","종로구"])
let 강남 = Observable.from(["강남구","강동구","영등포구","양천구"])

Observable.of(강북, 강남)
    .merge() // 순서를 고려하지 않고 합쳐짐
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("--------merge2---------")

Observable.of(강북,강남)
    .merge(maxConcurrent: 1) //
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("--------combineLatest1---------")
let 성 = PublishSubject<String>()
let 이름 = PublishSubject<String>()

let 성명 = Observable
    .combineLatest(성, 이름) { 성, 이름 in
        성 + 이름
    }

성명
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

성.onNext("김")
이름.onNext("똘똘")
이름.onNext("영수")
이름.onNext("은영")

성.onNext("박")
성.onNext("이")
성.onNext("조")

print("--------combineLatest2---------")
let 날짜표시형식 = Observable<DateFormatter.Style>.of(.short, .long)
let 현재날짜 = Observable<Date>.of(Date())

let 현재날짜표시 = Observable
    .combineLatest(날짜표시형식, 현재날짜) { 형식, 날짜 -> String in
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = 형식
        
        return dateformatter.string(from: 날짜)
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("--------combineLatest3---------")
let lastName = PublishSubject<String>()
let firstName = PublishSubject<String>()

let fullName = Observable
    .combineLatest([firstName,lastName]) { name in
        name.joined(separator: " ")
    }

fullName
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

lastName.onNext("Kim")
firstName.onNext("Paul")
firstName.onNext("Lily")

print("--------zip---------")
enum 승패 {
    case 승
    case 패
}

let 승부 = Observable<승패>.of(.승, .승, .패, .패, .승)
let 선수 = Observable<String>.of("A", "B", "C", "D")

let 결과 = Observable
    .zip(승부, 선수) { 결과, 대표선수 in
        return 대표선수 + "선수" + "  \(결과)"
    }

결과
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("--------withLatestFrom1---------")

let trigger = PublishSubject<Void>()
let 선수2 = PublishSubject<String>()

trigger
    .withLatestFrom(선수2)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

선수2.onNext("A")
선수2.onNext("B")
선수2.onNext("C")

trigger.onNext(Void())
trigger.onNext(Void())

print("--------sample---------")
let 출발 = PublishSubject<Void>()
let F1선수 = PublishSubject<String>()

F1선수
    .sample(출발)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

F1선수.onNext("A")
F1선수.onNext("A  B")
F1선수.onNext("A  B      C")

출발.onNext(Void())
출발.onNext(Void())


print("--------amb---------")
let 버스1 = PublishSubject<String>()
let 버스2 = PublishSubject<String>()

let 정류장 = 버스1.amb(버스2) // 둘다 지켜보다가 먼저 이벤트가 방출되는 것만 구독

정류장
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

버스2.onNext("c")
버스1.onNext("A")
버스1.onNext("B")
버스2.onNext("a")
버스1.onNext("C")
버스2.onNext("b")

print("--------switchLatest---------")
let 학생1 = PublishSubject<String>()
let 학생2 = PublishSubject<String>()
let 학생3 = PublishSubject<String>()

let 손들기 = PublishSubject<Observable<String>>()

let 손든사람만 = 손들기.switchLatest()

손든사람만
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

손들기.onNext(학생1)
학생1.onNext("1 : aaaaaa")
학생1.onNext("1 : bbbbbb")
학생2.onNext("2 : aaaaaa")

손들기.onNext(학생2)
학생1.onNext("1 : bbbbbb")
학생2.onNext("2 : bbbbbb")
학생3.onNext("3 : aaaaaaa")

손들기.onNext(학생3)
학생3.onNext("3 : aaaaa")
학생1.onNext("1 : bbbbbb")
학생2.onNext("2 : bbbbbb")
학생3.onNext("3 : bbbbbbb")

print("--------reduce---------")
Observable.from((1...10))
//    .reduce(0, accumulator: {summary, newValue in
//        return summary + newValue
//    })
//    .reduce(0) { summary, newValue in
//        return summary + newValue
//    }
    .reduce(0, accumulator: +)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("--------scan---------")
Observable.from((1...10))
    .scan(0, accumulator: +)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
