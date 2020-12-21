# SideProject

## Standard iOS WeatherApp Clone Coding 시작일 ( 2020.12.03 )
<img src="https://user-images.githubusercontent.com/64323969/102778627-471bd200-43d6-11eb-8da4-1e136a1b7073.png" width="40%" height="40%">

### 이 사이드 프로젝트를 시작하게 된계기는 모각코 스터디 그룹에서 각자가 만들어보고 서로서로 비교하며 배우는 것이 목적이였습니다. 
- 일단 기본적인 화면구성과 유저인터랙션을 보고 어떻게 구성할지를 생각하였으며, 메인화면 구성이 너무 어려워 서브뷰를 먼저 구성하는걸로 시작하였습니다. 
- 앱의 데이터는 코어데이터에 보관하여 유저가 원하는 지점을 검색 ( google AutoCompletion ) 하고 데이터를 담는 것으로 하였습니다. 
- API는 openWeather에서 제공하는 oneCallAPI를 사용하였습니다. 데이터 요청은 위도와 경도를 제공하여 받았습니다. 


### 사용한 라이브러리
- GooglePlace
- Alamofire

### 앱의 데이터 흐름
- 앱 실행 -> 첫 실행시 저장된 현재위치가 있는지 검사 → 없으면 현재위치를 코어데이터에 추가, 있으면 현재위치로 덮어쓰기
  → 코어데이터에 저장된 위치정보 로드 → API 호출 → 받아온 데이터 셀에 맞게 가공 → 뿌려주기 
  → LocationList View 로 진입시 각 위치 업데이트 → 1시간 마다 UI업데이트

## 2020.11.18 로그인 & 회원가입 뷰 업데이트 (Version 1.0.2)

### 업데이트 타겟입니다
 - 구글 & 카카오 로그인 기능 추가 및 로그인 성공시 해당 유저의 데이터를 파이어베이스 데이터베이스에 저장하도록 업데이트 했습니다

## 2020.11.18 로그인 & 회원가입 뷰 업데이트 (Version 1.0.1)

### 업데이트 타겟입니다
- 입력값 유효성검사
    = ValidationCheck라는 클래스를 생성하여 NSPredicate(format:) 를 이용해서 인스턴스를 생성하고 evealuate하는 방법으로 작성하였습니다
    
- 로그인 데이터 파이어 베이스 보관
    = 이전에는 데이터베이스에 유저정보를 저장하고 유저정보를 Decoding해서 앱안에 Users라는 모델을 생성하여 보관하였었는데 이번에는 Firebase 로그인 시스템을 이용해서 계정을 생성하고 데이터베이스에 유저정보를       저장하도록 구현했습니다
    
- 오류 수정
    = 이전에 심각한 문제가 있었습니다 2번째 페이지 UIViewController를 상속해야했었는데 ViewController를 상속했었는데 이전에 알수없는 오류가 발생했었지만 오류를 깨닫고 전면수정했습니다.
    
- 비밀번호 별표표시
    = 이전에는 비밀번호도 그냥 보였는데 secure옵션 체크를 해서 별표로 표시되도록 수정했습니다
    
- 키보드 입력시 화면 밀어올리기
    = 노티피케이션 센터를 활용하여 키보드가 올라가고 내려갈때 일정부분 화면을 가리는 부분을 frame.y를 값을 더하여 수정했습니다. 


## 2020.11.03 로그인 & 회원가입 뷰입니다 (Version 1.0.0)

<img src="https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2Fl3Kkp%2FbtqMve5qKTy%2FrsAgGPmYrEEbLThM6Fm4bK%2Fimg.gif" width="40%" height="40%">

https://memohg.tistory.com/92

## 2020.10.29 계산기 업데이트 입니다 (Version 1.0.2) //버튼애니메이션 추가, MVC 모델 적용

<img src="https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FVC9hF%2FbtqL9tnR1af%2FUpwu0CCopmYwRzgtNVc6H1%2Fimg.gif" width="20%" height="20%">

https://memohg.tistory.com/84?category=865507

## 2020.10.28 첫번째 계산기 앱입니다.(Version 1.0.1) (feat. 생에첫 앱)

<img src="https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FRSgb8%2FbtqLZKxzK0E%2FbHOTu0Dxpvl4T0Luvu2Zyk%2Fimg.png" width="20%" height="20%">

https://memohg.tistory.com/79

## 2020.10.27 사이드 프로젝트 연습을 위해 개설되었습니다.
