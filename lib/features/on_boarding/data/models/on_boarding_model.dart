class OnBoardingModel {
  final String title;
  final String description;
  final String imagePath;

  OnBoardingModel({
    required this.title,
    required this.description,
    required this.imagePath,
  });
}

List<OnBoardingModel> onBoardingData = [
  OnBoardingModel(
    title: "حاسس إنك مزنوق؟",
    description:
        "مواد ومشاريع وكويزات داخلة في بعض؟\nمتشيلش هم، إحنا هنا عشانك",
    imagePath: "assets/images/on_boarding_one.png",
  ),
  OnBoardingModel(
    title: "لمّ الدنيا",
    description: "كل حاجة تخص دراستك في مكان واحد.\nرتب وقتك ومهامك بسهولة",
    imagePath: "assets/images/on_boarding_two.png",
  ),
  OnBoardingModel(
    title: "سيطر",
    description: "ابدأ الترم وأنت عارف كل خطوة.\nخليك دايماً سابق بخطوة",
    imagePath: "assets/images/on_boarding_three.png",
  ),
];
