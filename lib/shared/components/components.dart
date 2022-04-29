import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news_web_linux_app/shared/cubit/cubit.dart';

Widget defaultButton({
  double width = double.infinity,
  Color color = Colors.blue,
  bool isUpperCase = false,
  required Function()? function,
  required String text,
}) =>
    Padding(
      padding: const EdgeInsets.only(
        left: 15.0,
        right: 15.0,
      ),
      child: SizedBox(
        width: double.infinity,
        child: MaterialButton(
          color: color,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 18.0,
              bottom: 18.0,
            ),
            child: Text(
              isUpperCase ? text.toUpperCase() : text,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          onPressed: function,
        ),
      ),
    );

Widget defaultTextFormField({
  required TextEditingController? controller,
  required TextInputType type,
  required String? Function(String? value)? functionValidation,
  String? labelText,
  IconData? prifixIcon,
  bool isPassword = false,
  String? hintText,
  TextStyle? hintStyle,
  TextDirection? hintTextDirection,
  IconData? suffixIcon,
  TextStyle? labelStyle,
  TextDirection? textDirection,
  Function()? onTap,
  Function(String)? onChanged,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      validator: functionValidation,
      onChanged: onChanged,
      onTap: onTap,
      textDirection: textDirection,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        hintTextDirection: hintTextDirection,
        hintStyle: hintStyle,
        prefixIcon: Icon(
          prifixIcon,
        ),
        labelStyle: labelStyle,
        suffixIcon: Icon(
          suffixIcon,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );


Widget defaultDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 25.0,
      ),
      child: Container(
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget defaultBuildArticle(article, context, index) => Container(
      color: NewsCubit.get(context).selectedCollectionItem == index &&
              NewsCubit.get(context).isDesktopSelectedCollection
          ? Colors.grey[200]
          : null,
      child: InkWell(
        onTap: () {
          NewsCubit.get(context).selectedCollectionItems(index);
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CachedNetworkImage(
                imageBuilder: (context, imageProvider) => Container(
                  width: 120.0,
                  height: 120.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.deepOrange,
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                ),
                imageUrl: '${article['urlToImage']}',
                placeholder: (context, url) => const Text("لا يوجد صورة, ربما الصورة معطوبة"),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              const SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: SizedBox(
                  height: 120.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          '${article['title']}',
                          style: Theme.of(context).textTheme.headline6,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        '${article['publishedAt']}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

Widget defaultBuilderArticle(list, {isSearch = false}) => ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) =>
            defaultBuildArticle(list[index], context, index),
        separatorBuilder: (context, index) => defaultDivider(),
        itemCount: list.length,
      ),
      fallback: (context) => isSearch
          ? Container()
          : const Center(child: CircularProgressIndicator()),
    );
