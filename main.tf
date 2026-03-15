resource "yandex_mdb_greenplum_cluster" "greenplum_cluster" {
  name        = var.cluster_name
  description = var.cluster_description
  environment = var.environment
  network_id  = var.network_id
  zone        = var.zone_id
  subnet_id   = var.subnet_id
  version     = var.greenplum_version
  labels      = var.labels

  assign_public_ip       = var.assign_public_ip
  master_host_count      = var.master_host_count
  segment_host_count     = var.segment_host_count
  segment_in_host        = var.segment_in_host
  master_host_group_ids  = var.master_host_group_ids
  segment_host_group_ids = var.segment_host_group_ids
  service_account_id     = var.service_account_id

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
    web_sql       = var.access_web_sql
    data_lens     = var.access_data_lens
    data_transfer = var.access_data_transfer
    yandex_query  = var.access_yandex_query
  }

  user_name     = var.user_name
  user_password = var.user_password

  greenplum_config   = var.greenplum_config
  security_group_ids = toset(var.security_group_ids)

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
      pooling_mode                     = pooler_config.value.pooling_mode
      pool_size                        = pooler_config.value.pool_size
      pool_client_idle_timeout         = pooler_config.value.pool_client_idle_timeout
      pool_idle_in_transaction_timeout = try(pooler_config.value.pool_idle_in_transaction_timeout, null)
    }
  }

  dynamic "cloud_storage" {
    for_each = var.cloud_storage != null ? [var.cloud_storage] : []
    content {
      enable = cloud_storage.value.enable
    }
  }

  dynamic "logging" {
    for_each = var.logging != null ? [var.logging] : []
    content {
      enabled                = try(logging.value.enabled, null)
      log_group_id           = try(logging.value.log_group_id, null)
      folder_id              = try(logging.value.folder_id, null)
      greenplum_enabled      = try(logging.value.greenplum_enabled, null)
      pooler_enabled         = try(logging.value.pooler_enabled, null)
      command_center_enabled = try(logging.value.command_center_enabled, null)
    }
  }

  dynamic "background_activities" {
    for_each = var.background_activities != null ? [var.background_activities] : []
    content {
      dynamic "analyze_and_vacuum" {
        for_each = try(background_activities.value.analyze_and_vacuum, null) != null ? [background_activities.value.analyze_and_vacuum] : []
        content {
          vacuum_timeout  = try(analyze_and_vacuum.value.vacuum_timeout, null)
          analyze_timeout = try(analyze_and_vacuum.value.analyze_timeout, null)
          start_time      = try(analyze_and_vacuum.value.start_time, null)
        }
      }
      dynamic "query_killer_long_running" {
        for_each = try(background_activities.value.query_killer_long_running, null) != null ? [background_activities.value.query_killer_long_running] : []
        content {
          enable       = try(query_killer_long_running.value.enable, null)
          max_age      = try(query_killer_long_running.value.max_age, null)
          ignore_users = try(query_killer_long_running.value.ignore_users, null)
        }
      }
      dynamic "query_killer_idle_in_transaction" {
        for_each = try(background_activities.value.query_killer_idle_in_transaction, null) != null ? [background_activities.value.query_killer_idle_in_transaction] : []
        content {
          enable       = try(query_killer_idle_in_transaction.value.enable, null)
          max_age      = try(query_killer_idle_in_transaction.value.max_age, null)
          ignore_users = try(query_killer_idle_in_transaction.value.ignore_users, null)
        }
      }
      dynamic "query_killer_idle" {
        for_each = try(background_activities.value.query_killer_idle, null) != null ? [background_activities.value.query_killer_idle] : []
        content {
          enable       = try(query_killer_idle.value.enable, null)
          max_age      = try(query_killer_idle.value.max_age, null)
          ignore_users = try(query_killer_idle.value.ignore_users, null)
        }
      }
    }
  }

  dynamic "pxf_config" {
    for_each = var.pxf_config != null ? [var.pxf_config] : []
    content {
      connection_timeout             = try(pxf_config.value.connection_timeout, null)
      max_threads                    = try(pxf_config.value.max_threads, null)
      pool_allow_core_thread_timeout = try(pxf_config.value.pool_allow_core_thread_timeout, null)
      pool_core_size                 = try(pxf_config.value.pool_core_size, null)
      pool_max_size                  = try(pxf_config.value.pool_max_size, null)
      pool_queue_capacity            = try(pxf_config.value.pool_queue_capacity, null)
      upload_timeout                 = try(pxf_config.value.upload_timeout, null)
      xms                            = try(pxf_config.value.xms, null)
      xmx                            = try(pxf_config.value.xmx, null)
    }
  }

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []
    content {
      create = try(timeouts.value.create, null)
      update = try(timeouts.value.update, null)
      delete = try(timeouts.value.delete, null)
    }
  }
}

resource "yandex_mdb_greenplum_resource_group" "resource_group" {
  for_each = { for rg in var.resource_groups : rg.name => rg }

  cluster_id = yandex_mdb_greenplum_cluster.greenplum_cluster.id
  name       = each.value.name

  concurrency         = try(each.value.concurrency, null)
  cpu_rate_limit      = try(each.value.cpu_rate_limit, null)
  memory_limit        = try(each.value.memory_limit, null)
  memory_shared_quota = try(each.value.memory_shared_quota, null)
  memory_spill_ratio  = try(each.value.memory_spill_ratio, null)
}

resource "yandex_mdb_greenplum_user" "user" {
  for_each = { for u in var.users : u.name => u }

  cluster_id     = yandex_mdb_greenplum_cluster.greenplum_cluster.id
  name           = each.value.name
  password       = each.value.password
  resource_group = try(each.value.resource_group, null)
}
