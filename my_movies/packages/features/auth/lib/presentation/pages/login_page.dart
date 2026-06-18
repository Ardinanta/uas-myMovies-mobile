import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth_injection.dart';
import '../../domain/entities/auth_session.dart';
import '../bloc/login/login_bloc.dart';
import '../bloc/login/login_event.dart';
import '../bloc/login/login_state.dart';
import '../widgets/login_backdrop.dart';
import '../widgets/login_card.dart';
import '../widgets/login_header.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
    this.loginBloc,
    this.onLogin,
  });

  final LoginBloc? loginBloc;
  final ValueChanged<AuthSession>? onLogin;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => widget.loginBloc ?? createLoginBloc(),
      child: Scaffold(
        body: Stack(
          children: [
            const LoginBackdrop(),
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.containerMargin,
                    vertical: 32,
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 360),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const LoginHeader(),
                        const SizedBox(height: 28),
                        BlocConsumer<LoginBloc, LoginState>(
                          listener: (context, state) {
                            if (state.status == LoginStatus.success &&
                                state.session != null) {
                              widget.onLogin?.call(state.session!);
                            }
                          },
                          builder: (context, state) {
                            return LoginCard(
                              usernameController: _usernameController,
                              passwordController: _passwordController,
                              isLoading: state.status == LoginStatus.loading,
                              errorMessage: state.status == LoginStatus.failure
                                  ? state.message
                                  : null,
                              onLogin: () => _submit(context),
                              onGuestLogin: () => _submitGuest(context),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submit(BuildContext context) {
    context.read<LoginBloc>().add(
      LoginSubmitted(
        username: _usernameController.text,
        password: _passwordController.text,
      ),
    );
  }

  void _submitGuest(BuildContext context) {
    context.read<LoginBloc>().add(const GuestLoginSubmitted());
  }
}
