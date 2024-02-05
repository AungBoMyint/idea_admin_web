enum RequestStatus { initial, fetching, morefetching, success, error }

enum SearchStatus { initial, searching, found, notFound }

enum SectionType { none, video, pdf, blog }

enum AuthStatus {
  unknown,
  authenticated,
  unauthenticated,
  signUp,
  signIn,
  forgetPassword,
  forgetPasswordEmailSent
}

enum SignUpStatus { failed, success, userNameAlreadyExist }

enum SignInStatus { failed, success, noActiveAccountFound }

enum EnrollStatus { enrolling, success, fail, initial }

enum MakeCompleteStatus { remotePostNeed, nothing }
