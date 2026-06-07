# 도수치료예약 배포 저장소

이 저장소는 `도수치료예약 (Dosu Clinic)` Windows 배포본과 자동 업데이트 매니페스트를 제공합니다.
소스 코드는 [`hu28035036-ux/clinic-app`](https://github.com/hu28035036-ux/clinic-app)에서 관리합니다.

## 최신 배포

- 버전: `v1.3.16`
- 배포일: `2026-06-08`
- ZIP: [`dosu_clinic_v1.3.16_20260608.zip`](https://hu28035036-ux.github.io/clinic-updates/dosu_clinic_v1.3.16_20260608.zip)
- SHA256: `7E538054300BB2BC9AE020CC60E27AC5E2D9AFA11F4B6AF1618AF1D1800E3DB7`
- 매니페스트: [`manifest.json`](https://hu28035036-ux.github.io/clinic-updates/manifest.json)

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
