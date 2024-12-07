import 'package:kaamwalijobs_new/screens/onboardingScreen/onboarding_info.dart';

class OnboardingItems {
  List<OnboardingInfo> items = [
    OnboardingInfo(
        title: "Search your Maid.",
        descriptions:
            "If you are looking for a maid, babysitter, or cook for your home, you have come to the right place.",
        images: "lib/assets/images/1.png"),
    OnboardingInfo(
        title: "Search your Job !",
        descriptions:
            "If you are looking for job opportunities in roles such as maid, cook, babysitter, eldercare, and many others, KaamwaliJobs is here to assist you.",
        images: "lib/assets/images/2.png"),
    OnboardingInfo(
        title: "Trusted Services",
        descriptions:
            "Experience Seamless, Reliable Support for Your Home, Family, and Lifestyle -- Our Experts Are Here To Help!",
        images: "lib/assets/images/3.png")
  ];
}

class ListViewItems {
  List<ListViewInfo> items = [
    ListViewInfo(
        images: "lib/assets/images/japa_maid.png", name: "Jhadu Pocha"),
    ListViewInfo(images: "lib/assets/images/house_maid.png", name: "Maid"),
    ListViewInfo(
        images: "lib/assets/images/baby_sitter.png", name: "BabySitter"),
    ListViewInfo(images: "lib/assets/images/cook.png", name: "cook"),
    ListViewInfo(images: "lib/assets/images/nanny.png", name: "Nany"),
    ListViewInfo(
        images: "lib/assets/images/elder_sitter.png", name: "Elder Care")
  ];
}

class FeaturedJobsItems {
  List<FeaturedJobsInfo> items = [
    // ListViewInfo(images: "lib/assets/images/japa_maid.png", name: "Jhadu Pocha"),
    FeaturedJobsInfo(
        images: "lib/assets/images/house_maid.png",
        name: "Maid",
        locations: "Mumbai - 24 HRS"),
    FeaturedJobsInfo(
        images: "lib/assets/images/baby_sitter.png",
        name: "BabySitter",
        locations: "Jaipur - 8 HRS"),
    // ListViewInfo(images: "lib/assets/images/cook.png", name: "cook"),
    FeaturedJobsInfo(
        images: "lib/assets/images/nanny.png",
        name: "Nany",
        locations: "Thane - 2 HRS"),
    FeaturedJobsInfo(
        images: "lib/assets/images/elder_sitter.png",
        name: "Elder Care",
        locations: "Kalyan - 3 HRS")
  ];
}
