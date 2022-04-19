# Student Grading Mobile App

Build a Student Grading System with Student Attendance using QR-Code.

## Scenario

XYZ College is currently using the manual system where Instructors and Professors can
write down all of his/her students grades on each of his/her assigned subject in a grade sheet
paper before the end of every semester and pass it to the registrar on or before the given
deadline. They are also required to pass their grading computation to be able to have a basis
on the final grades of their students so that whenever needed it will not be a problem. Because
some of them don't have that grading computation and give an alibi every time the registrar
asks for it. Also, to save time in sending student's grade to their parents.

## Getting Started

Flutter Version: 2.10.5

- Create a Firebase Project and import the google-services.json to android/app/ folder
- Create a .env file with below values

```
    TWILIO_ACCOUNTSID = "your twilio account sid"
    TWILIO_AUTHTOKEN = "your twilio auth token"
    TWILIO_NUMBER = "your twilio number"
    REGISTRAR_ACCOUNT = "Default Phone for Registrar"
    REGISTRAR_INITIAL_PASSWORD = "Initial Password for Registrar"
```

- Run command `flutter run` to test the app.

## Notes

- Firebase is not yet setup for iOS, you can only test this app in Android.
