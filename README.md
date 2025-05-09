# YashGym

YashGym is a **Flutter-based Gym Management app** that allows users to sign up, log in, and manage gym member data using **Back4App** as the backend.

---

## 🚀 **Getting Started**

This section will help you **clone the repository**, **set up the project**, and **configure the backend** (Back4App) to run the app.

### 🔹 **Prerequisites**

Before you begin, make sure you have the following installed:

- **Flutter**: Make sure you have Flutter SDK installed on your machine. Follow the official [Flutter installation guide](https://flutter.dev/docs/get-started/install) for your operating system.
- **Android Studio** or **VS Code**: A code editor for Flutter development.
- **Back4App Account**: Create an account on [Back4App](https://www.back4app.com/).

### 🔹 **Clone the Repository**

First, clone this repository to your local machine using the following command:

```bash
git clone https://github.com/nossamyaswanth/GymTrackerApp.git
```

Navigate to the project directory:

```bash
cd GymTrackerApp
```

### 🔹 **Install Dependencies**

Run the following command to install the required Flutter dependencies:

```bash
flutter pub get
```

### 🔹 **Set Up Back4App Backend**

1. **Create a Back4App account**:  
   If you don’t have an account, sign up for free at [Back4App](https://www.back4app.com/).

2. **Create a New App on Back4App**:
   - Go to your [Back4App Dashboard](https://dashboard.back4app.com/).
   - Click **Create New App** and follow the instructions.
   - After creating the app, you'll be given your **Application ID** and **Client Key**. Copy these as you'll need them in the Flutter app.

3. **Set Up the Database**:
   - In Back4App, go to **Database > Browser**.
   - Create a new class called **`Member`** with two fields:
     - `Name` (Type: String)
     - `Age` (Type: Number)
   - This is where the app will store gym member data.

4. **Update the Flutter App with Your Back4App Credentials**:
   - Open the `lib/main.dart` file in your code editor.
   - Update the following fields with your **Application ID** and **Client Key** from Back4App:

   ```dart
   const keyApplicationId = 'YOUR_APP_ID';  // Replace with your actual App ID
   const keyClientKey = 'YOUR_CLIENT_KEY';  // Replace with your actual Client Key
   const keyParseServerUrl = 'https://parseapi.back4app.com';
   ```

   ### 🔹 **Running the App**

1. **For Android/iOS**:
   - Open your terminal/command prompt in the project directory.
   - Run the following command to start the app on your emulator or connected device:

   ```bash
   flutter run
   ```
2. **Test the Application**:
   - You should be able to see the Login Screen.
   - Sign Up with a new user, then Log In to view the member dashboard.
   - You can add, update, and delete gym members.

---

## 🧑‍💻 **Project Structure**

Here’s a quick overview of the project structure:

- `lib/`: Main source code for the Flutter app
  - `main.dart`: The entry point of the app
  - `login_page.dart`: Login screen UI
  - `signup_page.dart`: Signup screen UI
  - `home_page.dart`: Dashboard for gym members (Add, View, Update, Delete members)
  
- `assets/`: Contains app icons, images, and other static files
- `.gitignore`: Specifies files and folders that should not be tracked by Git

---

## 💡 **App Features**

- **User Authentication**: Allows users to sign up, log in, and manage their session.
- **CRUD Operations**: Perform Create, Read, Update, and Delete operations on gym member data.
- **Backend**: Uses Back4App for storing user and gym member data.

---

### Final Tips:
- If you face issues connecting with Back4App, double-check that your **Application ID** and **Client Key** are correct.
- Ensure you have internet access for your app to interact with the Back4App database.

