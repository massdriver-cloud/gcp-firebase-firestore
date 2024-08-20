## Google Cloud Firestore

Google Cloud Firestore is a flexible, scalable database for mobile, web, and server development from Firebase and Google Cloud Platform. Like Firebase Realtime Database, it keeps your data in sync across client apps through real-time listeners and offers offline support for mobile and web, allowing you to build responsive apps that work regardless of network latency or Internet connectivity.

### Design Decisions

1. **App Engine Requirement**: The module makes use of Google App Engine (GAE) for setting up Cloud Firestore in native mode. Cloud Firestore requires an App Engine application to be created in the project. This setup ensures seamless integration with Firebase and other Google Cloud services.
2. **API Enabling**: The module enables essential APIs including `appengine.googleapis.com` and `firebase.googleapis.com` to ensure all necessary services are available for Firebase and Firestore operations.
3. **Multi-Region Support**: Configures Firestore to operate in multi-region locations (e.g., "us-central" for the US, "europe-west" for Europe) to ensure data redundancy and high availability.

### Runbook

#### Enabling Firestore in Native Mode

If Firestore is not set up in native mode, it might be in Datastore mode by default. To ensure it operates in native mode:

```sh
gcloud app create --region=[REGION]
```

Replace `[REGION]` with your desired Google Cloud region (e.g., `us-central`). This command initializes App Engine for your project, required for Firestore native mode.

#### API and Service Issues

If you encounter issues with APIs or services not being enabled during setup:

```sh
gcloud services enable appengine.googleapis.com firebase.googleapis.com
```

This command explicitly enables the required services in your project.

#### Firebase Project Configuration Retrieval

To troubleshoot issues related to fetching Firebase project configurations:

```sh
gcloud beta firebase projects describe [PROJECT_ID]
```

Replace `[PROJECT_ID]` with your Google Cloud project ID. This command outputs all configurations related to the Firebase project.

#### Viewing Firestore Data

To verify data within Firestore:

```sh
gcloud firestore documents list --project=[PROJECT_ID] --collection-id=[COLLECTION_ID]
```

Replace `[PROJECT_ID]` with your project ID and `[COLLECTION_ID]` with the collection you want to query.

#### Firestore Query Issues

If you are experiencing issues related to Firestore queries:

```python
import firebase_admin
from firebase_admin import credentials, firestore

# Use the application default credentials
cred = credentials.ApplicationDefault()
firebase_admin.initialize_app(cred)

db = firestore.client()
query = db.collection('your-collection').get()

for doc in query:
    print(doc.id, doc.to_dict()) 
```

This Python snippet uses Firebase Admin SDK to query a collection in Firestore. Ensure your collection name is correct and that the SDK is properly initialized.

#### Region-Specific Settings

To ensure your Firestore is set up in the correct location, validate your configuration with:

```sh
gcloud app describe --project=[PROJECT_ID]
```

This command details your App Engine setup, including the region, which directly affects Firestore's regional settings.

Remember to replace `[PROJECT_ID]` with your actual Google Cloud project ID for each command.

