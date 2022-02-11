// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

enum SlidableAction { like }

class SlidableWidget<T> extends StatelessWidget {
  final Widget child;
  final bool isLiked;
  final Function(SlidableAction) onDismissed;
  final Function onTap;

  const SlidableWidget({
    required this.child,
    required this.onDismissed,
    required this.onTap,
    this.isLiked = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: child,
        secondaryActions: <Widget>[
          GestureDetector(
            onTap: () => {onTap(), onDismissed(SlidableAction.like)},
            child: Container(
              padding: EdgeInsets.all(10),
              width: 80,
              height: 90,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.delete,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Delete',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      );
}
