import 'package:flutter/material.dart';
import "login.dart" ;

void main() {
runApp(const MyApp());
}
class MyApp extends StatelessWidget {
const MyApp({Key? key});
@override
Widget build(BuildContext context) {
return MaterialApp(
title: 'Login',
theme: ThemeData(
colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
),
home: const Login(),
);
}
}