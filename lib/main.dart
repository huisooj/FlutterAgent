import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _signedInEmail;

  void _onLogin(String email) {
    setState(() {
      _signedInEmail = email;
    });
  }

  void _onLogout() {
    setState(() {
      _signedInEmail = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Agent',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF176FF2)),
      ),
      home: _signedInEmail == null
          ? LoginScreen(onLogin: _onLogin)
          : HomeScreen(email: _signedInEmail!, onLogout: _onLogout),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.onLogin});

  final ValueChanged<String> onLogin;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _emailError;
  String? _passwordError;
  bool _isSubmitting = false;

  bool _isValidEmail(String value) {
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value);
  }

  Future<void> _submit() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    setState(() {
      _emailError = null;
      _passwordError = null;
    });

    var hasError = false;
    if (email.isEmpty) {
      _emailError = '이메일을 입력해 주세요.';
      hasError = true;
    } else if (!_isValidEmail(email)) {
      _emailError = '올바른 이메일 형식을 입력해 주세요.';
      hasError = true;
    }

    if (password.isEmpty) {
      _passwordError = '비밀번호를 입력해 주세요.';
      hasError = true;
    }

    if (hasError) {
      if (mounted) {
        setState(() {});
      }
      return;
    }

    setState(() {
      _isSubmitting = true;
    });
    await Future<void>.delayed(const Duration(milliseconds: 700));
    if (!mounted) {
      return;
    }
    setState(() {
      _isSubmitting = false;
    });
    widget.onLogin(email);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '환영합니다',
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '계정으로 로그인해 서비스를 이용하세요.',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 28),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: '이메일',
                      hintText: 'name@example.com',
                      border: OutlineInputBorder(),
                    ).copyWith(errorText: _emailError),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: '비밀번호',
                      border: OutlineInputBorder(),
                    ).copyWith(errorText: _passwordError),
                  ),
                  const SizedBox(height: 18),
                  FilledButton(
                    onPressed: _isSubmitting ? null : _submit,
                    child: _isSubmitting
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('로그인'),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () {},
                    child: const Text('비밀번호를 잊으셨나요?'),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('회원가입'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.email, required this.onLogout});

  final String email;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return _MainScreen(email: email, onLogout: onLogout);
  }
}

class _MainScreen extends StatefulWidget {
  const _MainScreen({required this.email, required this.onLogout});

  final String email;
  final VoidCallback onLogout;

  @override
  State<_MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<_MainScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      _HomeTab(email: widget.email),
      _SettingsTab(onLogout: widget.onLogout),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? '홈' : '설정'),
      ),
      body: SafeArea(child: tabs[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: '설정'),
        ],
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab({required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '접속 이메일: $email',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          Text(
            '홈 화면에 오신 것을 환영합니다.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 24),
          _SummaryCard(
            title: '최근 활동',
            content: '최근 로그인: 오늘',
            icon: Icons.history,
          ),
          const SizedBox(height: 12),
          _SummaryCard(
            title: '빠른 작업',
            content: '설정 탭에서 환경을 조정해 보세요.',
            icon: Icons.bolt,
          ),
        ],
      ),
    );
  }
}

class _SettingsTab extends StatefulWidget {
  const _SettingsTab({required this.onLogout});

  final VoidCallback onLogout;

  @override
  State<_SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<_SettingsTab> {
  bool _notificationEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '설정 화면 초안입니다.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 20),
          SwitchListTile(
            value: _notificationEnabled,
            contentPadding: EdgeInsets.zero,
            title: const Text('알림 받기'),
            onChanged: (value) {
              setState(() {
                _notificationEnabled = value;
              });
            },
          ),
          const Divider(height: 24),
          const ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('앱 버전'),
            trailing: Text('0.1.0'),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: widget.onLogout,
            child: const Text('로그아웃'),
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.title,
    required this.content,
    required this.icon,
  });

  final String title;
  final String content;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 6),
                  Text(content, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
