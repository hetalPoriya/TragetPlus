import 'package:get/get.dart';
import '../screens/screens.dart';

class RouteHelper {
  static String splash = '/splash';
  static String mainScreen = '/mainScreen';
  static String registerScreen = '/registerScreen';
  static String signIn = '/signIn';
  static String getPremiumMemberShip = '/getPremiumMemberShip';
  static String paymentSuccessful = '/paymentSuccessful';
  static String subjectScreen = '/subjectScreen';
  static String revisionScreen = '/revisionScreen';
  static String samplePaperPdf = '/samplePaperPdf';
  static String selectStream = '/selectStream';
  static String myNetwork = '/myNetwork';
  static String yourEarning = '/yourEarning';
  static String withdrawDoneScreen = '/withdrawDoneScreen';
  static String congratsScreen = '/congratsScreen';
  static String transactionHistory = '/transactionHistory';
  static String myReferrals = '/myReferrals';
  static String questionsAndAnswer = '/questionsAndAnswer';
  static String questionAndAnswerTopics = '/questionAndAnswerTopics';
  static String pdfViewerScreen = '/pdfViewerScreen';
  static String resultScreen = '/resultScreen';
  static String solutionScreen = '/solutionScreen';
  static String questionsResults = '/questionsResults';
  static String viewSolutions = '/viewSolutions';
  static String inviteAndEarn = '/inviteAndEarn';
  static String changePassword = '/changePassword';
  static String termsAndConditions = '/termsAndConditions';
  static String aboutUs = '/aboutUs';
  static String editProfile = '/editProfile';
  static String emailScreen = '/emailScreen';
  static String switchClass = '/switchClass';
  static String videoPlayerScreen = '/videoPlayerScreen';
  static String subjectVideo = '/subjectVideo';
  static String notificationScreen = '/notificationScreen';

  static List<GetPage> getPages = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: mainScreen, page: () => const MainScreen()),
    GetPage(name: registerScreen, page: () => const RegisterScreen()),
    GetPage(name: signIn, page: () => const SignIn()),
    GetPage(
        name: getPremiumMemberShip, page: () => const GetPremiumMemberShip()),
    GetPage(
        name: paymentSuccessful, page: () => const PaymentSuccessfulScreen()),
    GetPage(name: subjectScreen, page: () => const SubjectScreen()),
    GetPage(name: revisionScreen, page: () => const RevisionScreen()),
    GetPage(name: samplePaperPdf, page: () => const SamplePaperPdf()),
    GetPage(name: selectStream, page: () => const SelectStream()),
    GetPage(name: myNetwork, page: () => const MyNetwork()),
    GetPage(name: yourEarning, page: () => const YourEarning()),
    GetPage(name: withdrawDoneScreen, page: () => const WithdrawDoneScreen()),
    GetPage(name: congratsScreen, page: () => const CongratsScreen()),
    GetPage(name: transactionHistory, page: () => const TransactionHistory()),
    GetPage(name: myReferrals, page: () => const MyReferrals()),
    GetPage(name: questionsAndAnswer, page: () => const QuestionsAndAnswer()),
    GetPage(
        name: questionAndAnswerTopics,
        page: () => const QuestionAndAnswerTopics()),
    GetPage(name: pdfViewerScreen, page: () => const PdfViewerScreen()),
    GetPage(name: resultScreen, page: () => const ResultScreen()),
    GetPage(name: solutionScreen, page: () => const SolutionScreen()),
    GetPage(name: questionsResults, page: () => const QuestionsResults()),
    GetPage(name: viewSolutions, page: () => const ViewSolutions()),
    GetPage(name: inviteAndEarn, page: () => const InviteAndEarn()),
    GetPage(name: changePassword, page: () => const ChangePassword()),
    GetPage(name: termsAndConditions, page: () => const TermsAndConditions()),
    GetPage(name: aboutUs, page: () => const AboutUs()),
    GetPage(name: editProfile, page: () => const EditProfile()),
    GetPage(name: emailScreen, page: () => const EmailScreen()),
    GetPage(name: switchClass, page: () => const SwitchClass()),
    GetPage(name: videoPlayerScreen, page: () => VideoPlayerScreen()),
    GetPage(name: subjectVideo, page: () => SubjectVideos()),
    GetPage(name: notificationScreen, page: () => const NotificationScreen()),
  ];
}
