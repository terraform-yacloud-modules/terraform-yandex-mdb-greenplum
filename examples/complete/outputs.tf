output "id" {
  description = "ID of the created Greenplum cluster"
  value       = module.greenplum_cluster.id
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
