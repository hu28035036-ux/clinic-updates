# 도수치료예약 배포 저장소

이 저장소는 `도수치료예약 (Dosu Clinic)` Windows 배포본과 자동 업데이트 매니페스트를 제공합니다.
소스 코드는 [`hu28035036-ux/clinic-app`](https://github.com/hu28035036-ux/clinic-app)에서 관리합니다.

## 최신 배포

- 버전: `v1.3.22`
- 배포일: `2026-06-10`
- ZIP: [`dosu_clinic_v1.3.22_20260610.zip`](https://hu28035036-ux.github.io/clinic-updates/dosu_clinic_v1.3.22_20260610.zip)
- SHA256: `46D0344A04DFF4E2770B6E7D2B6B180DDF89B4FFBF604FF3AF368A118906AA0F`
- 매니페스트: [`manifest.json`](https://hu28035036-ux.github.io/clinic-updates/manifest.json)

## v1.3.22 변경 사항

### 추가/수정

- 카카오톡 일별 수입현황 예시 엑셀의 추가 컬럼을 무시하고 필요한 기간별 데이터 열만 자동 추출
- 날짜/총진료비/공단부담총액/본인부담총액/급여총액/비급여총액을 날짜별로 일일 업무 보고에 반영
- 날짜 없는 마지막 합계 행은 업로드 건너뜀 경고 없이 자동 제외
- 매출 기록의 미수납 입력값은 합계/통계/업무일지에서 차감 금액으로 반영

### 검증 결과

- 예시 엑셀 파일 직접 파싱: `2026-06-09`~`2026-06-10` 2일치 반영 확인
- `venv\Scripts\python.exe -m pytest tests\test_revenue.py`: `9 passed`
- `venv\Scripts\python.exe -m pytest tests\test_migration_spec_discovery.py tests\test_pyinstaller_hidden_imports.py`: `239 passed`
- `venv\Scripts\python.exe -m ruff check .`: 통과
- `venv\Scripts\python.exe run.py --check`: 통과
- `venv\Scripts\pyinstaller.exe --noconfirm dosu_clinic.spec`: 통과
- 배포 exe `--check`: 통과

## v1.3.19 변경 사항

### 추가/수정

- 매출 기록 입력 항목을 `현금`, `카드`, `계좌`, `미수납`, `기타`, `메모`로 정리
- 현금/카드/계좌/미수납/기타 금액의 마이너스 입력 지원
- 일일 현금 기입장을 매출 관리 하위탭으로 분리하고 권종별 수량 기반 자동 합계 계산
- 일일보고 업무일지 반영 영역에 매출 기록과 정산 집계 연결
- 신규 환자 등록 후 새 예약창 환자 검색 캐시 갱신 보강
- 미니캘린더 선택일 표시와 좁은 브라우저 폭 예약표 표시 보강
- `revenue_records.unpaid_amount` 컬럼 추가 마이그레이션 포함

### 검증 결과

- `venv\Scripts\python.exe -m pytest`: `2194 passed, 1 skipped, 10 xfailed`
- `venv\Scripts\python.exe -m ruff check .`: 통과
- `venv\Scripts\python.exe run.py --check`: 통과
- `node --check app\static\js\ai_helper.js`: 통과
- `venv\Scripts\pyinstaller.exe --noconfirm dosu_clinic.spec`: 통과
- 배포 exe `--check`: 통과

## v1.3.17 변경 사항

### 수정/안정화

- 환자 관리 검색 기본 범위를 `전체`로 맞춰 예약 탭 빠른 검색과 환자 탭 검색 결과 기준을 통일
- 환자 저장/삭제 후 로컬 환자 캐시, 최근 검색, 빠른 검색 상태, 환자 수 배지를 즉시 갱신
- 삭제 직후 같은 검색어도 서버에서 다시 조회하도록 환자 검색 요청 캐시 무효화 보강
- 예약 보드의 이름 표시를 중앙 정렬
- 예약 상세 모달 버튼을 오른쪽 정렬, 동일 높이, 작은 크기로 통일

### 검증 결과

- `venv\Scripts\python.exe -m pytest tests\test_19_7_patients_notes.py::test_patients_search_endpoint_still_works tests\test_19_7_patients_notes.py::test_patients_endpoint_still_works`: `2 passed`
- `venv\Scripts\python.exe run.py --check`: 통과
- `node --check app\static\js\ai_helper.js`: 통과
- `node --check app\static\js\ai_leave_helper.js`: 통과
- 브라우저 확인: 콘솔 오류 없음, `app.css?v=1.3.17`, 환자 검색 기본값 `전체`, 예약 보드 중앙 정렬 확인
- `venv\Scripts\pyinstaller.exe --noconfirm dosu_clinic.spec`: 통과
- 배포 exe `--check`: 통과

## v1.3.16 변경 사항

### 수정/안정화

- 매니페스트 자동업데이트 후 새 버전 첫 실행 시 업데이트 완료 안내가 1회만 표시되도록 보강
- `update_last_seen_version` 설정을 실제 중복 안내 방지 기준으로 사용
- 첫 설치 또는 기존 빈 값은 완료 안내를 띄우지 않고 현재 버전으로 조용히 기록해 신규 설치 오탐 방지
- 업데이트 설치 확인 문구와 진행 화면을 화면 멈춤 표현 대신 업데이트 안내 화면/자동 새로고침 흐름으로 정리
- 30초/60초/6분 진단 안내와 업데이터 로그 확인 흐름은 유지해 실제 멈춤 상황을 확인 가능

### 검증 결과

- `venv\Scripts\python.exe -m pytest -p no:cacheprovider`: `2189 passed, 1 skipped, 10 xfailed`
- `venv\Scripts\python.exe -m ruff check .`: 통과
- `venv\Scripts\python.exe run.py --check`: 통과
- `node --check app\static\js\ai_helper.js`: 통과
- `venv\Scripts\pyinstaller.exe --noconfirm dosu_clinic.spec`: 통과
- 배포 exe `--check`: 통과

## v1.3.15 변경 사항 (v1.3.5 기준)

### 추가된 기능

- 직원 카테고리 관리 추가: 치료사/의사 등 운영 분류를 별도 카테고리로 관리
- 치료 항목 카테고리 연결 추가: 치료 항목을 직원 카테고리와 연결해 예약 배정 기준 강화
- 직원별 가능 치료 항목 관리 추가: 카테고리 안에서도 직원별 가능한 치료 항목을 선택 가능
- 정산 기능 추가: 치료 수행 기록 기반 정산 grid/report, snapshot 저장, 수정/삭제, XLSX export
- 매출 기능 추가: 일자·직원 카테고리별 매출 기록, 기간 통계, 전기간 비교, 정산 대비 분석
- 재고 기능 추가: 카테고리별 재고 항목/동적 필드/셀 값 자동 저장
- 기본 치료 항목 fallback 추가: 초기 설정 직후 치료 항목 목록이 비지 않도록 기본값 보강
- 다중 PC 동기화 회귀 테스트 추가: 메인/서브 DB를 분리한 자동 시뮬레이션으로 동기화 검증

### 수정/안정화

- 최초 설정 화면에서 로컬 첫 모드 저장이 관리자 로그인 없이 정상 완료되도록 수정
- `config.json`이 UTF-8 BOM으로 저장되어도 설정 로딩/관리자 로그인이 실패하지 않도록 수정
- 첫 직원 카테고리 생성 직후 예약 모달 치료 항목이 비는 문제 수정
- 환자/직원/예약/재고 입력 후 탭 이동, 자동 저장, 새로고침 보존 흐름 확인
- 서브 PC에서 더 최신 입력이 생긴 뒤에도 메인 PC의 이전 변경을 누락하지 않도록 sync pull 기준 보정
- 오래된 원격 삭제 op가 더 최신 로컬 환자 기록을 지우지 않도록 충돌 처리 보강
- sync push 일부 실패 시 정상 op는 커밋되고 실패 op만 따로 보고되도록 수정
- 의사/자원 변경 로그도 peer PC에 적용되도록 동기화 엔티티 매핑 추가
- 오래 오프라인이었던 PC의 누적 변경이 500건 제한에 걸리지 않도록 local push 범위 보강

### 삭제/정리

- 사용자 기능 삭제 없음
- 기존 직원 가능항목 boolean 방식은 새 카테고리/치료 항목 매핑으로 확장했으며, 기존 호환 필드는 유지
- 운영 데이터 저장 위치는 계속 AppData이며, 업데이트 ZIP은 `clinic.db`를 삭제하거나 덮어쓰지 않음

## 검증 결과

2026-06-08 기준:

- `venv\Scripts\python.exe -m pytest -p no:cacheprovider`: `2186 passed, 1 skipped, 10 xfailed`
- `venv\Scripts\python.exe -m ruff check .`: 통과
- `venv\Scripts\python.exe run.py --check`: 통과
- `node --check app\static\js\ai_helper.js`: 통과
- `venv\Scripts\pyinstaller.exe --noconfirm dosu_clinic.spec`: 통과
- 배포 exe `--check`: 통과

PyInstaller 경고 파일에는 선택 의존성, 타 플랫폼 모듈, 미사용 DB 드라이버 관련 경고가 포함되어 있으며 빌드는 정상 완료되었습니다.

## 자동 업데이트 사용 방법

프로그램 관리자 탭에서 업데이트 매니페스트 URL을 아래 주소로 설정합니다.

```text
https://hu28035036-ux.github.io/clinic-updates/manifest.json
```

이후 관리자 탭의 업데이트 확인/다운로드/설치 흐름을 사용하면 됩니다.

## 수동 설치

1. 최신 ZIP을 다운로드합니다.
2. 기존 프로그램이 실행 중이면 종료합니다.
3. 기존 설치 폴더에 압축을 덮어씁니다.
4. `도수치료예약.exe`를 실행합니다.
5. 화면이 예전처럼 보이면 `Ctrl + Shift + R`로 브라우저 캐시를 새로고침합니다.

## 데이터 안전

운영 데이터는 배포 폴더가 아니라 아래 AppData 경로에 저장됩니다.

```text
%APPDATA%\도수치료예약\
  clinic.db
  config.json
  schema_version.txt
  backups\
```

배포 ZIP은 실행 파일과 `_internal` 폴더를 교체합니다. 정상 업데이트 과정에서 `clinic.db`는 삭제하거나 덮어쓰지 않습니다.

## 기본 관리자 비밀번호

초기 관리자 비밀번호는 `admin1234`입니다. 실제 운영 PC에서는 첫 로그인 후 관리자 탭에서 비밀번호를 변경하세요.
