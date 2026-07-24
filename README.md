# 도수치료예약 배포 채널 (clinic-updates) — 제품 요구사항 문서 (PRD)

> **문서 성격**: 이 README는 `clinic-updates` 저장소의 제품 요구사항 문서(PRD)다.
> 이 저장소는 프로그램이 아니라, 설치된 앱들이 새 버전을 확인·다운로드하는 **자동 업데이트 배포(전달) 채널**이다.
> 제품 소스는 [`hu28035036-ux/clinic-app`](https://github.com/hu28035036-ux/clinic-app)에서 관리한다.
>
> | 항목 | 값 |
> |------|-----|
> | 저장소 역할 | **배포 채널** (매니페스트 + 릴리스 노트) |
> | 매니페스트 URL | `https://hu28035036-ux.github.io/clinic-updates/manifest.json` |
> | 배포 자산 | ZIP = **GitHub Release 자산** (저장소에 커밋 안 함) |
> | 현재 배포 중(매니페스트) | **v1.3.56** (2026-07-24) — 정산 확정(잠금) |
> | 코드 준비 완료(배포 대기) | **v1.3.57** (2026-07-24) — 기록 메모+야간당직, PC 빌드 후 publish 예정 |

---

## 1. 제품 개요 / 책임 분리

설치된 `도수치료예약` 앱은 관리자 탭에서 매니페스트 URL을 읽어 **현재 버전과 비교 → 새 버전이면 ZIP을 받아 자가 교체**한다.
이 저장소는 그 "비교 기준판"과 "다운로드 주소"를 제공하는 게시판 역할만 한다.

| 저장소 | 역할 | 산출물 |
|--------|------|--------|
| `clinic-app` | 제품을 **만드는 곳** | 소스 → exe → ZIP |
| `clinic-updates` (이 저장소) | 만든 걸 **전달하는 곳** | `manifest.json`, 릴리스 노트 |

## 2. 목표 / 비목표

- **목표**: 인터넷만 되면 각 병원 PC가 클릭 한 번(또는 자동)으로 최신 버전을 무결성 검증과 함께 설치.
- **목표**: 운영 데이터(`clinic.db`)를 절대 건드리지 않는 안전한 갱신.
- **비목표**: 소스 코드 보관(→ `clinic-app`), 빌드 수행, 데이터 호스팅.

## 3. 구성 요소

- **`manifest.json`** — 최신 버전·다운로드 URL·sha256·안내문. GitHub Pages로 서빙.
- **`release-v*.md`** — 버전별 상세 릴리스 노트(텍스트, 영구 보관).
- **`manifest-notes-v*.txt`** — 업데이트 확인 대화상자에 표시되는 짧은 평문.
- **GitHub Release 자산** — 실제 배포 ZIP(`dosu_clinic_v<버전>_<YYYYMMDD>.zip`).
- **`scripts/`, `.github/workflows/`** — 배포 스크립트 및 (구) ZIP 정리 워크플로.

## 4. 업데이트 흐름 (사용자 시나리오)

```
앱 관리자 탭 "업데이트 확인"
   → manifest.json 조회 (GitHub Pages)
   → manifest.version > 설치 버전 ?
        → download_url(Release 자산) 다운로드
        → sha256 검증
        → updater.bat 로 exe + _internal 교체 (clinic.db 유지)
        → 재시작 + 자동 새로고침 + 완료 안내 1회
```

## 5. `manifest.json` 스펙

```json
{
  "version": "1.3.30",
  "download_url": "https://github.com/hu28035036-ux/clinic-updates/releases/download/v1.3.30/dosu_clinic_v1.3.30_20260615.zip",
  "sha256": "db37e274d1183bc81b9a2a0e1926faaef1a28ace58f744bc81a5fc71ea9c8bd6",
  "notes": "업데이트 확인 대화상자에 표시될 평문 안내",
  "mandatory": false
}
```

| 필드 | 의미 |
|------|------|
| `version` | 비교 기준 버전 (`MAJOR.MINOR.PATCH`) |
| `download_url` | Release 자산 ZIP 절대 주소 |
| `sha256` | ZIP 무결성 검증 해시(소문자) |
| `notes` | 사용자 안내 평문(`manifest-notes-v*.txt`에서 주입) |
| `mandatory` | 강제 업데이트 여부(현재 false) |

- BOM 없는 UTF-8로 저장. 파일은 GitHub Pages 반영까지 보통 1~2분 소요.

## 6. 배포 운영 정책

- **표준 배포 스크립트**: `clinic-app/scripts/publish_release.ps1`
  - GitHub Release 생성 + ZIP 자산 업로드 → `manifest.json` 갱신 → manifest·릴리스 노트만 커밋·푸시.
  - `gh` CLI가 있으면 사용, 없으면 git 자격증명 기반 REST API 폴백.
  - `-DryRun`으로 업로드·커밋 없이 요약만 출력 가능.
- **ZIP은 이 저장소에 커밋하지 않는다** (Release 자산으로만). git 히스토리·GitHub Pages 용량(1GB) 비대를 막기 위함.
  - 단, v1.3.24~v1.3.25 시기에 커밋되어 히스토리/워킹트리에 남은 구 ZIP 일부가 있으며, 정리(force-push)는 별도 진행 대상.
- **ZIP 보관 정책(구 방식 잔재)**: `.github/workflows/prune-update-zips.yml` + `scripts/prune_update_zips.ps1`이 최신 10개만 유지. 현재 표준 방식(Release 자산)에서는 신규 ZIP이 저장소에 추가되지 않는다.

## 7. 사용자 가이드

### 자동 업데이트 설정
앱 관리자 탭의 `업데이트 매니페스트 URL` 입력란에 아래 값만(앞뒤 공백 없이) 입력 후 저장:
```text
https://hu28035036-ux.github.io/clinic-updates/manifest.json
```
ZIP 주소·SHA256은 직접 입력하지 않는다. 저장 후 `업데이트 확인`을 누르면 자동 처리된다.

### 수동 설치 (필요 시)
1. 최신 ZIP 다운로드 → 2. 실행 중인 프로그램 종료 → 3. 기존 설치 폴더에 덮어쓰기 →
4. `도수치료예약.exe` 실행 → 5. 화면이 예전 같으면 `Ctrl + Shift + R`로 캐시 새로고침.

### 데이터 안전
운영 데이터는 배포 폴더가 아니라 아래 경로에 저장되며, 업데이트는 이를 건드리지 않는다.
```text
%APPDATA%\도수치료예약\
  clinic.db / config.json / schema_version.txt / backups\
```

### 기본 관리자 비밀번호
초기값 `admin1234` — 첫 로그인 후 관리자 탭에서 반드시 변경.

## 8. 최신 배포

### 현재 배포 중 — v1.3.56 · 2026-07-24 (매니페스트 서빙 중) — 정산 확정(잠금)

- ZIP: [`dosu_clinic_v1.3.56_20260724.zip`](https://github.com/hu28035036-ux/clinic-updates/releases/download/v1.3.56/dosu_clinic_v1.3.56_20260724.zip) (25.2 MB, GitHub Release 자산)
- SHA256: `6103ae4fe427d67fa3f045be3234e6b0ce22e1fc9b7e16796c075fc0ea6f005d`
- 매니페스트: [`manifest.json`](https://hu28035036-ux.github.io/clinic-updates/manifest.json) (`version: 1.3.56`)
- 변경 요약 ([상세](release-v1.3.56.md)): 정산 확정(잠금) — 매월 1일에 2달 전 정산이 자동 확정되어
  금액 고정(급여 근거 보존). DB·마이그레이션 변동 없음.
- 직전 배포: v1.3.55 (2026-07-16) — 휴무 카운트·과별 보기 + 집계→정산 자동 반영 ([상세](release-v1.3.55.md)).

### 다음 배포 — v1.3.57 · 2026-07-24 (코드 준비 완료, 빌드/배포 대기 ⏳)

> ※ 당초 v1.3.56 으로 준비했으나 정산 확정(잠금)이 v1.3.56 으로 먼저 배포되어 **v1.3.57 로 재배정**.

- 상태: **`clinic-app` main 에 코드 병합 완료.** PC에서 빌드 후 `publish_release.ps1` 실행 시 실제 배포(Release 자산 + manifest.json 갱신)가 이뤄진다.
- ZIP: `dosu_clinic_v1.3.57_20260724.zip` — **빌드 후 생성**.
- SHA256: **빌드 후 `publish_release.ps1`이 자동 계산·주입**.
- 릴리스 노트: [release-v1.3.57.md](release-v1.3.57.md) · 매니페스트 평문: [manifest-notes-v1.3.57.txt](manifest-notes-v1.3.57.txt) (미리 커밋됨).
- 변경 요약:
  - **기록 탭 "메모" 칸 추가** — 차트번호·성함·직원 옆 선택 입력(최대 200자). 차트번호 또는 성함은 여전히 필수.
  - **야간당직 퇴근시간·시간 집계** — 직원별 퇴근시각 입력, 기준 퇴근시간(기본 18:30) 초과분을
    "야간당직 시간"으로 "과별 당직 횟수" 요약에 표시(자정 넘김 처리, 야간당직 전용).
- DB 마이그레이션 m044(기록 메모) + m045(야간당직 end_time) — 컬럼 추가만, 기존 `clinic.db` 전량 보존.

> 배포 절차(PC): `clinic-app` 에서 병합 브랜치 준비(버전 1.3.57 재번호) → `pyinstaller.exe dosu_clinic.spec` 빌드 → `scripts\publish_release.ps1 -Version 1.3.57 -ZipPath ... -NotesPath ..\clinic-updates\release-v1.3.57.md -ManifestNotesPath ..\clinic-updates\manifest-notes-v1.3.57.txt`.
> 스크립트 실행이 끝나면 manifest.json 이 v1.3.57 로 바뀌고, 이 섹션의 "다음 배포"를 "현재 배포 중"으로 옮기면 된다.

> 버전별 상세 변경 이력은 각 `release-v*.md` 파일을 참고한다.
