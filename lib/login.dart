import 'package:flutter/material.dart';
class Login extends StatelessWidget {
const Login();
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: const Text("Hello world!")),
body: Center(
child: Card(
child: Padding(
padding: const EdgeInsets.all(16),
child: IntrinsicHeight(
child: SizedBox(
height: 350,
width: 300,
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: <Widget>[
TextField(
decoration: const InputDecoration(
border: OutlineInputBorder(),
hintText: 'Username',
),
),
const SizedBox(height: 15),
TextField(
decoration: const InputDecoration(
  border: OutlineInputBorder(),
hintText: 'Password',
),
),
const SizedBox(height: 15),
TextButton(
onPressed: () {},
child: const Text("Submit"),
),
],
),
),
),
),
),
),
);
}
}