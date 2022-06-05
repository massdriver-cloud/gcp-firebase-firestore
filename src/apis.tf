
module "apis" {
  source = "github.com/massdriver-cloud/terraform-modules/google-enable-apis?ref=9201b9f"
  services = [
    # both of these need to be on.... to turn on GCP apis
    # TODO: all a null_resource gcloud command to do it in the module
    # "serviceusage.googleapis.com",
    # "cloudresourcemanager.googleapis.com",
    "appengine.googleapis.com",
    "firebase.googleapis.com"
  ]
  # 90 seconds failed multiple times
  # specifically the app engine api takes a while to be ready
  seconds_to_sleep = 200
}
