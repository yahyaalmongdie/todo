import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';

class MultiStepSignUp extends StatefulWidget {
  const MultiStepSignUp({super.key});

  @override
  _MultiStepSignUpState createState() => _MultiStepSignUpState();
}

class _MultiStepSignUpState extends State<MultiStepSignUp> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentPage++;
      });
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentPage--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ExpandablePageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        // Page 1: Brand Profile
        _buildSignUpFormPage(
          context,
          title: 'Brand Profile',
          fields: [
            SignUpFormField.username(),
            SignUpFormField.custom(
              key: const Key('brandDescription'),
              attributeKey:
                  const CognitoUserAttributeKey.custom('brandDescription'),
              title: 'Brand Description',
            ),
          ],
          nextButton: true,
        ),
        // Page 2: Owner Profile
        _buildSignUpFormPage(
          context,
          title: 'Owner Profile',
          fields: [
            SignUpFormField.custom(
              key: const Key('ownerName'),
              attributeKey: const CognitoUserAttributeKey.custom('ownerName'),
              title: 'Owner Name',
            ),
            SignUpFormField.email(),
          ],
          nextButton: true,
          backButton: true,
        ),
        // Page 3: Commercial Profile
        _buildSignUpFormPage(
          context,
          title: 'Commercial Profile',
          fields: [
            SignUpFormField.custom(
              key: const Key('commercialLicense'),
              attributeKey:
                  const CognitoUserAttributeKey.custom('commercialLicense'),
              title: 'Commercial License',
            ),
            SignUpFormField.password(),
            SignUpFormField.passwordConfirmation(),
          ],
          backButton: true,
          submitButton: true,
        ),
      ],
    );
  }

  Widget _buildSignUpFormPage(
    BuildContext context, {
    required String title,
    required List<SignUpFormField> fields,
    bool backButton = false,
    bool nextButton = false,
    bool submitButton = false,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          SignUpForm(),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (backButton)
                ElevatedButton(
                  onPressed: _previousPage,
                  child: const Text('Back'),
                ),
              if (nextButton)
                ElevatedButton(
                  onPressed: _nextPage,
                  child: const Text('Next'),
                ),
              if (submitButton)
                ElevatedButton(
                  onPressed: () {
                    // The SignUpForm automatically submits the data.
                  },
                  child: const Text('Submit'),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
