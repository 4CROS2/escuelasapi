import 'package:escuelasapi/pages/home/parts/header.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
           SliverPersistentHeader(delegate: Header(), pinned: true,)
            
          ],
        )),
    );
  }
}

