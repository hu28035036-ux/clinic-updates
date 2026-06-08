# v1.3.17 환자 검색/삭제 반영 및 예약 상세 UI 정리

## 수정/안정화

- 환자 관리 검색 기본 범위를 `전체`로 맞춰 예약 탭 빠른 검색과 환자 탭 검색 결과 기준을 통일했습니다.
- 환자 저장/삭제 후 로컬 환자 캐시, 최근 검색, 빠른 검색 상태, 환자 수 배지를 즉시 갱신하도록 보강했습니다.
- 삭제 직후 같은 검색어도 서버에서 다시 조회하도록 환자 검색 요청에 캐시 무효화 값을 추가했습니다.
- 예약 보드의 이름 표시를 중앙 정렬했습니다.
- 예약 상세 모달 버튼을 오른쪽 정렬, 동일 높이, 작은 크기로 통일했습니다.

## 검증

- `venv\Scripts\python.exe -m pytest tests\test_19_7_patients_notes.py::test_patients_search_endpoint_still_works tests\test_19_7_patients_notes.py::test_patients_endpoint_still_works`: `2 passed`
- `venv\Scripts\python.exe run.py --check`: 통과
- `node --check app\static\js\ai_helper.js`: 통과
- `node --check app\static\js\ai_leave_helper.js`: 통과
- 브라우저 확인: 콘솔 오류 없음, `app.css?v=1.3.17`, 환자 검색 기본값 `전체`, 예약 보드 중앙 정렬 확인
- `venv\Scripts\pyinstaller.exe --noconfirm dosu_clinic.spec`: 통과
- 배포 exe `--check`: 통과

## 배포 파일

- ZIP: `dosu_clinic_v1.3.17_20260608.zip`
- SHA256: `02A38BA937F3CFC9AA9137E04ABA424848E9448AA46E63E762555A7C9093F89E`
- Manifest: `https://hu28035036-ux.github.io/clinic-updates/manifest.json`
