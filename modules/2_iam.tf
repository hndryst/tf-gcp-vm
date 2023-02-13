resource "google_project_iam_member" "iam" {
  project = var.project
  for_each = toset([
    "roles/logging.logWriter",
    "roles/logging.viewer",
    "roles/monitoring.metricWriter"
  ])
  role   = each.key
  member = "serviceAccount:${google_service_account.sa.email}"
  //member = "serviceAccount:${var.compute_sa}"
}
