resource "google_cloudbuild_trigger" "triggers" {
  count = length(var.triggers)

  location = var.location
  name     = "${var.repository}-${var.triggers[count.index].name}"
  filename = var.triggers[count.index].custom_filename != null ? var.triggers[count.index].custom_filename : "ci/pipelines/${var.triggers[count.index].name}.yaml"
  tags     = var.triggers[count.index].tags

  service_account = "projects/${var.project_id}/serviceAccounts/${var.triggers[count.index].sa}@${var.project_id}.iam.gserviceaccount.com"

  ignored_files  = var.triggers[count.index].ignored_files
  included_files = var.triggers[count.index].included_files

  substitutions = var.triggers[count.index].substitutions
  
  github {
    owner = var.owner
    name  = var.repository

    dynamic "push" {
      for_each = var.triggers[count.index].event == "push" || var.triggers[count.index].event == "tag" ? [1] : []
      content {
        branch = var.triggers[count.index].event == "push" ? var.triggers[count.index].regex : null
        tag    = var.triggers[count.index].event == "tag" ? var.triggers[count.index].regex : null

        invert_regex = var.triggers[count.index].invert_regex
      }
    }

    dynamic "pull_request" {
      for_each = var.triggers[count.index].event == "pull_request" ? [1] : []
      content {
        branch          = var.triggers[count.index].regex
        comment_control = "COMMENTS_DISABLED"

        invert_regex = var.triggers[count.index].invert_regex
      }
    }
  }

  include_build_logs = var.triggers[count.index].send_build_logs ? "INCLUDE_BUILD_LOGS_WITH_STATUS" : "INCLUDE_BUILD_LOGS_UNSPECIFIED"
}
