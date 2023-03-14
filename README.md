# 소셜 미디어 피드 프로젝트
- 개발 기간: 2023.03.08 ~ 2023.03.14(7일)

## 개발 환경 및 설정
- Swift 5.7
- Xcode 14.2
- 최소 지원 버전: iOS 11.0
- 세로모드

## 사용 기술
| category | stack |
| --- | --- |
| 아키텍처 | `MVVM` |
| 라이브러리 | `SnapKit / RxSwift`  |
| 의존성관리 | `Swift Package Manager` |
| Tools | `Git / Github` |
| ETC | `Toast / Alamofire` |

## 개발 고려 사항

### 앱의 확장성 및 유지보수 측면 고려
- BaseViewController, BaseView, BaseCollectionViewCell를 활용하여 서브 클래스들의 중복되는 코드를 관리했습니다.
- Raw/literal한 값들을 enum으로 관리하고, extension을 활용해 반복적으로 사용되는 코드를 함수로 정의했습니다
```
extension Int {
    func toThousands() -> String {
        var result: String
        
        if self < 1000 {
            result = String(self)
        } else {
            result = String(format: "%.1f", Double(self)/1000) + "k"
        }
        return result
    }
}
```

### 런타임 에러 방지하려고 노력
- 앱 Crash를 유발할 수 있는 에러가 런타임에 발생하지 않도록 Optional 바인딩을 강제 해제하지 않고 index error가 발생할 수 있는 서브스크립트 사용을 지양하는 방어적인 코드를 작성하려고 했습니다.
- 첫 화면에서 API 에러가 발생하는 경우 다시 시도하기 버튼을 띄웠고, 페이지네이션 중 API 에러가 발생하면 에러 발생 이유를 알리는 Toast를 띄웠습니다.

### 최소 지원 버전 iOS 11.0
- 평소 자주 사용하는 코드들을 최소 지원 버전에 맞춰 오류 없이 변경하려고 노력했습니다
    - ex. UIImage 로드 시 systemName 아닌 named 사용, Kingfisher 사용 불가(최소 지원 버전: iOS 12.0)
- SceneDelegate는 iOS 13.0 버전 이상부터만 실행되게 설정했습니다

## 미완성 기능
### 피드 스크롤시 포커스 되는 영역에 따라, 영상이 플레이 / 정지 되어야 하는 기능
- BehaviorRelay인 currentCellIndexPath에 해당 cell의 indexPath를 스크롤 될 때마다 저장하고 영상이 스크롤되는 경우 currentCellIndexPath와 비교하여 값이 다르면 영상이 정지되게 구현하려고 했습니다
- Viewmodel의 currentCellIndexPath에서 nil값만 반환을 해서 구현에 실패하였습니다

### 포스트 설명 TextView 더보기 기능

## 5. 회고

### 아쉬움
- 하나의 ViewModel에서 모든 클래스들의 비즈니스 로직을 담당하다 보니 비즈니스 로직의 결합도 본래 의도보다 높게 개발이 됐습니다.
    -   원인: 초기에 개발 공수산정을 하는 과정에서 프로젝트 구조를 잘못 계획했습니다
        - 하나의 CollectionView만으로 구현하려고 했으나 CollectionView Cell안에 CollectionView를 중첩적으로 구현하면서 CollectionView Cell이 4종류로 늘어나 이후부터는 구조 변경이 힘들다 판단하여 기능 개발에만 집중하게 됐습니다.
