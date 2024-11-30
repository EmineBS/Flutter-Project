import 'package:flutter/material.dart';

import 'empty_save_page.dart';

class SavePage extends StatelessWidget {
  const SavePage({
    super.key,
    this.type = "Achat",
  });

  final String type;

  @override
  Widget build(BuildContext context) {
    return EmptySavePage(type: type);
  }
}
