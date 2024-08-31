
# mvvmbasic

A Base For Flutter project With GetX and Provider.

Clone the project / download and create another repository and push there don't push on base project
You have change app name and package as u need,
pre set with firebase you may remove / replace the firebase json.

Easy Api call and error handling, Need on screen error/refresh use globalWidgetBuilder which can process error and widget it's self.
use localprovider for navigation , can get localprovider any screen by Get.find() there we have navigation functions, all navigations must should done by getx only to manage state.
All static strings must be save in  lib/utils/i18n/en_US.json. its default languge use string from i18n.
Must use const keyword if widget/value is const.
here you have a model api call on authprovider and authrepo , like screen->provider->repository->apihelper this is flow for call api 
 


