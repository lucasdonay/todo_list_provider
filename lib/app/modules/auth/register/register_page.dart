import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensios.dart';
import 'package:todo_list_provider/app/core/widgets/todo_list_field.dart';
import 'package:todo_list_provider/app/core/widgets/todo_list_logo.dart';
import 'package:todo_list_provider/app/modules/auth/register/register_controller.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();
  final confirmPasswordEC = TextEditingController();

  @override
  void dispose() {
    emailEC.dispose();
    passwordEC.dispose();
    confirmPasswordEC.dispose();
    context.read<RegisterController>().removeListener(() {});
    super.dispose();
  }

  @override
  void initState() {
    context.read<RegisterController>().addListener(() {
      final controller = context.read<RegisterController>();
      var sucess = controller.sucess;
      var error = controller.error;
      if (sucess) {
        Navigator.of(context).pop();
      } else if (error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error),
          backgroundColor: Colors.red,
        ));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Todo List',
              style: TextStyle(
                  color: context.primaryColor, fontSize: 15, height: 1.4),
            ),
            Text(
              'Cadastro',
              style: TextStyle(
                  color: context.primaryColor, fontSize: 15, height: 1.4),
            )
          ],
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: ClipOval(
            child: Container(
              color: context.primaryColor.withAlpha(40),
              padding: EdgeInsets.all(8),
              child: Icon(Icons.arrow_back_ios_rounded,
                  size: 20, color: context.primaryColor),
            ),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width * .5,
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: const TodoListLogo(),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Column(
                children: [
                  TodoListField(
                    controller: emailEC,
                    label: 'E-mail',
                    validator: Validatorless.multiple([
                      Validatorless.required('Email requerido'),
                      Validatorless.email('Email invalido')
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TodoListField(
                    controller: passwordEC,
                    label: 'Senha',
                    obscureText: true,
                    validator: Validatorless.multiple([
                      Validatorless.required('Voce precisa digitar uma senha'),
                      Validatorless.min(
                          6, 'Senha precisa ter mais de 6 digitos'),
                      Validatorless.max(
                          20, 'Senha nao pode ter mais que 20 digitos'),
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TodoListField(
                    controller: confirmPasswordEC,
                    label: 'Confirmar senha',
                    obscureText: true,
                    validator: Validatorless.multiple([
                      Validatorless.required('Voce precisa digitar uma senha'),
                      Validatorless.min(
                          6, 'Senha precisa ter mais de 6 digitos'),
                      Validatorless.max(
                          20, 'Senha nao pode ter mais que 20 digitos'),
                      Validatorless.compare(passwordEC, 'Senha diferente')
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        final formValid =
                            _formKey.currentState?.validate() ?? false;

                        if (formValid) {
                          final email = emailEC.text;
                          final password = passwordEC.text;
                          context
                              .read<RegisterController>()
                              .registerUser(email, password);
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text('Criar'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
