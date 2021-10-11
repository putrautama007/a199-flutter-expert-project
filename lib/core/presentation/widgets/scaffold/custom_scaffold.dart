import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final String title;
  final String searchRoute;
  final Widget body;

  const CustomScaffold({
    required this.title,
    required this.searchRoute,
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
            onPressed: () {
              Navigator.pushNamed(context, searchRoute);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: body,
    );
  }
}
