# PPP CLUB - iOS

## 📌 프로젝트 소개

- SOPT 32th 장기 해커톤 APPJAM
- 기간: 2022.06.18 ~ 2023.07.22

> 취향이 잔뜩 묻어있는 공간을 좋아하는 사람들이 자신의 취향에 맞는 공간을 더 잘 찾을 수 있도록 돕고,<br>
  공간이 공간으로서 오래 지속할 수 있도록 돕는 서비스
<br>

## 📌 팀원 소개

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://github.com/HELLOHIDI"><img src="https://github.com/Indipage/PPPiOS/assets/54922625/344a573d-8f3c-4615-9ae8-8c63f212e599" width="220px;" alt=""/><br /><titleb><b>류희재(a.k.a 옥지)</b></titleb></a><br /><a href="https://github.com/HELLOHIDI" title="Code">📱</a></td>
    <td align="center"><a href="https://github.com/binisnil"><img src="https://github.com/Indipage/PPPiOS/assets/54922625/83eb21bf-b945-4c34-b4ba-bf71e81a62f5" width="220px;" alt=""/><br /><titleb><b>박윤빈(a.k.a 춘자)</b></titleb></a><br /><a href="https://github.com/binisnil" title="Code" title="Code">📱</a></td>
    <td align="center"><a href="https://github.com/ena-isme"><img src="https://github.com/Indipage/PPPiOS/assets/54922625/aaae0862-d492-49f1-af96-3c684ab8a748" width="220px;" alt=""/><br /><titleb><b>신지원(a.k.a 봉봉)</b></titleb></a><br /><a href="https://github.com/ena-isme" title="Code">📱</a></td>
  </tr>
</table>

<br>

## 역할 분배
## 🌷 역할 분담
<details>
<summary> 💋 희재 </summary>
<div markdown="1">

	
**프로젝트 세팅**

**마이페이지 화면 UI 및 기능 구현**
- 서버통신
- TableView 활용

**티켓페이지 화면 UI 및 기능 구현**

- AVFoundation을 이용한 QR코드 체크
- 카드 수령 과정 애니메이션 구현
- 티켓 카드 토글 버튼 애니메이션 구현
- collectionView 활용
- 서버통신

**아티클 뷰 기능 구현**

- 아티클 컨텐츠 높이 동적 할당 구현
- UILable 특정 text 클릭 시 화면 전환 기능 구현
- 서버통신

**코드 리팩토링**

- 다양한 기능 싱글톤 패턴으로 전환 구현

</div>
</details>
	
<details>
<summary> 👄 윤빈 </summary>
<div markdown="1">
  
  - **공간 상세보기 화면 UI 구성**
    - UIScrollView 활용
    - CollectionView 활용하여 Paging 기능 구현

  - **공간 검색 화면 UI 구성**
    - UISearchBar 활용
    - TableView 활용
   
  - **기기대응**
    - HomeVC, SearchVC, DetailVC, TicketVC, MyVC
    - SE, 13 mini, 14 Pro
      
  - **공간 상세보기 관련 API 연동**
    - 공간에 대한 아티클 조회
    - 공간 상세 조회
    - 공간의 추천서가 조회
    - 조르기 여부 조회
    - 조르기
    - 공간 북마크 여부  조회
    - 공간 북마크 등록하기
    - 공간 북마크 취소하기
   
  - **검색 관련 API 연동**
    - 키워드(지역) 기반 검색하기


</div>
</details>
  
<details>
<summary> 🫦 지원 </summary>
<div markdown="1">
HomeView - Weekly (처음 들어갔을 때 열리는 뷰)

- 카드의 슬라이드를 내리지 않았을 때 ) 카드를 슬라이드 하는 뷰와 애니메이션 기능 구현
- 카드의 슬라이드를 내렸을 때 ) 이번 주와 다음 주 카드를 가로로 scroll 하는 뷰 구현
- 네비게이션 바 구햔

HomeView - All

- 전체 아티클 목록 구현

ArticleView

- 아티클 Cell 에 Parsing 하는 알고리즘 구현
- 네비게이션 바 구현
- TableView 의 HeaderView 와 FooterVIew 구현
- FooterView 에서 티켓 클릭시 받아지도록 구현
</div>
</details>
  
<br>
	
## 💭 트러블 슈팅
<details>
<summary> 📄 희재 </summary>
<div markdown="1">

제가 가장 어려움을 느낀 부분은 카드를 수령하기 위해서 티켓의 정보가 담긴 QRCODE 인식 과정에서 멀티스레딩 관련 어려움을 느꼈습니다. 그 이유는 카메라 프리뷰와 콜백 함수는 비동기적으로 동작하므로, UI 업데이트 시 메인 스레드에서 처리하고, 프레임 처리는 백그라운드 스레드에서 해결해야 했기 때문입니다. 이를 해결하기 위하여 GCD와 OperationQueue의 개념을 사용하여 스레드 간 경합 조건과 데드락을 피하였고, 이를 통해 안정성과 성능을 향상시켰습니다.  또한 싱글톤 패턴을 적용하여 전역적인 접근과 인스턴스 공유를 가능하게 하며, 여러 스레드에서도 안정적으로 사용할 수 있습니다. 기존에 배웠던 세미나 자료에 심화적인 부분을 참고하여 구현하는 과정에서 뿌듯함과 성취감을 느낄 수 있었습니다!

</div>
</details>

<details>
<summary> 📄 윤빈 </summary>
<div markdown="1">
	
[👄 트러블 슈팅]()

</div>
</details>

<details>
<summary> 📄 지원 </summary>
<div markdown="1">

[🫦 트러블 슈팅]()

</div>
</details>



## 📌 개발 환경 및 라이브러리

### 개발 환경

[![Swift 4](https://img.shields.io/badge/PPPCLUB-iOS-black.svg?style=flat)](https://swift.org) ![Xcode](https://img.shields.io/badge/Xcode-14.2-blue) ![swift](https://img.shields.io/badge/swift-5.0-green) ![iOS](https://img.shields.io/badge/iOS-13.0-yellow)

### 라이브러리

| 라이브러리(Library) | 목적(Purpose)            | 버전(Version)                                                |
| ------------------- | ------------------------ | ------------------------------------------------------------ |
| Moya           | 서버 통신                | ![Alamofire](https://img.shields.io/badge/Moya-15.0.0-orange) |
| Kingfisher          | 이미지 처리              | ![Kingfisher](https://img.shields.io/badge/Kingfisher-7.4.1-yellow) |
| SnapKit             | 오토레이아웃             | ![Kingfisher](https://img.shields.io/badge/SnapKit-5.0.0-black) |
| Then                | 짧은 코드 처리           | ![Kingfisher](https://img.shields.io/badge/Then-3.0.0-white) |
| KakaoSDK          | 카카오톡 소셜 로그인     | ![lottie-ios](https://img.shields.io/badge/KakaoSDK-2.0.0-green) |
<br/>

## 📌 협업 방식

- [Coding-Convention](https://ppp-club.notion.site/73298956984d4ec985f08994fe21dcdf?pvs=4)
- [Git Flow 전략](https://ppp-club.notion.site/Git-Flow-bd712ba3a0ec40ecb27cc44845e02233?pvs=4)
- [Git 컨벤션](https://ppp-club.notion.site/Git-e631871a85b745469943973c7f1bef4a?pvs=4)
- [폴더링 Convention](https://ppp-club.notion.site/360abaf3d15b4fb9a059d508ae682f5c?pvs=4)

## 📌 프로젝트 설계
[프로젝트 설계](https://www.figma.com/file/pWuyCsFSjAfmulPBGSgZRE/PPP-Club-iOS-%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8-%EC%84%A4%EA%B3%84?type=whiteboard&node-id=0%3A1&t=gj8pnRQHaqXWCXhw-1)

