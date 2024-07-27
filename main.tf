resource "yandex_vpc_security_group" "greenplum_sg" {
  name       = var.security_group_name
  network_id = var.network_id

  ingress {
    protocol       = "ANY"
    description    = "Allow incoming traffic from members of the same security group"
    from_port      = 0
    to_port        = 65535
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol       = "ANY"
    description    = "Allow outgoing traffic to members of the same security group"
    from_port      = 0
    to_port        = 65535
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_mdb_greenplum_cluster" "greenplum_cluster" {
  name        = var.cluster_name
  description = var.cluster_description
  environment = var.environment
  network_id  = var.network_id
  zone        = var.zone_id
  subnet_id   = var.subnet_id
  assign_public_ip = var.assign_public_ip
  version     = var.greenplum_version

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

  greenplum_config = var.greenplum_config

  user_name     = var.user_name
  user_password = var.user_password

  security_group_ids = [yandex_vpc_security_group.greenplum_sg.id]
}
