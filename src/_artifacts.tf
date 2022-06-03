data "google_firebase_web_app_config" "main" {
  provider   = google-beta
  web_app_id = local.firebase_app_id
}

locals {
  specs_gcp = {
    project = local.project_id
    service = "Firebase"
  }

  data_authentication = {
    firebase_config = {
      appId           = local.firebase_app_id
      apiKey          = data.google_firebase_web_app_config.main.api_key
      authDomain      = data.google_firebase_web_app_config.main.auth_domain
      databaseUrl     = data.google_firebase_web_app_config.main.database_url
      projectId       = local.project_id
      storageBucket   = data.google_firebase_web_app_config.main.storage_bucket
      messageSenderId = data.google_firebase_web_app_config.main.messaging_sender_id
      measurementId   = data.google_firebase_web_app_config.main.measurement_id
    }
  }

  data_infrastructure = {
    grn = google_app_engine_application.firestore.id
  }

  artifact_authentication = {
    data = {
      authentication = local.data_authentication
      infrastructure = local.data_infrastructure
    }
    specs = {
      gcp = local.specs_gcp
    }
  }
}

resource "massdriver_artifact" "authentication" {
  field                = "authentication"
  provider_resource_id = local.firebase_app_id
  type                 = "gcp-firebase-authentication"
  name                 = "Firebase ${var.md_metadata.name_prefix} (${local.firebase_app_id})"
  artifact             = jsonencode(local.artifact_authentication)
}
