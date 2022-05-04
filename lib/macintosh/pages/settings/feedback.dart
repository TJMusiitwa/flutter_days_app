import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MacosScaffold(
      toolBar: const ToolBar(title: Text('Share your feedback')),
      children: [
        ContentArea(
          builder: (context, scrollController) => MacosScrollbar(
            controller: scrollController,
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: const [],
              ),
            ),
          ),
        )
      ],
    );
  }
}
