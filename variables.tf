variable "network_id" {
  description = "Yandex Cloud network ID"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet, to which the host belongs. The subnet must be a part of the network to which the cluster belongs"
  type        = string
}

variable "zone_id" {
  description = "Availability zone for the subnet"
  type        = string
}


variable "security_group_name" {
  description = "Name of the security group"
  type        = string
}

variable "cluster_name" {
  description = "Name of the Greenplum cluster"
  type        = string
}

variable "cluster_description" {
  description = "Description of the Greenplum cluster"
  default     = null
  type        = string
}

variable "environment" {
  description = "Deployment environment of the Greenplum cluster"
  type        = string
  validation {
    condition     = contains(["PRODUCTION", "PRESTABLE"], var.environment)
    error_message = "The environment must be either PRODUCTION or PRESTABLE."
  }
}

variable "assign_public_ip" {
  description = "Assign a public IP to the master hosts"
  type        = bool
}

variable "greenplum_version" {
  description = "Version of the Greenplum cluster"
  type        = string
  validation {
    condition     = contains(["6.22", "6.25"], var.greenplum_version)
    error_message = "The Greenplum version must be either 6.22 or 6.25."
  }
}

variable "master_host_count" {
  description = "Number of hosts in master subcluster"
  type        = number
  validation {
    condition     = var.master_host_count == 1 || var.master_host_count == 2
    error_message = "The number of master hosts must be either 1 or 2."
  }
}

variable "segment_host_count" {
  description = "Number of hosts in segment subcluster"
  type        = number
  validation {
    condition     = var.segment_host_count >= 1 && var.segment_host_count <= 32
    error_message = "The number of segment hosts must be between 1 and 32."
  }
}

variable "segment_in_host" {
  description = "Number of segments on segment host"
  type        = number
}

variable "master_resources_preset" {
  description = "Resource preset for master hosts"
  type        = string
}

variable "master_disk_size" {
  description = "Disk size for master hosts"
  type        = number
}

variable "master_disk_type" {
  description = "Disk type for master hosts"
  type        = string
}

variable "segment_resources_preset" {
  description = "Resource preset for segment hosts"
  type        = string
}

variable "segment_disk_size" {
  description = "Disk size for segment hosts"
  type        = number
}

variable "segment_disk_type" {
  description = "Disk type for segment hosts"
  type        = string
}

variable "access_web_sql" {
  description = "Allow access for SQL queries in the management console"
  type        = bool
}

variable "greenplum_config" {
  description = "Greenplum cluster config"
  type        = map(string)
}

variable "user_name" {
  description = "Greenplum cluster admin user name"
  type        = string
}

variable "user_password" {
  description = "Greenplum cluster admin password"
  type        = string
}
