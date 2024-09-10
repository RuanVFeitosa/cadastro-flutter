import 'package:cadastro/models/users.dart';
import 'package:flutter/material.dart';

class ShowUsers extends StatelessWidget {
  const ShowUsers({
    super.key,
    required this.users,
  });

  final List<Users> users;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'), // Use the title property
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20.0),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          IconData sexIcon;
          if (user.sex == 'Masculino') {
            sexIcon = Icons.boy_outlined;
          } else if (user.sex == 'Feminino') {
            sexIcon = Icons.girl;
          } else {
            sexIcon = Icons.circle_rounded;
          }

          return Column(
            children: [
              Row(
                children: [
                  Icon(sexIcon), Text(' ${user.name}'),
                ],
              ),
              Row(
                children: [
                  Text('${user.email} - ${user.phone} '),
                ],
              ),
              Row(
                children: [
                  Text(user.address),
                ],
              ),
              Row(
                children: [
                  Text(user.sex),
                ],
              ),
              const Divider(
                height: 40,
                thickness: 2,
                indent: 0,
                endIndent: 0,
                color: Colors.black,
              ),
            ],
          );
        },
      ),
    );
  }
}
