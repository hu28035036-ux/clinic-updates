## v2.0.5 — 예약 화면 "금일 예약 환자" 칸 찌그러짐 수정

### ⚠ 이 버전도 실행 파일 이름이 `도수치료예약.exe` 입니다 (v2.0.4 와 같은 브릿지 방식)

내용은 v2.0.4 + 화면 수정 1건이고 **이름만 옛것**입니다. 설치된 PC 의 업데이트 설치 담당 파일(`updater.bat`)이 구형(5단계)이든 신형(6단계)이든 이 ZIP 을 설치할 수 있습니다. 환자·예약 데이터, 화면에 뜨는 이름, 기능은 모두 정상입니다. 이름 복원(정식 릴리스)은 [2026-09-03 리뷰 §3](https://github.com/hu28035036-ux/hospital-management/blob/main/docs/superpowers/reviews/2026-09-03-full-review.md) 의 조건(전 PC v2.0.4 확인 · 동봉 도구/안내문 수정 · 빌드 스크립트 #48)을 갖춘 뒤로 미룹니다.

### 수정

- **예약 탭 왼쪽 "금일 예약 환자" 칸** — 환자가 많은 날 치료사 그룹이 46px 로 눌려 한 줄만 보이던 문제. 말줄임 규칙(`.today-items > div`)이 그룹 상자에 `overflow:hidden` 을 붙여 세로 flex 안에서 눌리던 것이 원인. 이제 그룹이 전부 펼쳐지고 스크롤은 목록(`#today-items`) 한 곳뿐이며, 이름띠는 `position:sticky` 로 따라옵니다.
- **"금일 예약 취소" 칸** — 칸 자체의 `max-height` 280px 때문에 내용이 범례 위로 새던 문제. 칸 상한을 없애고 목록 높이를 화면 기준(`clamp(120px, 24vh, 260px)`)으로.
- 목록 높이 420px 고정 → `clamp(320px, 55vh, 640px)`. 그룹별 120px 스크롤 제거.
- 바뀐 파일: `app/static/css/app.css` 4곳 (21+ / 14−). `main.js`·서버·DB 변경 없음.

### 검증

- pytest 1,686 passed / 2 skipped / 10 xfailed · ruff 클린
- 브라우저 실측(더미 57명): 720·950 높이에서 눌림 0 · 그룹 스크롤 0 · sticky 일치 · 취소 칸이 범례 위에서 끝남 · 환자 3명/없음 시 카드 축소
- 가드 테스트 `tests/test_today_list_css.py` 5개 신규 (결함 부활 방지)
- 설계/계획: `docs/superpowers/specs/2026-09-07-today-list-layout-design.md` · `docs/superpowers/plans/2026-09-07-today-list-layout-fix.md`
