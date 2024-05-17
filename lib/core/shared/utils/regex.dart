final RegExp emailPattern = RegExp(
  r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
  r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a"
  r"-zA-Z0-9])?)*$",
  caseSensitive: false,
  multiLine: false,
);

final RegExp passwordPattern = RegExp(r"^(?=.*[A-Z])(?=.*[^a-zA-Z0-9])(?!.*\s).{6,}$");

final RegExp namePattern = RegExp(r"^[A-Za-zÀ-ÖØ-öø-ÿ\s]+$");
