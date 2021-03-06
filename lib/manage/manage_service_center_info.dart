import 'package:url_launcher/url_launcher.dart';


import 'package:sparky/models/model_preset.dart';


class ManageServiceCenterInfo
{
  static Future<String> launchFaqPage() async
  {
    if (await canLaunch(ModelPreset.faqUrl)) {
      await launch(ModelPreset.faqUrl);
    }
    else {
      throw 'Could not launch ${ModelPreset.faqUrl}';
    }

    return ModelPreset.faqUrl;
  }

  static Future<String> launchPrivacyPolicyPage() async
  {
    if (await canLaunch(ModelPreset.privacyPolicyUrl)) {
      await launch(ModelPreset.privacyPolicyUrl);
    }
    else {
      throw 'Could not launch ${ModelPreset.privacyPolicyUrl}';
    }

    return ModelPreset.privacyPolicyUrl;
  }

  static Future<String> launchTermsOfUsePage() async
  {
    if (await canLaunch(ModelPreset.termsOfUseUrl)) {
      await launch(ModelPreset.termsOfUseUrl);
    }
    else {
      throw 'Could not launch ${ModelPreset.termsOfUseUrl}';
    }

    return ModelPreset.termsOfUseUrl;
  }


  static Future<String> launchTermsOfUseTranslateComicPage() async
  {
    if (await canLaunch(ModelPreset.termsOfUseTranslateComicUrl)) {
      await launch(ModelPreset.termsOfUseTranslateComicUrl);
    }
    else {
      throw 'Could not launch ${ModelPreset.termsOfUseTranslateComicUrl}';
    }

    return ModelPreset.termsOfUseTranslateComicUrl;
  }


  static Future<String> launchTermsOfUseRegisterComicPage() async
  {
    if (await canLaunch(ModelPreset.termsOfUseRegisterComicUrl)) {
      await launch(ModelPreset.termsOfUseRegisterComicUrl);
    }
    else {
      throw 'Could not launch ${ModelPreset.termsOfUseRegisterComicUrl}';
    }

    return ModelPreset.termsOfUseRegisterComicUrl;
  }
}