# v1.3.22 기간별 데이터 예시 엑셀 형식 호환

## 추가/수정

- 카카오톡으로 받은 `일별 수입현황_YYYYMMDD-YYYYMMDD.xlsx` 형식처럼 `인원합계`, `수납(현금)`, `수납(카드)`, `미수` 등 추가 컬럼이 있어도 필요한 기간별 데이터 열만 자동 추출합니다.
- `날짜`, `총진료비`, `공단부담총액`, `본인부담총액`, `급여총액`, `비급여총액`을 날짜별로 저장해 일일 업무 보고에 반영합니다.
- 날짜가 비어 있는 마지막 합계 행은 업로드 건너뜀 경고 없이 자동 제외합니다.
- 매출 기록의 `미수납` 입력값은 합계/통계/업무일지에서 차감 금액으로 반영합니다.

## 검증

- 예시 엑셀 파일 직접 파싱: `2026-06-09`~`2026-06-10` 2일치 반영 확인
- `venv\Scripts\python.exe -m pytest tests\test_revenue.py`: `9 passed`
- `venv\Scripts\python.exe -m pytest tests\test_migration_spec_discovery.py tests\test_pyinstaller_hidden_imports.py`: `239 passed`
- `venv\Scripts\python.exe -m ruff check .`: 통과
- `venv\Scripts\python.exe run.py --check`: 통과
- `venv\Scripts\pyinstaller.exe --noconfirm dosu_clinic.spec`: 통과
- 배포 exe `--check`: 통과

## 배포 파일

- ZIP: `dosu_clinic_v1.3.22_20260610.zip`
- SHA256: `46D0344A04DFF4E2770B6E7D2B6B180DDF89B4FFBF604FF3AF368A118906AA0F`
- Manifest: `https://hu28035036-ux.github.io/clinic-updates/manifest.json`
