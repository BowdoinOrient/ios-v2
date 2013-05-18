README: OrientApp

Authors: Brian Jacobel and Quinn Cohane
Version: 2.0
Date Created: February 26, 2013
Last Updated: May 18, 2013
Institution: Bowdoin College
Class: Mobile Computing
Assignment: Final Project

Description: 
This app allows users to access The Bowdoin Orient, Bowdoin's student-run newspaper, and read the latest articles. The user can share articles on Twitter and Facebook, and search the Orient archives. It runs on both iPhone and iPad. 

Features:
The app first brings the user to the Orient homepage, which displays a slideshow of recommended articles as well as articles from all of the different sections. The slideshow is touch-interactive. The user can scroll down the homepage to access a certain section. To access a section from any article or landing page, the user can also horizontally swipe the label in the top right corner that initially says "Home" to reach the desired section. To load this section, the user must press the reload icon to the right. A new webpage will load that jumps the user to the desired section on the Orient website. An activity indicator will appear in the middle of the screen during the load process to let the user know that the webpage has been requested. 
If the user ever wants to return to the homepage, pressing the Bowdoin Orient logo in the top left corner will do the trick. The section scroll list will automatically jump back to display Home. 
To access a search button or post an article on Facebook or Twitter, the user can double tap on the screen. This will bring up a bottom menu that displays the necessary buttons. As long as the user has saved their account information in Settings, they can post the article directly to their social media account. To access search functionality, pressing the magnifying glass icon will take the user to the Orient's search page, with the additional option of then navigating to advanced search.
The user is still able to access website features, such as commenting, when using the app. Comments are unified with the desktop/browser version of the website and viewable to both app and non-app users.
Both the iPhone and iPad versions work in any orientation. 
Pinch to zoom is supported.
This app gives the user access to all content and features on one screen, so all of the main features are present in the OrientViewController classes. The OrientSplashController sets up the splash that appears when the user first opens the app before being taken to the homepage. 

Known Bugs/Issues:
- Some of the supposedly "retina" images are a little fuzzy.
- The Orient website's header bar (which is intended to be hidden on all pages and replaced with this app's top navigation bar) is not hidden on the Search results page because of the way search strings are passed. Two Orient logos are displayed.
- Double tapping only brings up a menu bar on the iPhone, but both brings up the menu bar *and* slightly zooms the screen on the iPad.
- The menubar appear animation is often not triggered on the app's first open: it simply appears rather than transitioning in.
