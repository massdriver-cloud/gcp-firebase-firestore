
module "apis" {
  source = "github.com/massdriver-cloud/terraform-modules//gcp-enable-apis?ref=c336d59"
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
