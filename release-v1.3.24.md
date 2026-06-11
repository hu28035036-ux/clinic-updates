# v1.3.24 자동 업데이트 매니페스트 조회 핫픽스

## 버그 수정

- `URL 저장` 후에도 일부 PC에서 `매니페스트 조회 실패:`가 원인 없이 표시되던 흐름을 보강했습니다.
- `업데이트 확인` 버튼을 누를 때 현재 입력칸의 매니페스트 URL을 서버로 함께 보내고, 서버 설정에도 저장하도록 변경했습니다.
- HTTPS 매니페스트와 ZIP 다운로드 조회 시 PyInstaller 배포본에 포함된 `certifi` 인증서 번들을 우선 사용합니다.
- 매니페스트/다운로드 조회 실패 시 빈 오류 대신 방화벽, 인증서, 네트워크 등 실제 원인이 화면에 표시되도록 했습니다.

## 검증

- 업데이트 매니페스트 URL payload 저장/조회 회귀 테스트 추가 및 통과
- 업데이트 UI가 입력칸 URL을 `check-update` 요청 body에 포함하는지 검사
- `tests/test_update_completion_notice.py` + PyInstaller hidden import 회귀 테스트: `241 passed`
- `venv\Scripts\python.exe -m ruff check app tests`: 통과
- `venv\Scripts\python.exe run.py --check`: 통과
- `venv\Scripts\pyinstaller.exe --noconfirm dosu_clinic.spec`: 통과
- 배포 exe `--check`: 통과

## 안내

- 매니페스트 URL은 아래 주소가 맞습니다.

```text
https://hu28035036-ux.github.io/clinic-updates/manifest.json
```

- v1.3.22에서 자동 조회가 계속 실패하면 ZIP을 수동 다운로드해 프로그램 폴더를 교체하면 됩니다. 데이터 폴더 `%APPDATA%\도수치료예약`은 교체하지 않습니다.
