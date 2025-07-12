🌟 InspireMe – A Daily Motivation App
A modern motivational app with sound, animation, theming, and offline support — built using Flutter 3.29.3.

✅ Features

🏠 Home Screen
Displays a motivational quote in the center.
“Inspire Me” button to fetch a new quote from a local list.
Smooth fade & slide animations on quote change.
Plays a soothing chime when a new quote is shown.

💬 Quote Source
Uses a local list of 20+ predefined quotes from quotes_data.dart.

🌓 Theme Switching
Toggle between Light Mode and Dark Mode.
Dynamic color changes: gradient background, text, and icons.
Smooth animation during theme transition.
🎵 Sound plays on theme toggle.

❤️ Favorites
Mark/unmark any quote as favorite using a heart icon.
View all favorites in a dedicated Favorites Screen.
Data saved locally using SharedPreferences.
🎵 Sound plays on both like and unlike actions.
✨ Scale animation for like button (similar to Instagram).
🔊 Sound Feedback

Implemented using the audioplayers package:
On tapping Inspire Me button
On like/unlike actions
On switching themes
On navigating to the Favorites screen
On interacting with the Favorites screen

📤 Quote Sharing
Share your favorite quotes using the share_plus package.
Available from both Home and Favorites screens.

🎬 Animations
Fade and slide transitions using flutter_animate.
Scale bounce effect on the favorite button.
Smooth animations when switching quotes or navigating.

🖼 Splash Screen & Logo
A visually appealing splash screen added on app launch.
Custom app logo used in launcher and splash screen.

📁 Project Structure
Organized using a clean MVC folder structure with reusable components:

main.dart  
app_theme.dart  
approutes.dart  
quotes_data.dart  
colors.dart  
dimensions.dart  
apptext.dart  
appimages.dart  
splash_screen.dart  
gradient_data.dart  
home_screen.dart  
favorites_screen.dart  
theme_switch.dart  
quote_provider.dart  
quote.dart  

🛠 Built With
Flutter 3.29.3
provider – State management
shared_preferences – Local data persistence
audioplayers – Sound effects
flutter_animate – UI animations
share_plus – Quote sharing

🧠 Bonus Features Implemented
✅ Hero animation when navigating to the favorites screen
✅ Sound feedback on all major actions
✅ Theme toggle with animation and sound
✅ MVC architecture for better maintainability
✅ Quote sharing via share_plus
✅ Splash screen with logo
✅ Music/sound when:

Quote is liked/unliked
Theme is changed
New quote appears
Favorites screen is opened