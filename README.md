
# Terraform Module for Google Cloud Build Triggers

This Terraform module creates Google Cloud Build triggers for a specified GitHub repository. It supports push, tag and pull request triggers.

## Variables
- `location`: The location of the Cloud Build triggers.
- `owner`: The owner of the GitHub repository.
- `repository`: The name of the GitHub repository.
- `triggers`: List of trigger configurations. Each configuration is an object with the following attributes:
  - `name`: The name of the Cloud Build trigger.
  - `custom_filename`: The custom name of the pipeline file to use for the trigger (Optional).
  - `tags`: List of tags to apply to the trigger.
  - `sa`: The service account to use for the trigger.
  - `ignored_files`: List of file globs to ignore for the trigger.
  - `included_files`: List of file globs to include for the trigger.
  - `event`: The type of trigger (`push`, `tag` or `pull_request`).
  - `regex`: The pattern to match for triggering builds (branch on `push`, tag on `tag`, base branch on `pull_request`).
  - `invert_regex`: Whether to invert the regex pattern.
  - `send_build_logs`: Whether to send build logs to GitHub.

## Example

```hcl
module "cloud_build_triggers" {
  source = "git::https://github.com/layer-3/terraform-layer-3-cloud-build.git"

  location = "global"
  owner = "layer-3"
  repository = "terraform-layer-3-cloud-build"
  triggers = [
    {
      name = "master-push"
      tags = ["master", "push"]
      sa = "sa-name"
      ignored_files = [".gitignore"]
      event = "push"
      regex = "^master$"
      send_build_logs = true
    }
  ]
}
```

## Author

This module is maintained by [philanton](https://github.com/philanton).

## License

This module is licensed under the MIT License.
