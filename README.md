# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
  - ruby 2.3.1p112 (2016-04-26 revision 54768) [x86_64-darwin16]
  - rbenv 1.1.0
  - Rails 5.0.2

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

# 2017-04-14

* 생산품명 추가 기능 구현
 - 생산품명 추가할 때 날짜는 오늘 날짜로 자동 선택되도록 변경
 - 미구현 부분
   => 관리자만 추가 할 수 있도록 설정페이지에 따로 만들어야 함
   => 선택한 아이템이 1개 이상이라면 선택한 아이템명 마다 콤마를 찍어줘야함(단어구분기호)

* scafolld.scss 파일 삭제
 - 모든 css는 bootstrap으로 사용

* 날짜 별로 정렬 및 계산
 - 생산품을 입력할 때 오늘보다 전에 날을 입력해야 한다면 계산을 날짜에 맞게 해야하기때문에 계산법을 날짜기준으로 바꿈
 - 정렬은 최근 날짜가 가장 위에 보이도록 설정

# 2017-12-27

* 모든 개발이 끝났다고 판단
 - 에러도 잡았고 테스트 입력 시 문제 없음
 - 가테스트로 실제의 데이터를 한달 간 입력해보기로 함

# 2018-01-17
 - numeric(소수점)을 사용하는 연마사, 약품 등의 문제발생

# 2018-01-30
 - 생산품이 많이 등록된 경우 카테고리 값을 넣지 않고 저장하면 구분이 힘들고 중복 입력에 대해서 확인이 힘들다.
 - 그래서 생산품명을 등록할 때 카테고리 값도 선택할 수 있고 등록된 생산품을 볼 때 카테고리별로 나누어 볼 수 있도록 수정중
  : 현재는 생산품이 등록될 때 카테고리 값도 같이 등록 가능하도록 수정한 상태(2018/01/31 완료)
  : 다음은 카테고리 별로 생산품명을 볼 수 있도록 수정(productnameset_sort.html.erb)

# 2018-02-02
 - productnameset.html.erb 삭제기능이 작동하지 않아 수정함
 - productnameset_sort.html.erb 작성완료

# 2018-02-07
 & 소수점 계산으로 수정시작
  - pgsql에서 데이터타입을 decimal로 변경 =>
    datatype(numeric), 숫자의 길이(length: 9), 소수점이하길이(precision: 3)
    예)  123456 789
        123456.123
        * 변경한 테이블 : products / monthaverages / inventories
  - views에서 f.number_field를 f.text_field로 변경
    반드시 변경을 해줘야 소수점이 입력된다.

# 2018-02-08
 - productsnameset에 수정기능 추가

 & 검색기능 추가 작업(보류)
  - 검색기능으로 다음의 젬을 사용할까 생각중 sunspot_solr 2.2.7

# 2018-02-22
  - inventories/:id(재고정보)에서 뒤로가기를 눌렀을 때 모든 재고가 보이는 불편한 현상 수정
    처음 화이버를 선택했다면 재고정보를 보고 뒤로가기 눌러도 화이버의 리스트가 보이도록 수정함
