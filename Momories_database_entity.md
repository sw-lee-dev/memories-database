# 엔터티 추출
## 사용자
- 아이디
- 비밀번호
- SNS 분류
- SNS 아이디
- 이름
- 주소
- 상세주소
- 프로필 사진
- 성별
- 나이

### 테이블 구성
## user
- user_id (PK)
- user_password
- join_type
- sns_id
- name
- address
- detail_address
- profile_image
- gender
- age

---

## 기억력 검사 기록
- 측정 시간
- 검사 날짜
- 순번
- 차이

### 테이블 구성
## memory_test
- measurement_time
- test_date
- sequence (PK)
- gap
- user_id (PK FK)

---

## 집중력 검사 기록
- 측정 점수
- 검사 날짜
- 오류 횟수
- 순번
- 점수 차이
- 오류 차이

### 테이블 구성
## concentration_test
- measurement_score
- test_date
- error_count
- sequence (PK)
- score_gap
- error_gap
- user_id (PK FK)

---

## 일기
- 날짜
- 날씨
- 기분
- 제목
- 내용

### 테이블 구성
## diary
- diary_number (PK AI)
- write_date
- weather
- feeling
- title
- content
- user_id (FK)

---

## 사용자가 기억력 검사를 수행하는 관계
## 사용자 : 기억력 검사 = 1 : N

## 사용자가 집중력 검사를 수행하는 관계
## 사용자 : 집중력 검사 = 1 : N

## 사용자가 일기를 작성하는 관계
## 사용자 : 일기 = 1 : N

## 추후 일기에 대한 댓글과 공감 추가 예정