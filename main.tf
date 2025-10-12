resource "yandex_mdb_greenplum_cluster" "greenplum_cluster" {
  name        = var.cluster_name
  description = var.cluster_description
  environment = var.environment
  network_id  = var.network_id
  zone        = var.zone_id
  subnet_id   = var.subnet_id
  version     = var.greenplum_version
  labels      = var.labels

  assign_public_ip   = var.assign_public_ip
  master_host_count  = var.master_host_count
  segment_host_count = var.segment_host_count
  segment_in_host    = var.segment_in_host

  master_subcluster {
    resources {
      resource_preset_id = var.master_resources_preset
      disk_size          = var.master_disk_size
      disk_type_id       = var.master_disk_type
    }
  }

  segment_subcluster {
    resources {
      resource_preset_id = var.segment_resources_preset
      disk_size          = var.segment_disk_size
      disk_type_id       = var.segment_disk_type
    }
  }

  access {
    web_sql = var.access_web_sql
  }

  user_name     = var.user_name
  user_password = var.user_password

  greenplum_config   = var.greenplum_config
  security_group_ids = var.security_group_ids

  deletion_protection = var.deletion_protection

  dynamic "maintenance_window" {
    for_each = var.maintenance_window != null ? [var.maintenance_window] : []
    content {
      type = maintenance_window.value.type
      day  = try(maintenance_window.value.day, null)
      hour = try(maintenance_window.value.hour, null)
    }
  }

  dynamic "backup_window_start" {
    for_each = var.backup_window_start == null ? [] : [var.backup_window_start]
    content {
      hours   = backup_window_start.value.hours
      minutes = backup_window_start.value.minutes
    }
  }

  dynamic "pooler_config" {
    for_each = var.pooler_config == null ? [] : [var.pooler_config]
    content {
      pooling_mode             = pooler_config.value.pooling_mode
      pool_size                = pooler_config.value.pool_size
      pool_client_idle_timeout = pooler_config.value.pool_client_idle_timeout
    }
  }
}
