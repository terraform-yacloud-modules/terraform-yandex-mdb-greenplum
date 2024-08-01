output "id" {
  description = "ID of the created Greenplum cluster"
  value       = yandex_mdb_greenplum_cluster.greenplum_cluster.id
}

output "name" {
  description = "Name of the created Greenplum cluster"
  value       = yandex_mdb_greenplum_cluster.greenplum_cluster.name
}

output "master_hosts" {
  description = "Information about the master hosts of the Greenplum cluster"
  value       = yandex_mdb_greenplum_cluster.greenplum_cluster.master_hosts
}

output "segment_hosts" {
  description = "Information about the segment hosts of the Greenplum cluster"
  value       = yandex_mdb_greenplum_cluster.greenplum_cluster.segment_hosts
}
