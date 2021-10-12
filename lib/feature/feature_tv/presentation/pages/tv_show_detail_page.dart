import 'package:flutter/material.dart';

class TvShowDetailPage extends StatefulWidget {
  static const routeName = '/tvShowDetailPage';

  final String tvId;

  const TvShowDetailPage({required this.tvId, Key? key}) : super(key: key);

  @override
  State<TvShowDetailPage> createState() => _TvShowDetailPageState();
}

class _TvShowDetailPageState extends State<TvShowDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
