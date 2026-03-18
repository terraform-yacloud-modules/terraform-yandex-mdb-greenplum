output "id" {
  description = "ID of the created Greenplum cluster"
  value       = yandex_mdb_greenplum_cluster.greenplum_cluster.id
}

output "cluster_id" {
  description = "ID of the Greenplum cluster (alias for id, for use in yandex_mdb_greenplum_* resources)"
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

output "resource_group_ids" {
  description = "Map of resource group names to their IDs (when resource_groups variable is used)"
  value       = { for k, r in yandex_mdb_greenplum_resource_group.resource_group : k => r.id }
}

output "user_ids" {
  description = "Map of user names to their IDs (when users variable is used)"
  value       = { for k, u in yandex_mdb_greenplum_user.user : k => u.id }
}
