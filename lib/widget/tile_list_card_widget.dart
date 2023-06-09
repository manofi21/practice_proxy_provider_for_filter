import 'package:flutter/material.dart';

import '../entities/base_model_entity.dart';

class TileListCardWidget extends StatelessWidget {
  final String nameOfTitle;
  final BaseModelEntity baseModelEntity;
  final void Function() onFavorite;
  final VoidCallback onClick;
  const TileListCardWidget({
    Key? key,
    required this.nameOfTitle,
    required this.baseModelEntity,
    required this.onFavorite,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget childItem(String title, String content) {
      final theme = Theme.of(context);
      return Row(children: [
        Expanded(
            flex: 2,
            child: Text(
              title,
              style: theme.textTheme.bodyLarge,
            )),
        const Text(":"),
        const SizedBox(
          width: 15,
        ),
        Expanded(
            flex: 2,
            child: Text(
              content,
              style: theme.textTheme.bodyLarge,
            )),
      ]);
    }

    Widget nameTitle(String title, bool isFavorite) {
      final theme = Theme.of(context);
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              title,
              style: theme.textTheme.bodyLarge?.copyWith(fontSize: 20),
            ),
          ),
          InkWell(
            onTap: onFavorite,
            child: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
            ),
          )
        ],
      );
    }

    return InkWell(
      onTap: onClick,
      child: Card(
        margin: const EdgeInsets.only(left: 20, top: 10, bottom: 20, right: 20),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nameOfTitle,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              nameTitle(baseModelEntity.name, baseModelEntity.isFavorite),
              const SizedBox(height: 10),
              childItem("Category", baseModelEntity.typeDropdown.title ?? ''),
              childItem("Status", baseModelEntity.statusDropdown.title ?? ''),
            ],
          ),
        ),
      ),
    );
  }
}
