# v1.3.19 매출 기록/일일 현금 기입장/일일보고 연동

## 추가/수정

- 매출 기록 입력 항목을 `현금`, `카드`, `계좌`, `미수납`, `기타`, `메모`로 정리했습니다.
- 현금/카드/계좌/미수납/기타 금액 입력에서 마이너스 값을 허용했습니다.
- 일일 현금 기입장을 매출 관리 하위탭으로 분리했습니다.
- 권종별 수량 입력 시 단위별 금액과 총합이 자동 계산되도록 했습니다.
- 일일보고 업무일지 반영 영역에 매출 기록과 정산 집계를 연결했습니다.
- 신규 환자 등록 후 새 예약창 환자 검색 캐시 갱신을 보강했습니다.
- 미니캘린더 선택일 표시와 좁은 브라우저 폭 예약표 표시를 보강했습니다.
- `revenue_records.unpaid_amount` 컬럼을 추가하는 M029 마이그레이션을 포함했습니다.

## 검증

- `venv\Scripts\python.exe -m pytest`: `2194 passed, 1 skipped, 10 xfailed`
- `venv\Scripts\python.exe -m ruff check .`: 통과
- `venv\Scripts\python.exe run.py --check`: 통과
- `node --check app\static\js\ai_helper.js`: 통과
- `venv\Scripts\pyinstaller.exe --noconfirm dosu_clinic.spec`: 통과
- 배포 exe `--check`: 통과

## 배포 파일

- ZIP: `dosu_clinic_v1.3.19_20260610.zip`
- SHA256: `EDEB798712F72877778FA403D09B452289D109D6DCA03AB4F55BF2E56A6F5F18`
- Manifest: `https://hu28035036-ux.github.io/clinic-updates/manifest.json`
