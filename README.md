# Github Actions with release for flutter MacOS, Linux, Windows & Android.

# FAQ:

### Why didn't you use flutter action from github marketplace ?
Desktop builds are only available for master channel(basically github master branch) & flutter action use SDK release page to download flutter SDK & Only stable, beta & dev channel builds are available in SDK release page.

### Why iOS build isn't implemented ?
I don't have a iPhone & iOS simulators doesn't run real apps so there's no way I can test it but feel free to send a pull request (with little doc).

### Why there's debug label on Linux and Windows app ?
Flutter doesn't support linux & windows out of the box & at this moment (Feb 2020) only debug builds are supported.

### Why my builds are failing but working fine on my local machine ?
Make sure your local machine and githhub actions are using same commit on flutter master branch.

### How can I use same commit on flutter master branch ?
Run `flutter doctor` on your local machine and copy the code after revision ```Framework • revision 67826bdce5 (4 days ago) • 2020-02-10 14:59:32 -0800```. In your **main.yml** add this code in same line as git clone command ```cd flutter && git checkout 67826bdce5```. PS: Make sure you replace code .
