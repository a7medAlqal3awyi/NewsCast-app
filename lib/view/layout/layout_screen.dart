import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/news_cubit.dart';
import '../../cubit/news_state.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.get(context);
        return Scaffold(
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.memory), label: "Technology"),
              BottomNavigationBarItem(icon: Icon(Icons.spa), label: "Health"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.business), label: "Business"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.sports_football), label: "Sports"),
            ],
            currentIndex: cubit.currentIndex,
            onTap: (index) => cubit.changeIndexBottomNavBar(index),
            elevation: 1.5,
            enableFeedback: true,
            unselectedItemColor: Colors.blueGrey,
            selectedItemColor: Colors.teal,
            showUnselectedLabels: true,
            iconSize: 26,
          ),
        );
      },
    );
  }
}
