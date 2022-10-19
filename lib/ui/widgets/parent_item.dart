import '/app/models/explore_icon_parent_model.dart';
import 'package:flutter/material.dart';

import 'explore_icon.dart';

class ParentItem extends StatelessWidget {
  const ParentItem({
    Key? key,
    required this.parent,
  }) : super(key: key);

  final ExploreIconParentModel parent;

  @override
  Widget build(BuildContext context) {
    final icons = parent.icons;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                parent.title,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 12.0),
              SizedBox(
                height: 80,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: icons.length,
                  itemBuilder: (ctx, index) {
                    final icon = icons[index];
                    return Padding(
                      padding: const EdgeInsets.only(
                        right: 12.0,
                      ),
                      child: ExploreIcon(icon: icon, parent: parent.title),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        const Divider(
          color: Colors.grey,
          thickness: 5,
        ),
      ],
    );
  }
}
