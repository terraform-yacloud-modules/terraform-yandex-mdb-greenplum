variable "network_id" {
  description = "The ID of the VPC network where the Greenplum cluster will be deployed. All cluster hosts will be placed within this network."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet where the Greenplum cluster hosts will be deployed. The subnet must be part of the specified network."
  type        = string
}

variable "zone_id" {
  description = "Availability zone for the subnet"
  type        = string
}

variable "security_group_ids" {
  description = "A list of security group IDs to assign to the Greenplum cluster hosts. Controls network access to the cluster nodes."
  type        = list(string)
  default     = []
}

variable "master_host_group_ids" {
  description = "A list of IDs of the host groups to place master subclusters' VMs of the cluster on."
  type        = set(string)
  default     = []
}

variable "segment_host_group_ids" {
  description = "A list of IDs of the host groups to place segment subclusters' VMs of the cluster on."
  type        = set(string)
  default     = []
}

variable "service_account_id" {
  description = "ID of service account to use with Yandex Cloud resources (e.g. S3, Cloud Logging)."
  type        = string
  default     = null
}

variable "cluster_name" {
  description = "Name of the Greenplum cluster"
  type        = string
}

variable "cluster_description" {
  description = "An optional description of the Greenplum cluster. Helps document the purpose and usage of the cluster."
  default     = null
  type        = string
}

variable "environment" {
  description = "The deployment environment of the Greenplum cluster. PRODUCTION for production workloads with higher availability, PRESTABLE for testing and development."
  type        = string
  validation {
    condition     = contains(["PRODUCTION", "PRESTABLE"], var.environment)
    error_message = "The environment must be either PRODUCTION or PRESTABLE."
  }
}

variable "assign_public_ip" {
  description = "Whether to assign public IP addresses to the master hosts. Enables external access to the cluster."
  type        = bool
}

variable "greenplum_version" {
  description = "The version of Greenplum to deploy. Supported: 6.28 (6.25 is no longer supported by the API)."
  type        = string
  default     = "6.28"
  validation {
    condition     = contains(["6.28"], var.greenplum_version)
    error_message = "The Greenplum version must be 6.28."
  }
}

variable "master_host_count" {
  description = "The number of hosts in the master subcluster. Must be 1 (single master) or 2 (master with standby) for high availability."
  type        = number
  validation {
    condition     = var.master_host_count == 1 || var.master_host_count == 2
    error_message = "The number of master hosts must be either 1 or 2."
  }
}

variable "segment_host_count" {
  description = "The number of hosts in the segment subcluster. These hosts store the actual data and handle query processing."
  type        = number
  validation {
    condition     = var.segment_host_count >= 1 && var.segment_host_count <= 32
    error_message = "The number of segment hosts must be between 1 and 32."
  }
}

variable "segment_in_host" {
  description = "The number of Greenplum segments to run on each segment host. Affects parallelism and resource utilization."
  type        = number
  validation {
    condition     = var.segment_in_host >= 1
    error_message = "The number of segments per host must be at least 1."
  }
}

variable "master_resources_preset" {
  description = "The resource preset (CPU and memory configuration) for the master hosts. Determines the computational power of the master nodes."
  type        = string
}

variable "master_disk_size" {
  description = "The disk size in GB for the master hosts. Stores metadata, logs, and temporary data."
  type        = number
  validation {
    condition     = var.master_disk_size >= 20
    error_message = "The master disk size must be at least 20 GB."
  }
}

variable "master_disk_type" {
  description = "The disk type for the master hosts. Options include network-ssd, network-hdd, local-ssd, etc."
  type        = string
}

variable "segment_resources_preset" {
  description = "The resource preset (CPU and memory configuration) for the segment hosts. Determines the computational power of the data processing nodes."
  type        = string
}

variable "segment_disk_size" {
  description = "The disk size in GB for the segment hosts. Stores the actual data and affects query performance."
  type        = number
  validation {
    condition     = var.segment_disk_size >= 20
    error_message = "The segment disk size must be at least 20 GB."
  }
}

variable "segment_disk_type" {
  description = "The disk type for the segment hosts. Options include network-ssd, network-hdd, local-ssd, etc."
  type        = string
}

variable "access_web_sql" {
  description = "Whether to enable web-based SQL query interface in the Yandex Cloud management console."
  type        = bool
}

variable "access_data_lens" {
  description = "Allow access for DataLens."
  type        = bool
  default     = false
}

variable "access_data_transfer" {
  description = "Allow access for DataTransfer."
  type        = bool
  default     = false
}

variable "access_yandex_query" {
  description = "Allow access for Yandex Query."
  type        = bool
  default     = false
}

variable "greenplum_config" {
  description = "A map of Greenplum configuration parameters. Allows fine-tuning of cluster behavior and performance."
  type        = map(string)
  validation {
    condition = alltrue([
      for k, v in var.greenplum_config :
      can(regex("^-?\\d+$", v)) ||
      contains(["true", "false"], v) ||
      (can(regex("^\\d+$", v)) && contains(["0", "1", "2", "3"], v))
    ])
    error_message = "Greenplum config values must be valid numbers or boolean strings (true/false)."
  }
}

variable "user_name" {
  description = "The username for the Greenplum cluster administrator account. Used for database access and management."
  type        = string
  validation {
    condition     = length(var.user_name) >= 1 && length(var.user_name) <= 63
    error_message = "The username must be between 1 and 63 characters long."
  }
}

variable "user_password" {
  description = "The password for the Greenplum cluster administrator account. Should be strong and stored securely."
  type        = string
  validation {
    condition     = length(var.user_password) >= 8
    error_message = "The password must be at least 8 characters long."
  }
}

variable "deletion_protection" {
  description = "Protects the cluster from accidental deletion. When enabled, the cluster cannot be deleted through the API or console."
  type        = bool
  default     = false
}

variable "labels" {
  description = "A set of key/value label pairs to assign to the Greenplum cluster. Useful for organization, billing, and automation."
  type        = map(string)
  default     = {}
}

variable "maintenance_window" {
  description = "Maintenance window settings"
  type = object({
    type = optional(string)
    day  = optional(string)
    hour = optional(number)
  })
  default = null
  validation {
    condition = var.maintenance_window == null || (
      var.maintenance_window.type == "ANYTIME" ||
      (var.maintenance_window.type == "WEEKLY" && var.maintenance_window.day != null && var.maintenance_window.hour != null)
    )
    error_message = "For WEEKLY maintenance window, both day and hour must be specified. For ANYTIME, only type should be specified."
  }
}


variable "backup_window_start" {
  description = "Time to start the daily backup, in UTC. Specify hours and minutes."
  type = object({
    hours   = number
    minutes = number
  })
  default = null
}

variable "pooler_config" {
  description = "Connection pooler configuration based on Odyssey. Defines pooling mode, pool size, and client idle timeout."
  type = object({
    pooling_mode                     = string
    pool_size                        = number
    pool_client_idle_timeout         = number
    pool_idle_in_transaction_timeout = optional(number)
  })
  default = null
}

variable "cloud_storage" {
  description = "Enable Cloud Storage for the cluster."
  type = object({
    enable = bool
  })
  default = null
}

variable "logging" {
  description = "Logging configuration for the cluster."
  type = object({
    enabled                = optional(bool)
    log_group_id           = optional(string)
    folder_id              = optional(string)
    greenplum_enabled      = optional(bool)
    pooler_enabled         = optional(bool)
    command_center_enabled = optional(bool)
  })
  default = null
}

variable "background_activities" {
  description = "Background activities configuration: analyze_and_vacuum, query killer scripts."
  type = object({
    analyze_and_vacuum = optional(object({
      vacuum_timeout  = optional(number)
      analyze_timeout = optional(number)
      start_time      = optional(string) # HH:MM
    }))
    query_killer_long_running = optional(object({
      enable       = optional(bool)
      max_age      = optional(number)
      ignore_users = optional(list(string))
    }))
    query_killer_idle_in_transaction = optional(object({
      enable       = optional(bool)
      max_age      = optional(number)
      ignore_users = optional(list(string))
    }))
    query_killer_idle = optional(object({
      enable       = optional(bool)
      max_age      = optional(number)
      ignore_users = optional(list(string))
    }))
  })
  default = null
}

variable "pxf_config" {
  description = "PXF (Protocol eXtensible Framework) configuration."
  type = object({
    connection_timeout             = optional(number)
    max_threads                    = optional(number)
    pool_allow_core_thread_timeout = optional(bool)
    pool_core_size                 = optional(number)
    pool_max_size                  = optional(number)
    pool_queue_capacity            = optional(number)
    upload_timeout                 = optional(number)
    xms                            = optional(number)
    xmx                            = optional(number)
  })
  default = null
}

variable "timeouts" {
  description = "Timeout settings for cluster operations (create, update, delete)."
  type = object({
    create = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default = null
}

variable "resource_groups" {
  description = "List of Greenplum resource groups to create in the cluster. Optional; cluster has default groups."
  type = list(object({
    name                = string
    concurrency         = optional(number)
    cpu_rate_limit      = optional(number)
    memory_limit        = optional(number)
    memory_shared_quota = optional(number)
    memory_spill_ratio  = optional(number)
  }))
  default = []
}

variable "users" {
  description = "Additional Greenplum users to create (besides the cluster admin from user_name/user_password)."
  type = list(object({
    name           = string
    password       = string
    resource_group = optional(string)
  }))
  default = []
}
