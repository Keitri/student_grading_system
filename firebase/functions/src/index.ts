import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

export const createFacultyUser = functions.firestore.document("faculty/{id}")
    .onCreate((snap) => {
    // Create a Faculty User
      admin.auth().createUser({
        uid: snap.id,
        email: snap.data()["mobileNumber"] + "@keitri.com",
        password: snap.data()["defaultPassword"],
      });
    });

export const createStudentUser = functions.firestore.document("student/{id}")
    .onCreate((snap) => {
      // Create a Student User
      admin.auth().createUser({
        uid: snap.id,
        email: snap.data()["mobileNumber"] + "@keitri.com",
        password: snap.data()["defaultPassword"],
      });
    });
