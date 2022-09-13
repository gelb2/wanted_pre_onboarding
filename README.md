# README

# 기본구조

### MVVM

- MVVM 패턴을 시도해보고자 하였음
- 이를 위해 UIViewController, UICollectionViewCell에서 최대한 비즈니스로직, UI 관련 로직을 줄이고자 하였음.
비즈니스로직은 모델, 뷰모델로, UI관련 로직은 커스텀하게 만든 UIView로 분산시킴
- 모델, 뷰모델, 뷰간에 일어날 수 있는 데이터의 흐름은 클로저를 통해 처리함.

### Entity

- 모델, 뷰모델 클래스가 Codable을 채택하여 서버에서 받은 JSON을 디코딩하는 Codable연관 코드를 갖고있는 것은 모델, 뷰모델 클래스의 코드 길이가 커질수 있음을 우려, Codable을 채택한 별도의 Entity 구조체를 만듬.
- 모델, 뷰모델은 Entity를 전달받고, 전달받은 Entity에 기반해 필요한 모델링을 진행함

### 뷰컨트롤러 프리젠테이션

- 뷰컨트롤러 프리젠트, 네비게이션 푸시와 같은 사항은 Routable, Scenable, SceneBuildable 프로토콜을 별도로 만들어서 구현함
- Routable, SceneBuildable은 어느 뷰컨트롤러를 띄울 것인가, 뷰컨트롤러를 어떻게 만들 것인가에 대한 프로토콜임
- 특정 뷰컨트롤러에 맞는 Routable, SceneBuildable이 필요하다면 Routable, SceneBuildable 프로토콜을 채택한 별도의 111ViewControllerRoutable, 111SceneBuildable과 같은 프로토콜을 만들고 이 만든 프로토콜을 그 뷰컨트롤러가 채택하도록 처리함.
- 모델 클래스는 연관된 뷰모델 클래스로부터 특정한 알림(클로저로 처리된)을 받으면 “어느 뷰컨트롤러를 띄워야 할지, 어느 얼럿을 띄워야 할지"와 연관된 로직을 수행하며, 수행된 로직에 따라 띄울 뷰컨트롤러를 정하고 이를 뷰컨트롤러에 알림
알림을 받은 뷰컨트롤러는 채택한 프로토콜(Routable, SceneBuildable)에 정의된 메소드를 호출하게됨
- Routable, SceneBuildable은 다음 뷰컨트롤러의 타입이 무엇인가에 대한 Enum을 받음(SceneCategory)
이 Enum은 연관값으로 SceneContext라는 별도의 클래스타입 값을 받으며 이 값은 다음 뷰컨트롤러에 주입할 모델을 감싼 것임.

### 뷰컨트롤러의 의존성 주입

- Routable, SceneBuildable, Scenable, SceneCategory은 뷰컨트롤러 띄우기, 만들기, 띄울 뷰컨트롤러 정하기와 관련된 프로토콜임
- SceneContext는 뷰컨트롤러에 주입할 모델 객체를 내부적으로 들고 있는 클래스로, 내부에 제네릭 형태로 모델 객체를 들고 있을 수 있도록 구성됨

---

# UI 구현

### 코드기반 UI

- 스토리보드, xib 미사용
- 오토레이아웃으로 컨스트레인트 설정
- UICollectionViewCell, UIViewController에는 별도의 UI요소를 붙이지 않음
대신 UIView를 필요에 따라 2,3개 만들어서 각 셀, 뷰컨트롤러에 addsubview하는 방식으로 구현함
- 셀, 뷰컨트롤러에 addsubview된 UIView가 컬렉션뷰, 이미지뷰, 버튼, 텍스트필드 등의 UI요소를 가지고 있음.
- UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate와 같은 프로토콜 채택은 해당 컬렉션뷰, 텍스트필드를 가진 UIView가 채택함
해당 델리게이트에서 호출이 들어오면 해당 뷰의 로직을 관장하는 뷰모델로 필요한 사항을 전달하도록 처리됨

### UI 속성 설정 위한 별도의 프로토콜

- Presentable
뷰컨트롤러, 뷰에서 뷰 하이어라키 설정, 오토레이아웃 설정 등 기본적인 사항을 진행할 시 모든 뷰컨트롤러, 뷰가 어느정도는 정해진 순서대로 절차를 진행해야 코드 가독성이 높아질 것으로 생각되어 뷰컨트롤러, 뷰가 따를 수 있는 Presentable 프로토콜을 만듬.
이는 강한 제약사항을 위한 것은 아니나 추후에 다른 프로토콜과 합성하거나, 프로토콜의 익스텐션에서 타입별로 제약을 주는 식으로 응용이 가능할 것이기에 추가한 것임.
- Styling
UI의 폰트 컬러, 텍스트 정렬, 그림자효과 등을 줄 시 한줄 한줄 일일이 적는 대신 여러 속성을 한 번에 줄 수 있는 클로저를 넘겨주는 방식을 구현하고자 Styling프로토콜을 만듬

### 이미지캐시

- 별도의 UIImageView클래스를 만들어서 해당 클래스 내부에서 처리하도록 설정
- UIImageView클래스는 캐시 관리를 위한 별도의 싱글턴 객체는 가지고 있음
해당 싱글턴 객체는 내부에 NSCache를 가지고 있으며 캐시처리는 NSCache로 진행함

### 프로퍼티래퍼

- 뷰모델의 특정 클로저에 바인딩한 UIView의 메소드, 로직들은 반드시 메인스레드에서 동작할 것을 보장해야 할 필요가 있었음.
- MainThreadActor 프로퍼티래퍼
UIView에 DispatchQueue.main.async { } 를 반복 작성하는 것은 비효율적이고, 순수한 UI관련 클래스가 아닌 뷰모델에 DispatchQueue.main.async { } 코드가 있는 것은 “모델"클래스의 정체성과 반대되는 것으로 고려되어 별도의 프로퍼티 래퍼를 생성함.
- 해당 프로퍼티래퍼가 붙은 뷰모델의 클로저 안의 코드는 DispatchQueue.main.async { } 블록으로 감쌀 필요 없음

---

# 네트워킹

### 레포지토리

- 모델 클래스 생성시 기본적으로 주입하는 클래스
- 레포지토리 클래스는 생성시 HTTP리퀘스트 호출, 리스폰스 리턴을 위한 별도의 클래스를 주입받음
- 굳이 HTTP리퀘스트 관련 클래스를 모델, 뷰모델에 직접 주입하는 대신 레포지토리를 주입하는 것은 해당 사전과제가 실전 상황이라고 가정했을 시, 레포지토리가 http관련 클래스 뿐만 아니라 데이터베이스 관련 클래스도 관리하는 구조가 더 용이할 것이라고 판단했기 때문임.
- 뷰모델은 생성시 레포지토리를 주입받지 않음. 
통신 호출은 모델 클래스에 있는 레포지토리에서만 진행됨
뷰모델은 뷰모델과 연계된 특정 뷰에 특화된 로직 처리, 사용자의 입력 이벤트 송수신 과 같은 처리만을 진행함.
뷰모델이 레포지토리를 주입받지 않는 것은 뷰모델이 레포지토리와 타이트하게 커플링 되는 것을 막고자 하는 의도도 있음

### HTTP클라이언트

- URLRequest 생성, 호출, 리스폰스 리턴 등 진행
- API Enum을 전달받음
- 리스폰스의 결과에 따라 Codable 객체를 리턴하거나, 사전에 정의된 Error Enum값을 Throw할 수 있음

### API Enum

- HTTP클라이언트가 메소드를 호출할 시 전달받는 파라미터
- 해당 enum은 연관값으로 도시이름, 좌표 등 모델에서 받은 파라미터를 받을 수 있음
- 모델에서 정해준 값에 따라 httpMethod, urlComponent를 자동으로 리턴하게끔 구현됨
그에 따라 HTTP클라이언트에서는 해당 api에 따른 분기를 작성하지 않아도 됨

---

# 비동기, 동시성 처리

### async, await, Task

- async, await, Task를 이용하여 처리함
- 클로저, DispatchGroup 대신 다른 방법을 활용해보고자 하는 의도였음
- http클라이언트, 이미지로드, 레포지토리의 메소드, http리퀘스트 리스폰스 모델링, 여러 리퀘스트 한번에 호출 + 리스폰스 처리 최적화시 사용

---

# 기능

### 모든 도시 데이터 가져오기

- 첫번째 화면
- 컬렉션뷰로 표시
- async, await, Task 통해 전체 도시 데이터 가져오는 시간 최적화 (시뮬레이터 기준 1.2~0.9초)
- 첫 번째 화면에 진입할 때, 별도의 버튼을 눌렀을 때 모든 도시 데이터를 가져오게 구현되어있음

### 도시이름 기반 검색 + 검색 후 도시이름으로 API 호출

- 첫번째 화면
- 검색시 컬렉션뷰에 해당 도시가 있는지 확인. 
해당 도시가 있으면 해당 위치로 스크롤
없으면 얼럿을 띄우고, 얼럿에서 확인버튼 누르면 API호출. API 리스폰스에 따라 컬렉션뷰 새로고침

### 특정 도시데이터 전체 확인

- 두번째 화면
- 첫번째 화면의 컬렉션뷰에서 셀 터치시 두번째 화면으로 진입
- 두번째 화면 진입시 도시 이름에 기반하여 API 호출
API 호출 결과에 따라 두번째 화면 데이터 표시

### 랜덤한 도시 데이터 확인

- 두번째 화면
- 두번째 화면에서 랜덤 버튼 클릭시 두 번째 화면 구현시 사용한 뷰컨트롤러를 띄움(UI요소, 모델 요소 재사용)
- 뷰컨트롤러가 새로 띄워지면 API 호출. 랜덤한 도시 데이터 표시
- 첫 번째 화면에서 두 번째 화면으로 이동시엔 네비게이션 컨트롤러의 푸시 방식으로 이동함
그러나 두번째 화면에서 랜덤 버튼을 눌러서 이동할땐 프리젠트 방식으로 이동함
때문에 뷰컨트롤러에 뷰컨트롤러가 푸시된 것인지, 프리젠트 된 것인지 체크 후 뷰에 알리는 로직이 추가되어 있음