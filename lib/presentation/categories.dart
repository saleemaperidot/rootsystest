import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roottest/application/categories/categories_bloc.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<CategoriesBloc>(context)
          .add(CategoriesEvent.categoryInitial());
    });

    return Scaffold(
      body: SafeArea(child: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
          print(state);
          return state.isLoading
              ? Center(
                  child: CircularProgressIndicator(strokeWidth: 40),
                )
              : GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  children: List.generate(state.category.length, (index) {
                    return Container(
                        width: 100,
                        height: 100,
                        child: Image(
                          fit: BoxFit.fill,
                          image: NetworkImage("https://respos.menuclub.uk" +
                              state.category[index].img!),
                        )
                        // "https://respos.menuclub.uk/media/category_images/61b31c9d289e22335b6753b2_Ice_Cream_2.jpg")),
                        );
                  }),
                );
        },
      )),
    );
  }
}
