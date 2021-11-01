import 'package:flutter/material.dart';
import 'package:libraries/libraries.dart';

class CustomScaffold extends StatelessWidget {
  final String title;
  final String searchRoute;
  final String moduleRoute;
  final Widget body;

  const CustomScaffold({
    required this.title,
    required this.searchRoute,
    required this.moduleRoute,
    required this.body,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            onPressed: () => Modular.to.pushNamed("$moduleRoute$searchRoute",),
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: body,
    );
  }
}
