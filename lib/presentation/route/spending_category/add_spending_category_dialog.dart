import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_3_testing/presentation/bloc/spending_category/add_spending_category_cubit.dart';
import 'package:material_3_testing/service_locator.dart';

class AddSpendingCategoryDialog extends StatelessWidget {
  const AddSpendingCategoryDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddSpendingCategoryCubit(locator.get()),
      child: BlocConsumer<AddSpendingCategoryCubit, AddSpendingCategoryState>(
        listener: (context, state) {
          if (state.success) Navigator.pop(context);

          if (state.message != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message!)),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Add Category'),
              actions: [
                TextButton(
                  onPressed: () =>
                      context.read<AddSpendingCategoryCubit>().saveCategory(),
                  child: const Text('SAVE'),
                ),
              ],
            ),
            body: CustomScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              slivers: [
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  sliver: SliverToBoxAdapter(
                    child: TextFormField(
                      onChanged: (content) => context
                          .read<AddSpendingCategoryCubit>()
                          .updateName(content),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Category Name'),
                        helperText: '* required *',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
