import 'package:flutter/material.dart';
import 'package:material_3_testing/data/model/category.dart';

class SpendingCategoryItem extends StatelessWidget {
  final Category item;
  final Key itemKey;
  final VoidCallback onDismissed;
  final VoidCallback? onTap;

  const SpendingCategoryItem({
    Key? key,
    required this.item,
    required this.itemKey,
    required this.onDismissed,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => onDismissed(),
      background: Container(
        color: Theme.of(context).colorScheme.errorContainer,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Text(
              'DELETE',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onErrorContainer,
              ),
            ),
          ),
        ),
      ),
      confirmDismiss: (direction) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Delete Category?'),
          content: Text(
            'Are you sure you want to delete ${item.name}?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('No'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Yes'),
            ),
          ],
        ),
      ),
      key: itemKey,
      child: ListTile(title: Text(item.name), onTap: onTap),
    );
  }
}
