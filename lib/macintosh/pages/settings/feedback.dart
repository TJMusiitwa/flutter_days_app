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
              padding:
                  const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '''We’d love to hear your feedback; good or bad. If we didn't make you feel special, we'd like to make it up to you. Please let us know what happened during your visit and we'll get in touch with you soon.
                    \n\nThe information you provide us will be treated in the strictest confidence and may be used for improving our service delivery purposes. A copy of the completed form will be automatically sent to the email address supplied.''',
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 20),
                  const Label(text: Text('First Name')),
                  const MacosTextField(
                    placeholder: 'Enter your first name',
                    autofillHints: [AutofillHints.givenName],
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 20),
                  const Label(text: Text('Last Name')),
                  const MacosTextField(
                    placeholder: 'Enter your last name',
                    autofillHints: [AutofillHints.familyName],
                  ),
                  const SizedBox(height: 20),
                  const Label(text: Text('Restaurant Location')),
                  MacosPopupButton<String>(
                    value: 'Kira Road',
                    onChanged: (String? newValue) {
                      // setState(() {
                      //   popupValue = newValue!;
                      // });
                    },
                    items: <String>[
                      'Kira Road',
                      'Lugogo Mall',
                      'Jinja Road',
                      'Bombo Road',
                      'Oasis Mall',
                      'Victoria Mall',
                      'Cargen House'
                    ].map<MacosPopupMenuItem<String>>((String value) {
                      return MacosPopupMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  const Label(
                    text: Text('Date of Visit'),
                  ),
                  const SizedBox(height: 20),
                  MacosDatePicker(
                    onDateChanged: (date) => print(date),
                  ),
                  const SizedBox(height: 20),
                  const Label(
                    text: Text('Feedback'),
                  ),
                  const MacosTextField(
                    placeholder: 'Enter your feedback',
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    textInputAction: TextInputAction.newline,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 250,
                    child: PushButton(
                        child: const Text('Send'),
                        buttonSize: ButtonSize.large,
                        onPressed: () {}),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
