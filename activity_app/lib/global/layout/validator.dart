String? validateEmail(String value) {
  if (value == null || value.isEmpty) {
    return 'Enter email here';
  }
  // Add more complex validation logic if needed
  // For example, to validate email format using regular expressions

  return null; // Return null if input is valid
}
