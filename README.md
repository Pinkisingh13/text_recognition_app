# Text Recognition App

This Flutter application is designed to recognize handwritten text using Firebase ML Kit. The app allows users to draw or write text on a canvas and predicts the drawn text with high accuracy.

## Features

1. Interactive Canvas Board for drawing texts

2. Real-time prediction using Firebase ML Kit

3. Clear button to reset the canvas

4. Animated loading bar during prediction process

5. Smooth UI with intuitive design

## Tech Stack

1. Flutter for UI and application logic

2. Firebase ML Kit for text recognition

3. Provider for state management

## Installation

1. Clone the repository:

```git clone https://github.com/yourusername/digit_recognition_app.git```

2. Navigate to the project directory:

```cd digit_recognition_app```

3. Install dependencies:

```flutter pub get```

4. Set up Firebase:

  - Go to Firebase Console

  - Create a new project and download the google-services.json file for Android (or GoogleService-Info.plist for iOS)

  - Add the downloaded file to your Flutter project in the appropriate folder:

        For Android: /android/app/

        For iOS: /ios/Runner/

5. Run the app:

       flutter run

## Usage

1. Draw a text pr digit on the canvas.

2. Click on the Predict button to recognize the text.

3. Click on the Clear button to erase the canvas and start over.

## Code Explanation

### CanvasView:
1. The CanvasView widget manages the UI structure for the drawing screen.
   It includes:
   
     - CanvasBoard: Custom canvas for drawing digits.
     - ButtonWidget: Controls for Clear and Predict actions.

### ButtonWidget:

  - Provides user interactions for:
    
      i) Clearing the canvas.

      ii) Triggering the text recognition process.

### CanvasBoard

  - Utilizes CustomPaint for interactive drawing features.

  - Detects user touch gestures to capture drawing points and send them for recognition.

### Loading Animation

   - A progress bar animation is displayed while the app predicts the digit, enhancing the user experience.

## Screenshots
<h3 align="center">Empty Canvas & Text on Canvas</h3>

<div align = "center">
  <img src="https://github.com/Pinkisingh13/Pinkisingh13/blob/main/emptycanvas.jpg" width="45%" style="margin-right: 10px;">
  <img src="https://github.com/Pinkisingh13/Pinkisingh13/blob/main/textoncanvas.jpg" width="45%" style="margin-right: 10px;">
</div>

<h3 align="center">Loading Bar & Prediction Successful</h3>

<div align = "center">
  <img src="https://github.com/Pinkisingh13/Pinkisingh13/blob/main/loadingtext.jpg" width="45%" style="margin-right: 10px;">
  <img src="https://github.com/Pinkisingh13/Pinkisingh13/blob/main/predictionsuccessful.jpg" width="45%" style="margin-right: 10px;">
</div>



## Contributing

Contributions are welcome! Feel free to submit issues or pull requests for improvements.

## Contact

For any queries or collaboration, reach out to me on ### [Linkedin](https://www.linkedin.com/in/pinkisingh23/)

