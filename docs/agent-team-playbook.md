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
- PM: 요청 기능을 기존 화면과 이질감 없게 구성하고, 디자인은 기존 화면과 최대한 유사한 느낌으로 정의한다. 필요 기능이 생기면 개발자와 상의해 범위를 확정하고, QA 완료 후 변경/추가 사항 요약과 사이드이펙트 분석 결과를 보고한다.
- Developer: PM 전달 내용을 기준으로 기능을 구현하고 테스트 코드를 함께 작성한다. 개발 중 추가 기능 필요 시 PM과 상의해 방향을 확정하고 QA와 협업해 결과물을 완성한다.
- QA: 개발 결과와 사이드이펙트를 분석한다. 문제 가능성이 있으면 PM 요청사항이라도 이의 제기하고 PM과 협의해 해결안을 확정한다.
- Ops: 이슈/라벨/Notion 동기화 및 이력 관리

## QA Checklist
1. `flutter analyze` 통과
2. `flutter test` 통과
3. 앱 실행(`flutter run -d macos`) 후 핵심 흐름 수동 검수
4. 회귀 위험 항목 기록
5. 사용자 승인 후 done 전환
