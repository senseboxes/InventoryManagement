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
