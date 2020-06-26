const functions = require('firebase-functions');
const admin = require('firebase-admin');


admin.initializeApp(functions.config().firebase);
const db = admin.firestore();

exports.createBraineryUser = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError('failed-precondition', 'The function must be called ' +
      'while authenticated.');
  }
  console.log(data);
  const uid = context.auth.uid;
  return db.collection('users').doc(uid).set(data).then(doc => {
    return doc;
  }).catch(err => {
    console.log('Error getting document', err);
    throw new functions.https.HttpsError('failed-precondition', 'Invalid User id');
  });
});

exports.getBraineryUser = functions.https.onCall((data, context) => {
  const uid = context.auth.uid;
  const docRef = db.collection('users').doc(uid);
  return docRef.get().then(doc => {
    if (!doc.exists) {
      throw new functions.https.HttpsError('failed-precondition', 'Invalid User id');
    }
    console.log(doc.data());
    return doc.data();
  }).catch(err => {
    console.log('Error getting document', err);
    throw new functions.https.HttpsError('failed-precondition', 'Invalid User id');
  });

});

exports.getLessons = functions.https.onCall((data, context) => {
  const collectionRef = db.collection('lessons').orderBy('title');
  const lessons = [];
  return collectionRef.get().then(snapshot => {
    snapshot.forEach(doc => {
      lessons.push(doc.data());
    });
    return lessons;
  }).catch(err => {
    console.log('Error getting document', err);
    throw new functions.https.HttpsError('failed-precondition', 'Invalid User id');
  });

});

exports.getCourseList = functions.https.onCall((data, context) => {
  const collectionRef = db.collection('course_list').orderBy('courseName');
  const lessons = [];
  return collectionRef.get().then(snapshot => {
    snapshot.forEach(doc => {
      lessons.push(doc.data());
    });
    return lessons;
  }).catch(err => {
    console.log('Error getting document', err);
    throw new functions.https.HttpsError('failed-precondition', 'Invalid User id');
  });

});

exports.postHelpMessage = functions.https.onCall((data, context) => {
  const collectionRef = db.collection('help_message');
  return collectionRef.add(data).then(documentRef => {
    return { "documentId": documentRef.id }
  }).catch(err => {
    console.log('Error getting document', err);
    throw new functions.https.HttpsError('Internal-error', 'Unable to add the Help message.');
  });
});