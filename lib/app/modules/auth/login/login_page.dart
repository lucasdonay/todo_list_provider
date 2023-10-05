import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/widgets/todo_list_logo.dart';
import 'package:sign_in_button/sign_in_button.dart';

import '../../../core/widgets/todo_list_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

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
                          child: Column(
                        children: [
                          TodoListField(
                            label: 'E-mail',
                            obscureText: false,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TodoListField(
                            label: 'Senha',
                            obscureText: true,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: Text('Esqueceu sua senha?'),
                              ),
                              ElevatedButton(
                                onPressed: () {},
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
                          Container(
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
                                onPressed: () {},
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
