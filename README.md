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

# 2017-03-23

  * 재고관리페이지에 '현재고 중량' 필드 추가(수정)
    - 현재 재고의 중량을 '보기'를 누르지 않아도 볼 수 있음
    - products 생성 및 삭제 시 계산 후 inventory(iST_KG)에 저장됨
