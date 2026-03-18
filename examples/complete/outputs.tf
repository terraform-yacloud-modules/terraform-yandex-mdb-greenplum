output "id" {
  description = "ID of the created Greenplum cluster"
  value       = module.greenplum_cluster.id
}

output "cluster_id" {
  description = "ID of the Greenplum cluster"
  value       = module.greenplum_cluster.cluster_id
}

output "name" {
  description = "Name of the created Greenplum cluster"
  value       = module.greenplum_cluster.name
}

output "master_hosts" {
  description = "Information about the master hosts of the Greenplum cluster"
  value       = module.greenplum_cluster.master_hosts
}

output "segment_hosts" {
  description = "Information about the segment hosts of the Greenplum cluster"
  value       = module.greenplum_cluster.segment_hosts
}

output "resource_group_ids" {
  description = "Map of resource group names to IDs (if resource_groups are created)"
  value       = module.greenplum_cluster.resource_group_ids
}

output "user_ids" {
  description = "Map of user names to IDs (if additional users are created)"
  value       = module.greenplum_cluster.user_ids
}
