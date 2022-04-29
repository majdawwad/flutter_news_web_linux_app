import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_web_linux_app/shared/components/components.dart';
import 'package:news_web_linux_app/shared/cubit/cubit.dart';
import 'package:news_web_linux_app/shared/cubit/states.dart';

import 'package:responsive_builder/responsive_builder.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List list = NewsCubit.get(context).sports;

        return ScreenTypeLayout(
          mobile: defaultBuilderArticle(list),
          desktop: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Builder(builder: (context) {
                NewsCubit.get(context).desktopSelectedCollections(true);
                return Expanded(
                  child: defaultBuilderArticle(list),
                );
              }),
              if (list.isNotEmpty)
                Builder(builder: (context) {
                  NewsCubit.get(context).desktopSelectedCollections(false);
                  return Expanded(
                    child: Container(
                      height: double.infinity,
                      color: Colors.grey[200],
                      child: Card(
                        color: Colors.grey[300],
                        margin: const EdgeInsets.all(20.0),
                        elevation: 5.0,
                        shadowColor: Colors.black87,
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Text(
                            "${list[NewsCubit.get(context).selectedCollectionItem]['description']}",
                            style: const TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
            ],
          ),
          breakpoints: const ScreenBreakpoints(
            desktop: 600,
            tablet: 600,
            watch: 100,
          ),
        );
      },
    );
  }
}
