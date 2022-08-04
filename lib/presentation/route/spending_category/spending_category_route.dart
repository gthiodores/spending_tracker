import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_3_testing/presentation/bloc/spending_category/spending_category_cubit.dart';
import 'package:material_3_testing/routes.dart';
import 'package:material_3_testing/service_locator.dart';

class SpendingCategoryRoute extends StatelessWidget {
  const SpendingCategoryRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SpendingCategoryCubit>(
      create: (_) => SpendingCategoryCubit(
        locator.get(),
        locator.get(),
        locator.get(),
      )..fetchCategories(),
      child: BlocConsumer<SpendingCategoryCubit, SpendingCategoryState>(
        listener: (context, state) {
          if (state.message != null) {
            final action = state.previouslyDeleted == null
                ? null
                : SnackBarAction(
                    label: 'Undo',
                    onPressed: () => context
                        .read<SpendingCategoryCubit>()
                        .undoDeleteCategory(),
                  );

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message!), action: action),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: CustomScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              slivers: [
                const SliverAppBar(
                  title: Text('Categories'),
                  floating: true,
                  snap: true,
                ),
                if (state.categories.isEmpty) ...[
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: Text('No categories found')),
                  )
                ] else ...[
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index == state.categories.length) {
                          return const SizedBox(height: 56);
                        }

                        final item = state.categories[index];
                        return ListTile(title: Text(item.name));
                      },
                      childCount: state.categories.length + 1,
                    ),
                  ),
                ]
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () =>
                  Navigator.pushNamed(context, routeAddCategory).then(
                (value) => context.read<SpendingCategoryCubit>().addedSuccess(),
              ),
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
