import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_3_testing/domain/model/ui_category.dart';
import 'package:material_3_testing/service_locator.dart';

import '../../bloc/spending_category/edit_spending_category_cubit.dart';

class EditSpendingCategoryDialog extends StatelessWidget {
  final UiCategory category;

  const EditSpendingCategoryDialog({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditSpendingCategoryCubit(category, locator.get()),
      child: BlocConsumer<EditSpendingCategoryCubit, EditSpendingCategoryState>(
        listener: (context, state) {
          if (state.success) Navigator.pop(context);

          if (state.message != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message!)),
            );
          }
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: const Text('Edit Category'),
            actions: [
              TextButton(
                onPressed: () =>
                    context.read<EditSpendingCategoryCubit>().saveCategory(),
                child: const Text('SAVE'),
              ),
            ],
          ),
          body: state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : CustomScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 8,
                      ),
                      sliver: SliverToBoxAdapter(
                        child: TextFormField(
                          onChanged: (content) => context
                              .read<EditSpendingCategoryCubit>()
                              .updateName(content),
                          initialValue: category.name,
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
        ),
      ),
    );
  }
}
