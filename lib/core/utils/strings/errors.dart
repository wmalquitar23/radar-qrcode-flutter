String networkError(String action) =>
    "Failed to $action due to connectivity issues";

String unknownError(String failDesc) =>
    "$failDesc. The developers will look on to this issue please clear your data in your applications list";

String loginNetworkError = networkError("login");

String loginClientError = "Invalid email or password";

String loginFailed = "Login Failed";

//common errors
const String NO_INTERNET_CONNECTION = "Please check your internet connection";
