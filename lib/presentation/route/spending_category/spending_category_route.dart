import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_3_testing/presentation/bloc/spending_category/spending_category_cubit.dart';
import 'package:material_3_testing/presentation/widget/spending_category/spending_category_item.dart';
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
      )..add(SpendingCategoryInit()),
      child: BlocConsumer<SpendingCategoryCubit, SpendingCategoryState>(
        listener: (context, state) {
          if (state.message != null) {
            final action = state.previouslyDeleted == null
                ? null
                : SnackBarAction(
                    label: 'Undo',
                    onPressed: () => context
                        .read<SpendingCategoryCubit>()
                        .add(SpendingCategoryUndoDelete()),
                    textColor: Theme.of(context).colorScheme.onPrimary,
                  );

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message!), action: action),
            );
          }
        },
        builder: (context, state) => Scaffold(
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
                      return SpendingCategoryItem(
                        item: item,
                        itemKey: Key(item.key.toString()),
                        onDismissed: () => context
                            .read<SpendingCategoryCubit>()
                            .add(SpendingCategoryDelete(item)),
                        onTap: () => Navigator.pushNamed(
                          context,
                          routeEditCategory,
                          arguments: item,
                        ),
                      );
                    },
                    childCount: state.categories.length + 1,
                  ),
                ),
              ]
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.pushNamed(context, routeAddCategory),
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
