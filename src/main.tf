locals {
  # "projects/<PROJECT_ID>/webApps/<FIREBASE_APP_ID>"
  web_app_full_id = split("/", google_firebase_web_app.main.id)
  firebase_app_id = local.web_app_full_id[3]
}

# If we make the Firebase _project_ first, the default is DataStore mode
# not native Firestore mode, which is what we want
resource "google_app_engine_application" "firestore" {
  # project and location_id required by the resource
  project       = local.project_id
  location_id   = local.gcp_location
  database_type = "CLOUD_FIRESTORE"

  depends_on = [
    module.apis
  ]
}

# This resource is in beta, and should be used with the
# terraform-provider-google-beta provider. See Provider Versions
# for more details on beta resources.
# Once Firebase has been added to a Google Project it cannot be removed.
resource "google_firebase_project" "main" {
  provider = google-beta
  project  = local.project_id

  depends_on = [
    google_app_engine_application.firestore
  ]
}

# Locations and regions are a little weird for Firebase
# read more here: https://firebase.google.com/docs/projects/locations?authuser=0&hl=en
resource "google_firebase_project_location" "main" {
  provider    = google-beta
  location_id = local.gcp_location
  project     = local.project_id

  depends_on = [
    google_firebase_project.main,
  ]
}

# to get any of the Firebase config values, we need to create
# a web_app, then we can make the firebase config file
resource "google_firebase_web_app" "main" {
  provider     = google-beta
  project      = local.project_id
  display_name = var.md_metadata.name_prefix

  depends_on = [
    google_firebase_project.main
  ]
}
