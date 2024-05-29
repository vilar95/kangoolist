import 'package:flutter/material.dart';
import 'package:flutter_kangoolist/_core/constants/kangoolist_colors.dart';
import 'package:flutter_kangoolist/_core/kangoolist_routes.dart';
import 'package:flutter_kangoolist/kangoolists/models/kangoolist.dart';
import '../../../_core/helpers/time_passed.dart';

class HomeKangooListItem extends StatelessWidget {
  final KangooList kangooList;
  final Function showOptionModal;
  const HomeKangooListItem({
    super.key,
    required this.kangooList,
    required this.showOptionModal,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: const Icon(Icons.list),
          title: Text(
            kangooList.name,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          subtitle: Text(getTextualTimePassed(kangooList.dateUpdate)),
          trailing: InkWell(
            child: const Icon(Icons.more_vert),
            onTap: () {
              showOptionModal(kangooList);
            },
          ),
          contentPadding: EdgeInsets.zero,
          onTap: () {
            Navigator.pushNamed(
              context,
              KangooListRoutes.products,
              arguments: kangooList,
            );
          },
        ),
        const Divider(
          color: KangooListColors.graydark,
        ),
      ],
    );
  }
}
