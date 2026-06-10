# v1.3.23 백업 복원 안전성 수정 + 장기 운영 안정성 보강

## 버그 수정 (중요)

- **"가장 최근 백업으로 복원" 이 옛 스냅샷을 복원할 수 있던 문제 수정**: 백업 목록이 파일명 문자열 정렬로 "최신"을 판정해, 업데이트 직전 스냅샷(`clinic_before_update_*`)이 항상 날짜형 백업보다 최신으로 오인됐습니다. 이제 파일 수정시각(mtime) 기준으로 진짜 최신 백업을 복원하며, 백업 목록 표시 순서도 동일하게 바로잡았습니다.
- **백업 보관 개수 정리 무력화 수정**: 보관 개수(기본 30) 정리가 일반 자동백업만 지우고 업데이트/복원 직전 스냅샷은 영원히 지우지 않았습니다. 스냅샷이 보관 개수 이상 쌓이면 일반 자동백업이 생성 직후 삭제되는 부작용까지 있었습니다. 이제 일반 백업과 스냅샷을 분리해 각각 보관 개수를 적용합니다.
- 업데이트 직전 스냅샷 생성 시에도 보관 개수 정리를 실행합니다 (자동백업을 꺼 둔 환경에서도 스냅샷 무한 누적 방지).
- 감사 로그(audit_log) 5년 보존 정책을 하루 1회 자동 실행합니다 (기존엔 정리 코드만 있고 호출처가 없어 무한 누적).

## 장기 운영 안정성 보강 (데이터 안전 + 동기화)

- SQLite WAL 모드 + busy_timeout 적용: 백업/동기화/예약 저장이 동시에 일어나도 "database is locked" 오류가 나지 않습니다.
- 자동/다운로드 백업이 SQLite 공식 backup API 를 사용합니다 (손상 백업본 방지).
- 복원 시 구 WAL 잔존 파일 정리 + 백그라운드 워커 사전 정지 (파일 교체 충돌 방지).
- config.json 원자적 저장 + 손상 시 `.broken_*` 보존 후 자동 재생성 (프로그램 시작 불가 방지).
- 동기화 변경 기록(SyncOp) 보존 기간 180일 도입, 하루 1회 자동 정리.
- 동기화 push 증분 전송 (`/api/sync/last-ts`, 구버전 폴백 지원) + 모르는 entity 수신 시에도 커서 전진 (영구 재전송 방지).

## 검증

- 신규 회귀 테스트: 백업 정렬/보관정리/일일 유지보수 7건 (`tests/test_backup_rotation.py`) + 동기화 13건 (`tests/test_sync_retention_and_safety.py`)
- `venv\Scripts\python.exe -m pytest tests`: `2215 passed, 1 skipped, 10 xfailed`
- `venv\Scripts\python.exe -m ruff check app tests`: 통과
- `venv\Scripts\python.exe scripts\check_db_path.py`: 통과
- `venv\Scripts\pyinstaller.exe --noconfirm dosu_clinic.spec`: 통과
- 배포 exe `--check`: 통과
- 기존 clinic.db 는 AppData 에 그대로 유지됩니다.

## 배포 방식 변경 안내

- 이번 버전부터 ZIP 은 GitHub Release 자산으로만 배포합니다 (리포에 ZIP 커밋 중단 — 저장소 비대화 방지). 자동 업데이트 동작에는 영향 없습니다.
