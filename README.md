# FinalProject_Homey

<img src="https://github.com/ssoyy0001/Spring-project_homey/blob/main/%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8%20%ED%95%A9%EC%B9%9C%20zip/3.png?raw=true"  width="150" height="150"/>


## 🖥️ 프로젝트 소개
#### 인테리어 시공업체인 [ HOMEY ]의 홈페이지
Spring Framework 의 MVC 패턴 기법을 적용하여 구현한 [ HOMEY ] 사이트는 `업체 관리자 및 회원`이 이용할 수 있다.<br>
사이트를 통해 견적상담, 시공의뢰, 시공사례게시판, AS문의 등이 가능하고,<br>
HOMEY 측에서는 마케팅 차원에서 `무료 원데이클래스`와 `제품나눔`을 진행한다.<br>
원데이클래스는 사연을 받아 당첨하는 방식, 제품나눔은 선착순 방식으로 진행되며 
당첨된 회원은 리뷰를 작성할 수 있다.
<br>
<br>
## 🕰️ 개발 기간
* 23.09.21일 - 23.11.06일

## 🧑‍🤝‍🧑 맴버구성
 - 팀장  : 정승호
 - 팀원  : 김소영
 - 팀원  : 김지수
 - 팀원  : 노지연
 - 팀원  : 정하영
 - 전원  : 통합 및 형상관리, PPT 제작, 발표
<br>

## ⚙️ 개발 환경
- `Java 11`
- `java-11-openjdk-11.0.15-1`
- **OS** : Window 10
- **IDE** : eclipse(sts-3.9.17)
- **Framework** : Spring(5.2.24)
- **Database** : Oracle DB(19.3.0.0.0)(11g)
- **ORM** : Mybatis
- **Application server** :  Apache Tomcat® v9.0
- **형상관리** : Github
<span>
<img src="https://img.shields.io/badge/oracle-F80000?style=flat&logo=oracle&logoColor=white"/>
<img src="https://img.shields.io/badge/spring-6DB33F?style=flat&logo=spring&logoColor=white"/>
<img src="https://img.shields.io/badge/apachetomcat-F8DC75?style=flat&logo=apachetomcat&logoColor=white"/>
<img src="https://img.shields.io/badge/javascript-F7DF1E?style=flat&logo=JavaScript&logoColor=white"/>
<img src="https://img.shields.io/badge/jquery-0769AD?style=flat&logo=jquery&logoColor=white"/>
<img src="https://img.shields.io/badge/css3-1572B6?style=flat&logo=css3&logoColor=white"/>
<img src="https://img.shields.io/badge/bootstrap-7952B3?style=flat&logo=bootstrap&logoColor=white"/>
<img src="https://img.shields.io/badge/git-F05032?style=flat&logo=git&logoColor=white"/>
<img src="https://img.shields.io/badge/github-181717?style=flat&logo=github&logoColor=white"/>
<img src="https://img.shields.io/badge/notion-000000?style=flat&logo=notion&logoColor=white"/>
</span>

## 📕 DB구성- ERD

## 📕 폴더 구조
```
   ├───src
   ├───main
   ├───java
   │   └───org
   │       └───homey
   │           ├───controller
   │           ├───domain
   │           ├───mapper
   │           ├───resources
   │           ├───security
   │           │   └───domain
   │           └───service
   ├───resources
   │   ├───META-INF
   │   └───org
   │       └───homey
   │           └───mapper
   └───webapp
       ├───resources
       │   ├───assets
       │   ├───fullcalendar
       │   ├───img
       │   ├───js
       │   └───pages
       └───WEB-INF
           ├───classes
           ├───spring
           │   └───appServlet
           └───views
               ├───asboard
               ├───consult
               ├───email
               ├───freePdt
               ├───freePdtReq
               ├───gen
               ├───includes
               ├───notice
               ├───oneday
               ├───onedayReq
               ├───review
               ├───scrab
               ├───showcase
               ├───sirequest
               └───sischedule


       
