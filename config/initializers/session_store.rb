# 기본으로 사용하는 쿠키 기반 세션 대신에 데이터베이스 세션을 사용하는 경우에는
# 중요한 정보를 저장하지 말 것!!
# 세션 테이이블 생성은 "rails g active_record:session_migration"으로 가능함

Rails.application.config.session_store :cookie_store, key: '_inventorysystem_session'
