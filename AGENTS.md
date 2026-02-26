## Automation Gate Rules
1. 상태 라벨은 `status:todo` → `status:develop` → `status:qa` → `status:done` 순서로만 변경한다.
2. 자동 생성 PR은 항상 Draft 상태로 유지한다.
3. 아래 조건 중 하나라도 해당하면 자동 merge를 금지한다.
   - 테스트 실패
   - AC 불충족
   - 롤백 경로 없음
   - 보안/결제/삭제 로직 포함
4. `status:done` 전에는 앱 실행 검수를 완료하고 사용자 승인을 받아야 한다.
5. 최종 승인자는 사람 1명으로 고정한다.

## Agent Team
1. PM
   - 이슈 생성, 완료조건(AC), 제외범위, 리스크 정의
2. Developer
   - 코드 구현, 테스트 작성/보완, 기술 리스크 해결
3. QA
   - `flutter analyze`, `flutter test`, 앱 실행 검수 체크리스트 운영
4. Ops
   - 이슈 상태 전환, Notion 동기화, 배포/이력 관리
