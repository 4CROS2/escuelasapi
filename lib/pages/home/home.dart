import 'package:escuelasapi/pages/home/parts/header.dart';
import 'package:escuelasapi/pages/home/parts/products.dart';
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
          SliverPersistentHeader(
            delegate: Header(),
            pinned: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20).add(
              const EdgeInsets.only(top: 40),
            ),
            sliver: const SliverToBoxAdapter(child: Products()),
          )
        ],
      )),
    );
  }
}
