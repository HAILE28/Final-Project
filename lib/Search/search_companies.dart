import 'package:flutter/material.dart';
import 'package:ijob_clone_app/Widgets/bottom_nav_bar.dart';

class AllWorkersScreen extends StatefulWidget {
  @override
  State<AllWorkersScreen> createState() => _AllWorkersScreenState();
}

class _AllWorkersScreenState extends State<AllWorkersScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 234, 241, 248), // Light turquoise
            Color.fromARGB(255, 250, 252, 253), // Dark turquoise
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0.2, 0.9],
        ),
      ),
      child: Scaffold(
        bottomNavigationBar: BottomNavigationbarForApp(
          indexNum: 1,
        ),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('All Workers screen'),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.lightBlue, // Light turquoise
                  Colors.lightBlue // Dark turquoise
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [0.2, 0.9],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
