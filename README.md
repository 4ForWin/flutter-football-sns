# 🏃용병모아 Project

---

## 💰 ’4ForWin’ 팀소개

- **팀명**: 4ForWin
- **팀원**: 문준호(팀장), 양준석, 이현진, 유제형
- **슬로건**: "승리를 위해 뭉친 4명"

---

## 📄 역할 분담

- 문준호: 스플래쉬, 로그인, 이용 약관, FCM 알림(예정)
- 양준석: 레벨테스트, 모집 분야
- 이현진: 피드 작성, 피드 불러오기, 틴더 스와이프, 신청 및 스킵
- 유제형: 마이페이지(로그아웃, 팀/용병 신청내역 등)

---

## 👨‍🏫 프로젝트 소개

- 풋살은 하고 싶지만 팀이 없는 용병, 갑자기 풋살이 하고 싶은 풋살러
- 인원부족으로 인해 용병이 필요한 팀
- 지역별로 있는 풋살용병과 풋살팀을 연결해 주는 서비스입니다.

---

## ⚽︎ 프로젝트 계기

- 기존 네이버 밴드, 카카오 오픈채팅, 네이버 카페를 통한 매칭방식의 불편함을 느낌
    - 네이버 밴드 : 원하는 매칭글을 찾기가 불편함
    - 오픈 채팅 : 원하는 매칭글을 찾기가 어렵고 여러 가지 정보가 섞여 있음
- 간편하게 용병과 운동할 수 있는 팀을 찾을 수 있는 서비스를 구현하고자 함

---

## ⏲️ 개발기간

- 2025.5.16(일) ~ 2025.5.25(월)

---

## 💻  주요기능

### 1️⃣ 로그인 및 회원가입 기능

- 카카오 로그인을 이용하여 간편하게 로그인 및 회원가입 가능

### 2️⃣ 용병찾기 & 팀 찾기

- 가로 스와이프 기능을 활용해 간편하게 원하는 용병 및 팀을 찾을 수 있음

### 3️⃣ 위치기반 매칭

- 현위치에 따라 같은 위치에서 일어나는 모집글을 볼 수 있음

| <img alt="스플래쉬" src="https://github.com/user-attachments/assets/339bf485-59ae-4835-a8d9-3cd9daa55fcd" />  | <img alt="로그인" src="https://github.com/user-attachments/assets/7db250c3-36f2-49e4-8b15-02176f76740e" /> | <img alt="약관동의" src="https://github.com/user-attachments/assets/7aa80368-5c65-4374-b1c2-379750420571" />|
|-------------------------------------|-------------------------------------|-------------------------------------|
| <img width="1080" height="2400" alt="레벨테스트" src="https://github.com/user-attachments/assets/1ebbff80-9c00-4cf6-a53e-345c0f28c0b2" /> | <img width="1080" height="2400" alt="모집분야" src="https://github.com/user-attachments/assets/86b50bc4-9600-487e-8bb4-b05e1da018d9" /> |  |
| <img width="1080" height="2400" alt="홈" src="https://github.com/user-attachments/assets/a69ba4d1-a1c8-40ec-a775-d208b90b93b2" />|  <img width="1080" height="2400" alt="신청 스와이프" src="https://github.com/user-attachments/assets/6d748174-1e7e-4717-8373-e3d0f1593952" /> | <img width="1080" height="2400" alt="스킵 스와이프" src="https://github.com/user-attachments/assets/51834893-7679-4895-97b4-e3a4674d917c" /> |
|  <img width="1080" height="2400" alt="Screenshot_1752593638" src="https://github.com/user-attachments/assets/7db9f2b1-59ea-44d1-92ec-e1231b1506da" /> | <img width="1080" height="2400" alt="Screenshot_1752593642" src="https://github.com/user-attachments/assets/9b2a96fd-3e96-49fb-9acd-3ee8bea155b8" /> |   |
| <img width="1080" height="2400" alt="Screenshot_1752593720" src="https://github.com/user-attachments/assets/a41e954a-f8c3-4c1a-a09b-46c688a1c490" /> | <img width="1080" height="2400" alt="Screenshot_1752593728" src="https://github.com/user-attachments/assets/cebfb8a6-8e79-4246-bae6-010b026766ed" /> | <img width="1080" height="2400" alt="Screenshot_1752593736" src="https://github.com/user-attachments/assets/6afc15a9-8e62-48a3-b649-e7abbb967c41" /> |

---

## 📚️ 기술스택

### Language

- Dart

### Version Control

- git / github

### IDE

- VSCode

### Framework

- Flutter
- Firebase (Authentication, Firestore)

### DBMS

- Firebase Firestore

---

## 프로젝트 파일구조

```markdown
assets/
├── images/                    
│   ├── image1.png
│
lib/
├── core/                    
├── data/       
│   ├── data_source
│   ├── dto
│   ├── repository         
│
├── domain/       
│   ├── entity
│   ├── repository
│   ├── usecase 
│
├── presentation/       
│   ├── pages
│
├── main.dart 
```

---
