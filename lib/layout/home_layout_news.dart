import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_web_linux_app/modules/search_screen/search_screen.dart';
import 'package:news_web_linux_app/shared/cubit/cubit.dart';
import 'package:news_web_linux_app/shared/cubit/cubit_mode.dart';

import 'package:news_web_linux_app/shared/cubit/states.dart';

class HomeLayoutNews extends StatelessWidget {
  const HomeLayoutNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'الأخبار',
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SearchScreen()));
                },
                icon: const Icon(
                  Icons.search,
                ),
              ),
              IconButton(
                onPressed: () {
                  AppCubitMode.get(context).changemode();
                },
                icon: const Icon(
                  Icons.brightness_2_outlined,
                ),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items: cubit.botomItem,
            onTap: (index) {
              cubit.changebottomnavbar(index: index);
            },
          ),
        );
      },
    );
  }
}
