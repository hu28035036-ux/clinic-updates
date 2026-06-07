# 도수치료예약 배포 저장소

이 저장소는 `도수치료예약 (Dosu Clinic)` Windows 배포본과 자동 업데이트 매니페스트를 제공합니다.
소스 코드는 [`hu28035036-ux/clinic-app`](https://github.com/hu28035036-ux/clinic-app)에서 관리합니다.

## 최신 배포

- 버전: `v1.3.15`
- 배포일: `2026-06-08`
- ZIP: [`dosu_clinic_v1.3.15_20260608.zip`](https://hu28035036-ux.github.io/clinic-updates/dosu_clinic_v1.3.15_20260608.zip)
- SHA256: `E23F074BAE4D340DD8B41AB911DD0F6B4D0FB79040A7A823E801FE0658D5E1AB`
- 매니페스트: [`manifest.json`](https://hu28035036-ux.github.io/clinic-updates/manifest.json)

## v1.3.15 변경 사항

- 서브 PC에서 더 최신 입력이 생긴 뒤에도 메인 PC의 이전 변경을 누락하지 않도록 pull 기준 보정
- 오래된 원격 삭제 op가 더 최신 로컬 환자 기록을 지우지 않도록 충돌 처리 보강
- sync push 일부 실패 시 정상 op는 커밋되고 실패 op만 따로 보고되도록 수정
- 의사/자원 변경 로그도 peer PC에 적용되도록 동기화 엔티티 매핑 추가
- GitHub README와 배포 매니페스트 갱신

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
