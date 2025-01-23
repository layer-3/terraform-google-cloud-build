variable "project_id" {
  description = "The project to deploy to"
  type        = string
  nullable    = false
}

variable "location" {
  description = "The location to deploy to"
  type        = string
  default     = "global"
}

variable "owner" {
  description = "The owner of the repository"
  type        = string
  nullable    = false
}

variable "repository" {
  description = "The name of the repository"
  type        = string
  nullable    = false
}

variable "triggers" {
  description = <<EOT
The triggers to create. Each trigger should be defined with the following attributes:

- `name` (string): The name of the trigger.
- `custom_filename` (string): The custom filename to use for the trigger.
- `tags` (list(string)): Tags to associate with the trigger.
- `sa` (string): Service account to use for the trigger.
- `ignored_files` (list(string)): List of files to ignore.
- `included_files` (list(string)): List of files to include.
- `substitutions` (map(string)): Substitutions to use for the trigger.
- `event` (string): The event type that triggers the build (e.g., 'push', 'pull_request').
- `regex` (string): A regex pattern to filter the branches or tags.
- `invert_regex` (bool): If true, the regex pattern is inverted.
- `send_build_logs` (bool): If true, send build logs to a specific destination.
EOT
  type = list(object({
    name            = string
    custom_filename = optional(string)
    tags            = list(string)
    sa              = string
    ignored_files   = list(string)
    included_files  = list(string)
    substitutions   = optional(map(string))
    event           = string
    regex           = string
    invert_regex    = bool
    send_build_logs = bool
  }))
  default = []
}
