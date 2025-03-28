<h1 style='background-color: rgba(55, 55, 55, 0.4); text-align: center'>API 설계(명세)서 </h1>

해당 API 명세서는 '고객관리 서비스'의 REST API를 명세하고 있습니다.

- Domain :  http://localhost:4000

***
  
<h2 style='background-color: rgba(55, 55, 55, 0.2); text-align: center'>Auth 모듈</h2>

고객관리 서비스의 인증 및 인가와 관련된 REST API 모듈 입니다.
로그인, 회원가입, 아이디 중복확인, 전화번호 인증, 인증번호 확인 등의 API가 포함되어 있습니다.
  
- url : /api/v1/auth

***

#### - 로그인
  
##### 설명

클라이언트는 사용자 아이디와 평문의 비밀번호를 포함하여 요청하고 아이디와 비밀번호가 일치한다면 인증에 사용될 accessToken과 해당 accessToken의 만료 기간을 응답 데이터로 전달받습니다. 만약 아이디 혹은 비밀번호가 하나라도 일치하지 않으면 로그인 정보 불일치에 해당하는 응답을 받습니다. 로그인이 성공한다면 고객관리 리스트 페이지로 이동합니다. 만일, 신규 사용자라면 회원가입 링크를 클릭하여 회원가입 페이지로 이동 가능합니다. 서버 에러, 데이터베이스 에러, 유효성 검사 실패 에러, 로그인 실패가 발생할 수 있습니다.  

- method : **POST**  
- URL : **/sign-in**  

##### Request

###### Request Body

| name | type | description | required |
|---|:---:|:---:|:---:|
| userId | String | 사용자의 아이디 | O |
| userPassword | String | 사용자의 비밀번호 | O |

###### Example

```bash
curl -v -X Post "http://localhost:4000/api/v1/auth/sign-in" \
 -d "userId=qwer1234" \
 -d "userPassword=qwer1234"
```

##### Response

###### Response Body

| name | type | description | required |
|---|:---:|:---:|:---:|
| code | String | 응답의 결과 | O |
| message | String | 응답의 결과에 대한 설명 | O |
| accessToken | String | Bearer 인증 방식에 사용될 JWT | O |
| expiration | String | accessToken 만료 시간(초단위) | O |

###### Example

**응답 성공**
```bash
HTTP/1.1 200 OK 
{
  "code": "SU",
  "message": "Success.",
  "accessToken": "${ACCESS_TOKEN}",
  "expiration": 32400
}
```

**응답 : 실패 (유효성 검사 실패)**
```bash
HTTP/1.1 400 Bad Request
{
  "code": "VF",
  "message": "Validation Failed."
}
```

**응답 : 실패 (로그인 실패)**
```bash
HTTP/1.1 401 UnAuthorization
{
  "code": "SF",
  "message": "Sign in Failed."
}
```

**응답 : 실패 (데이터베이스 에러)**
```bash
HTTP/1.1 500 Internal server error
{
  "code": "DBE",
  "message": "Database Error."
}
```

***

#### - 아이디 중복확인

##### 설명

클라이언트는 사용할 아이디를 포함해서 요청하고 중복되지 않는 아이디라면 성공 응답을 받습니다. 만약 존재하는 아이디일 경우 중복되는 아이디에 대한 응답을 받습니다. 서버 에러, 데이터베이스 에러가 발생할 수 있습니다.

- method : **POST**  
- URL : **/id-check**  

##### Request

###### Request Body

| name | type | description | required |
|---|:---:|:---:|:---:|
| userId | String | 중복확인을 수행할 사용자의 아이디 | O |

###### Example

```bash
curl -v -X Post "http://localhost:4000/api/v1/auth/id-check" \
 -d "userId=qwer1234"
```

##### Response

###### Response Body

| name | type | description | required |
|---|:---:|:---:|:---:|
| code | String | 응답의 결과 | O |
| message | String | 응답의 결과에 대한 설명 | O |

###### Example

**응답 성공**
```bash
HTTP/1.1 200 OK 
{
  "code": "SU",
  "message": "Success."
}
```

**응답 : 실패 (유효성 검사 실패)**
```bash
HTTP/1.1 400 Bad Request
{
  "code": "VF",
  "message": "Validation Failed."
}
```

**응답 : 실패 (중복된 아이디)**
```bash
HTTP/1.1 400 Bad Request

{
  "code": "EU",
  "message": "Exist User."
}
```

**응답 : 실패 (데이터베이스 에러)**
```bash
HTTP/1.1 500 Internal server error
{
  "code": "DBE",
  "message": "Database Error."
}
```

***

#### - 전화번호 인증

##### 설명

클라이언트는 사용자의 전화번호를 포함해서 요청하고 사용자에게 등록된 전화번호가 맞다면 성공 응답을 받습니다. 만약 사용자에게 등록된 전화번호가 아니라면 전화번호 인증 실패에 대한 응답을 받습니다. 서버 에러, 데이터베이스 에러가 발생할 수 있습니다. 

- method : **POST**  
- URL : **/tel-number-check**  

##### Request

###### Request Body

| name | type | description | required |
|---|:---:|:---:|:---:|
| userTelNumber | number | 인증을 수행할 사용자의 전화번호 | O |

###### Example

```bash
curl -v -X Post "http://localhost:4000/api/v1/auth/tel-number-check" \
 -d "userTelNumber=01011111111"
```

##### Response

###### Response Body

| name | type | description | required |
|---|:---:|:---:|:---:|
| code | String | 응답의 결과 | O |
| message | String | 응답의 결과에 대한 설명 | O |

###### Example

**응답 성공**
```bash
HTTP/1.1 200 OK 
{
  "code": "SU",
  "message": "Success."
}
```

**응답 : 실패 (유효성 검사 실패)**
```bash
HTTP/1.1 400 Bad Request
{
  "code": "VF",
  "message": "Validation Failed."
}
```

**응답 : 실패 (전화번호 인증 실패)**
```bash
HTTP/1.1 400 Bad Request

{
  "code": "WT",
  "message": "Wrong TelNumber."
}
```

**응답 : 실패 (데이터베이스 에러)**
```bash
HTTP/1.1 500 Internal server error
{
  "code": "DBE",
  "message": "Database Error."
}
```

***

#### - 인증번호 확인

##### 설명

클라이언트는 사용자의 전화번호로 보낸 인증번호를 요청하고 인증번호가 일치한다면 성공 응답을 받습니다. 만약 인증번호가 일치하지 않는다면 인증번호 미일치에 대한 응답을 받습니다. 서버 에러, 데이터베이스 에러가 발생할 수 있습니다. 

- method : **POST**  
- URL : **/auth-number-check**  

##### Request

###### Request Body

| name | type | description | required |
|---|:---:|:---:|:---:|
| authNumber | number | 인증된 사용자가 인증된 사용자의 전화번호를 통해 받을 인증번호 | O |

###### Example

```bash
curl -v -X Post "http://localhost:4000/api/v1/auth/auth-number-check" \
 -d "authNumber=123456"
```

##### Response

###### Response Body

| name | type | description | required |
|---|:---:|:---:|:---:|
| code | String | 응답의 결과 | O |
| message | String | 응답의 결과에 대한 설명 | O |

###### Example

**응답 성공**
```bash
HTTP/1.1 200 OK 
{
  "code": "SU",
  "message": "Success."
}
```

**응답 : 실패 (유효성 검사 실패)**
```bash
HTTP/1.1 400 Bad Request
{
  "code": "VF",
  "message": "Validation Failed."
}
```

**응답 : 실패 (인증번호 미일치)**
```bash
HTTP/1.1 400 Bad Request

{
  "code": "ANM",
  "message": "Auth-number Not Matched."
}
```

**응답 : 실패 (데이터베이스 에러)**
```bash
HTTP/1.1 500 Internal server error
{
  "code": "DBE",
  "message": "Database Error."
}
```

***

#### - 회원가입
  
##### 설명

클라이언트는 사용자의 아이디, 사용자의 이름, 사용자의 비밀번호, 전화번호, 인증번호, 가입 경로를 요청하고 회원가입이 성공적으로 이루어진다면 로그인 페이지로 이동합니다. 만약 존재하는 아이디일 경우 중복되는 아이디에 대한 응답을 받습니다. 만약 사용자에게 등록된 전화번호가 아니라면 전화번호 인증 실패에 대한 응답을 받습니다. 만약 인증번호가 일치하지 않는다면 인증번호 미일치에 대한 응답을 받습니다. 서버 에러, 데이터베이스 에러가 발생할 수 있습니다. 

- method : **POST**  
- URL : **/sign-up**  

##### Request

###### Request Body

| name | type | description | required |
|---|:---:|:---:|:---:|
| userId | String | 사용자의 아이디(공백X, 한글 또는 영문으로 된 문자열) | O |
| userName | String | 사용자의 이름(공백X, 한글 또는 영문으로 된 문자열) | O |
| userPassword | String | 사용자의 비밀번호(영문과 숫자의 조합으로만 이루어진 8자리 이상 13자리 이하 문자열) | O |
| userTelNumber | number | 사용자의 전화번호(숫자로만 이루어진 11자리) | O |
| authNumber | number | 사용자의 전화번호 인증을 통해 받은 인증번호(숫자로만 이루어짐) | O |
| joinType | String | 가입 경로 (NORMAL: 일반, KAKAO: 카카오, NAVER: 네이버) | O |

###### Example

```bash
curl -v -X Post "http://localhost:4000/api/v1/auth/sign-up" \
 -d "userId=qwer1234" \
 -d "userName=홍길동" \
 -d "userPassword=qwer1234" \
 -d "userTelNumber=01011111111" \
 -d "authNumber=123456" \
 -d "joinType=NORMAL"
```

##### Response

###### Response Body

| name | type | description | required |
|---|:---:|:---:|:---:|
| code | string | 응답의 결과 | O |
| message | string | 응답의 결과에 대한 설명 | O |

###### Example

**응답 성공**
```bash
HTTP/1.1 201 CREATE
{
  "code": "SU",
  "message": "Success."
}
```

**응답 : 실패 (유효성 검사 실패)**
```bash
HTTP/1.1 400 Bad Request
{
  "code": "VF",
  "message": "Validation Failed."
}
```

**응답 : 실패 (중복된 아이디)**
```bash
HTTP/1.1 400 Bad Request

{
  "code": "EU",
  "message": "Exist User."
}
```

**응답 : 실패 (전화번호 인증 실패)**
```bash
HTTP/1.1 400 Bad Request

{
  "code": "WT",
  "message": "Wrong TelNumber."
}
```

**응답 : 실패 (인증번호 미일치)**
```bash
HTTP/1.1 400 Bad Request

{
  "code": "ANM",
  "message": "Auth-number Not Matched."
}
```

**응답 : 실패 (데이터베이스 에러)**
```bash
HTTP/1.1 500 Internal server error
{
  "code": "DBE",
  "message": "Database Error."
}
```

#### - SNS 회원가입 및 로그인
  
##### 설명

클라이언트는 SNS 가입경로를 포함하여 요청하고 성공시 가입 이력이 있는 사용자라면 고객관리 리스트 페이지로 리다이렉트를 받고 만약 가입 이력이 없는 사용자일 경우 회원가입 페이지로 리다이렉트 됩니다. 서버 에러, 데이터베이스 에러가 발생할 수 있습니다. 

- method : **GET**  
- URL : **/sns/{registrationName}**  

##### Request

###### PathVariable

| name | type | description | required |
|---|:---:|:---:|:---:|
| registrationName | String | SNS 회원가입 경로(KAKAO 또는 NAVER) | O |

###### Example

```bash
curl -v GET "http://localhost:4000/api/v1/auth/sns/KAKAO"
```

##### Response

###### Example

**응답 성공 (회원가입이 된 상태일 때)**
```bash
HTTP/1.1 302 Found
Set-Cookie: access_token=${accessToken}; path="/";
Location: "http://localhost:4000/고객관리 리스트
```

**응답 성공 (회원가입이 안 된 상태일 때)**
```bash
HTTP/1.1 302 Found
Set-Cookie: access_token=${accessToken}; path="/";
Location: "http://localhost:4000/api/v1/auth/sign-up
```

**응답 : 실패 (OAuth 실패)**
```bash
HTTP/1.1 401 UnAuthorization
{
  "code": "AF",
  "message": "Auth Failed."
}
```

**응답 : 실패 (데이터베이스 에러)**
```bash
HTTP/1.1 500 Internal server error
{
  "code": "DBE",
  "message": "Database Error."
}
```