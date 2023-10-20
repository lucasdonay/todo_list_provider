import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/notifier/default_listener_notifier.dart';
import 'package:todo_list_provider/app/core/ui/messages.dart';
import 'package:todo_list_provider/app/core/widgets/todo_list_logo.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:todo_list_provider/app/modules/auth/login/login_controller.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/widgets/todo_list_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _emailFocus = FocusNode();

  executar(email, password) {
    context.read<LoginController>().login(email, password);
  }

  @override
  void initState() {
    super.initState();
    DefaultListenerNotifier(changeNotifier: context.read<LoginController>())
        .listener(
      context: context,
      sucessCallback: ((notifier, listenerInstance) {
        print('login efetuado com sucesso');
      }),
      evervoidCallback: (notifier, listenerInstance) {
        if (notifier is LoginController) {
          if (notifier.hasInfo) {
            Messages.of(context).showInfo(notifier.infoMessage!);
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.maxWidth,
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const TodoListLogo(),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 20,
                      ),
                      child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TodoListField(
                                label: 'E-mail',
                                controller: _emailEC,
                                obscureText: false,
                                focusNode: _emailFocus,
                                validator: Validatorless.multiple([
                                  Validatorless.required('Email Obrigatorio'),
                                  Validatorless.email('Email invalido')
                                ]),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TodoListField(
                                  label: 'Senha',
                                  controller: _passwordEC,
                                  obscureText: true,
                                  validator: Validatorless.multiple([
                                    Validatorless.required('Senha Obrigatoria'),
                                    Validatorless.min(6,
                                        'Senha deve conter 6 caractereses pelo menos')
                                  ])),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      if (_emailEC.text.isNotEmpty) {
                                        context
                                            .read<LoginController>()
                                            .forgotPassword(_emailEC.text);
                                      } else {
                                        _emailFocus.requestFocus();
                                        Messages.of(context).showError(
                                            'E-mail não esta preenchido');
                                      }
                                    },
                                    child: Text('Esqueceu sua senha?'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      final formValid =
                                          _formKey.currentState?.validate() ??
                                              false;

                                      if (formValid) {
                                        final email = _emailEC.text;
                                        final password = _passwordEC.text;
                                        executar(email, password);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text('Login'),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffF0F3F7),
                        border: Border(
                          top: BorderSide(
                            width: 2,
                            color: Colors.grey.withAlpha(30),
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 40, right: 40),
                              child: SignInButton(
                                Buttons.google,
                                text: 'Continue com o google',
                                onPressed: () {},
                                padding: EdgeInsets.all(5),
                                shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Nao tem conta?'),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/register');
                                },
                                child: Text('Cadastre-se'),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
