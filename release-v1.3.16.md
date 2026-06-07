# v1.3.16 자동업데이트 완료 안내 안정화

## 수정/안정화

- 매니페스트 자동업데이트 후 새 버전 첫 실행 시 업데이트 완료 안내가 1회만 표시되도록 보강했습니다.
- `update_last_seen_version` 설정을 실제 중복 안내 방지 기준으로 사용합니다.
- 첫 설치 또는 기존 빈 값은 완료 안내를 띄우지 않고 현재 버전으로 조용히 기록해 신규 설치 오탐을 막았습니다.
- 업데이트 설치 확인 문구와 진행 화면을 화면 멈춤 표현 대신 업데이트 안내 화면/자동 새로고침 흐름으로 정리했습니다.
- 30초/60초/6분 진단 안내와 업데이터 로그 확인은 유지해 실제 멈춤 상황을 확인할 수 있게 했습니다.

## 검증

- `venv\Scripts\python.exe -m pytest -p no:cacheprovider`: `2189 passed, 1 skipped, 10 xfailed`
- `venv\Scripts\python.exe -m ruff check .`: 통과
- `venv\Scripts\python.exe run.py --check`: 통과
- `node --check app\static\js\ai_helper.js`: 통과
- `venv\Scripts\pyinstaller.exe --noconfirm dosu_clinic.spec`: 통과
- 배포 exe `--check`: 통과

## 배포 파일

- ZIP: `dosu_clinic_v1.3.16_20260608.zip`
- SHA256: `7E538054300BB2BC9AE020CC60E27AC5E2D9AFA11F4B6AF1618AF1D1800E3DB7`
- Manifest: `https://hu28035036-ux.github.io/clinic-updates/manifest.json`
