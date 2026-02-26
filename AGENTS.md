## Automation Gate Rules
1. `status:in-progress` 라벨은 완료조건(AC) 확정 이슈에만 부여한다.
2. 자동 생성 PR은 항상 Draft 상태로 유지한다.
3. 아래 조건 중 하나라도 해당하면 자동 merge를 금지한다.
   - 테스트 실패
   - AC 불충족
   - 롤백 경로 없음
   - 보안/결제/삭제 로직 포함
4. 최종 승인자는 사람 1명으로 고정한다.
