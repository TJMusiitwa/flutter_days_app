import 'package:fluent_ui/fluent_ui.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(
        leading: IconButton(
            icon: const Icon(FluentIcons.back),
            onPressed: () => Navigator.of(context).pop()),
        title: const Text('Feedback'),
      ),
      content: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '''We’d love to hear your feedback; good or bad. If we didn't make you feel special, we'd like to make it up to you. Please let us know what happened during your visit and we'll get in touch with you soon.
                    \n\nThe information you provide us will be treated in the strictest confidence and may be used for improving our service delivery purposes. A copy of the completed form will be automatically sent to the email address supplied.''',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),
            const TextBox(
              header: 'First Name',
              placeholder: 'Enter your first name',
              autofillHints: [AutofillHints.givenName],
            ),
            const SizedBox(height: 20),
            const TextBox(
              header: 'Last Name',
              placeholder: 'Enter your last name',
              autofillHints: [AutofillHints.familyName],
            ),
            const SizedBox(height: 20),
            const InfoLabel(
              label: 'Restaurant Location',
              child: AutoSuggestBox(
                items: <String>[
                  'Kira Road',
                  'Lugogo Mall',
                  'Jinja Road',
                  'Bombo Road',
                  'Oasis Mall',
                  'Victoria Mall',
                  'Cargen House'
                ],
                placeholder: 'Restaurant Location',
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: DatePicker(
                header: 'Date of Visit',
                selected: DateTime.now(),
                startYear: DateTime.now().year - 1,
                endYear: DateTime.now().year,
              ),
            ),
            const SizedBox(height: 20),
            const TextBox(
              header: 'Feedback',
              placeholder: 'Enter your feedback',
              keyboardType: TextInputType.multiline,
              maxLines: 4,
              textInputAction: TextInputAction.newline,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 250,
              child: FilledButton(child: const Text('Send'), onPressed: () {}),
            ),
          ],
        ),
      ),
    );
  }
}
