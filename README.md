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
 - 생산품명을 추가할 수 있다(관리자)
 - 추가된 생산품명을 검색하여 선택하면 자동으로 품명이 입력된다.
 - 추가적으로 생산품명을 입력할 필요가 없음
 - 검색기능은 다음과 같다.
   => a를 검색하면 a가 들어간 모든 단어를 검색하여 dropdown리스트에 보여준다.
   => a가 처음에 들어가든 중간에 들어가든 끝에 들어가든 a가 속해있는 단어는 모두 보여줌
   => 순차적으로 a->b->c 로 검색하면됨 abc -> list : 가abc, abc나, 다abc, abc라 등등

 - 미구현 부분
   => 관리자만 추가 할 수 있도록 설정페이지에 따로 만들어야 함
   => 선택한 아이템이 1개 이상이라면 선택한 아이템명 마다 콤마를 찍어줘야함(단어구분기호)
