import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_agent/main.dart';

void main() {
  testWidgets('Login screen renders core fields', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('환영합니다'), findsOneWidget);
    expect(find.text('이메일'), findsOneWidget);
    expect(find.text('비밀번호'), findsOneWidget);
    expect(find.text('로그인'), findsOneWidget);
    expect(find.text('회원가입'), findsOneWidget);
  });
}
