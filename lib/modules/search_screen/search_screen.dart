import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_web_linux_app/shared/components/components.dart';
import 'package:news_web_linux_app/shared/cubit/cubit.dart';
import 'package:news_web_linux_app/shared/cubit/states.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).search;

        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultTextFormField(
                  controller: searchController,
                  type: TextInputType.text,
                  onChanged: (value) {
                    NewsCubit.get(context).getSearch(value);
                  },
                  functionValidation: (value) {
                    if (value!.isEmpty) {
                      return 'الحقل لا يجب أن يكون فارغ';
                    }
                    return null;
                  },
                  hintText: "أبحث في الأخبار ...",
                  hintTextDirection: TextDirection.rtl,
                  textDirection: TextDirection.rtl,
                  hintStyle: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                  suffixIcon: Icons.search,
                ),
              ),
              Expanded(
                child: defaultBuilderArticle(
                  list,
                  isSearch: true,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
