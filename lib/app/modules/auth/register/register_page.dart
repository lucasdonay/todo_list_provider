import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensios.dart';
import 'package:todo_list_provider/app/core/widgets/todo_list_field.dart';
import 'package:todo_list_provider/app/core/widgets/todo_list_logo.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

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
      body: ListView(
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
            child: Form(
                child: Column(
              children: [
                TodoListField(label: 'E-mail'),
                const SizedBox(
                  height: 20,
                ),
                TodoListField(label: 'Senha', obscureText: true),
                const SizedBox(
                  height: 20,
                ),
                TodoListField(label: 'Confirmar senha', obscureText: true),
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
                    onPressed: () {},
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text('Criar'),
                    ),
                  ),
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }
}
