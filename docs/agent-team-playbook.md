# Agent Team Playbook

## Status Flow
`status:todo` -> `status:develop` -> `status:qa` -> `status:done`

## Operating Rules
1. 사용자 요청 즉시 PM이 이슈를 생성하고 `status:todo`를 부여한다.
2. 개발 작업 시작 시 `status:develop`으로 전환한다.
3. 테스트/검증 단계에서 `status:qa`로 전환한다.
4. 앱 실행 검수와 사용자 승인 후에만 `status:done`으로 전환한다.
5. 원격 반영(push/merge)은 사용자 검수 승인 이후에만 수행한다.

## Team Responsibilities
- PM: 요구사항, AC, 제외범위, 리스크 정의 및 우선순위 관리
- Developer: 구현, 리팩터링, 테스트 보강
- QA: 정적 분석, 자동 테스트, 앱 실행 검수
- Ops: 이슈/라벨/Notion 동기화 및 이력 관리

## QA Checklist
1. `flutter analyze` 통과
2. `flutter test` 통과
3. 앱 실행(`flutter run -d macos`) 후 핵심 흐름 수동 검수
4. 회귀 위험 항목 기록
5. 사용자 승인 후 done 전환
