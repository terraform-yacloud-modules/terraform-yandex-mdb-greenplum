output "id" {
  description = "ID of the created Greenplum cluster"
  value       = yandex_mdb_greenplum_cluster.greenplum_cluster.id
}

output "name" {
  description = "Name of the created Greenplum cluster"
  value       = yandex_mdb_greenplum_cluster.greenplum_cluster.name
}

output "master_hosts" {
  description = "A list of master hosts in the Greenplum cluster, including their FQDNs, IP addresses, and configuration details."
  value       = yandex_mdb_greenplum_cluster.greenplum_cluster.master_hosts
}

output "segment_hosts" {
  description = "A list of segment hosts in the Greenplum cluster, including their FQDNs, IP addresses, and configuration details."
  value       = yandex_mdb_greenplum_cluster.greenplum_cluster.segment_hosts
}
