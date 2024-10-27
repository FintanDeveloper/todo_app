import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class TodoTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool isComplete;
  final void Function() onEditPressed;
  final void Function() onDeletePressed;
  final void Function() onStatusPressed;
  const TodoTile({
    super.key,
    required this.title,
    required this.subTitle,
    required this.isComplete,
    required this.onEditPressed,
    required this.onDeletePressed,
    required this.onStatusPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: resHeight(72, context),
      padding: EdgeInsets.symmetric(
          horizontal: resWidth(10, context), vertical: resHeight(10, context)),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: resWidth(180, context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: resHeight(16, context),
                    color: darkPurple,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subTitle.split('\n').join(', '),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: resHeight(14, context),
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: onEditPressed,
                icon: const Icon(Icons.edit_outlined),
                color: darkPurple,
              ),
              IconButton(
                onPressed: onDeletePressed,
                icon: const Icon(CupertinoIcons.delete),
                color: darkPurple,
              ),
              IconButton(
                onPressed: onStatusPressed,
                icon: isComplete
                    ? Icon(CupertinoIcons.check_mark_circled_solid)
                    : Icon(CupertinoIcons.check_mark_circled),
                color: darkPurple,
              )
            ],
          )
        ],
      ),
    );
  }
}
