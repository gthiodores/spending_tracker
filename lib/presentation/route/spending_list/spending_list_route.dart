import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_3_testing/presentation/bloc/spending_list/spending_list_bloc.dart';
import 'package:material_3_testing/routes.dart';

class SpendingListRoute extends StatelessWidget {
  const SpendingListRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SpendingListBloc(),
      child: BlocConsumer<SpendingListBloc, SpendingListState>(
        listener: (context, state) {
          if (state.message != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message!)),
            );
          }
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: const Text('Overview'),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () => Navigator.pushNamed(context, routeCategory),
                icon: const Icon(Icons.category_rounded),
                tooltip: 'Categories',
              ),
              IconButton(
                onPressed: () => Navigator.pushNamed(context, routeSetting),
                icon: const Icon(Icons.settings),
                tooltip: 'Settings',
              ),
            ],
          ),
          body: state.objects.isEmpty
              ? const Center(
                  child: Text('Generate objects with FAB!'),
                )
              : CustomScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.all(8),
                      sliver: SliverToBoxAdapter(
                        child: TextFormField(
                          onChanged: (content) => context
                              .read<SpendingListBloc>()
                              .add(SpendingListFilter(content)),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Search'),
                          ),
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          if (index == state.filteredObjects.length) {
                            return const SizedBox(height: 56);
                          }

                          final dummyObj = state.filteredObjects[index];
                          return ListTile(
                            title: Text(dummyObj.name),
                            subtitle: Text("${dummyObj.age} years old"),
                          );
                        },
                        childCount: state.filteredObjects.length + 1,
                      ),
                    ),
                  ],
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () =>
                context.read<SpendingListBloc>().add(SpendingListGenerate()),
            child: const Icon(Icons.generating_tokens),
          ),
        ),
      ),
    );
  }
}
