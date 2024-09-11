import 'package:cadastro/models/users.dart';
import 'package:cadastro/view/ShowUsers.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addController = TextEditingController();

  List<Users> users = [];

  bool masculino = false;
  bool feminino = false;

  void salvar() {
    if (_validateForm()) {
      String sexController;
      if (masculino) {
        sexController = 'Masculino';
      } else if (feminino) {
        sexController = 'Feminino';
      } else {
        sexController = '';
      }

      users.add(Users(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        address: addController.text,
        sex: sexController,
      ));

      _clearFields();
    }
  }

  bool _validateForm() {
    if (nameController.text.isEmpty) {
      _showSnackBar('Insira o nome completo');
      return false;
    }

    if (!emailController.text.contains('@') ||
        !emailController.text.contains('.')) {
      _showSnackBar('Insira um email válido');
      return false;
    }

    if (phoneController.text.isEmpty || phoneController.text.length < 11) {
      _showSnackBar('Insira um telefone válido');
      return false;
    }

    if (addController.text.isEmpty) {
      _showSnackBar('Insira o endereço');
      return false;
    }

    if (!masculino && !feminino) {
      _showSnackBar('Selecione o sexo');
      return false;
    }

    return true;
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _clearFields() {
    nameController.clear();
    emailController.clear();
    phoneController.text = ""; // Limpa o campo de número de telefone
    addController.clear();
    masculino = false;
    feminino = false;
    setState(() {}); // Atualiza o estado dos checkboxes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Usuário'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(padding: EdgeInsets.all(8.0)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nome Completo',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextField(
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: IntlPhoneField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'Telefone',
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
              initialCountryCode: 'BR',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextField(
              controller: addController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Endereço',
              ),
            ),
          ),
          Row(
            children: [
              Checkbox(
                value: masculino,
                onChanged: (bool? value) {
                  setState(() {
                    masculino = value!;
                    if (masculino) {
                      feminino = false;
                    }
                  });
                },
              ),
              const Text('Masculino'),
              Checkbox(
                value: feminino,
                onChanged: (bool? value) {
                  setState(() {
                    feminino = value!;
                    if (feminino) {
                      masculino = false;
                    }
                  });
                },
              ),
              const Text('Feminino'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  salvar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Informações salvas com sucesso!'),
                      action: SnackBarAction(
                        label: 'Fechar',
                        onPressed: () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        },
                      ),
                    ),
                  );
                },
                child: const Text('Salvar'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (users.isNotEmpty) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ShowUsers(users: users)));
                  } else {
                    const snackBar = SnackBar(
                      content: Text('Insira, pelo menos, 1 usuário'),
                      backgroundColor: Colors.red,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: const Text('Mostrar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
