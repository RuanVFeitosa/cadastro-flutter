import 'package:cadastro/models/users.dart';
import 'package:flutter/material.dart';

class ShowUsers extends StatelessWidget {
  const ShowUsers({
    super.key, 
    required this.users,});

    final List<Users> users;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(users[0].name),
          Text(users[0].email),
          Text(users[0].name),
          Text(users[0].sex),
         
  
        ]
      ),
    );
  }
}