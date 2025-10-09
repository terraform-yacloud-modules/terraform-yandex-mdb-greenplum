# Yandex Cloud Greenplum Terraform module

Terraform module which creates Yandex Cloud Greenplum resources.

## Examples

Examples codified under
the [`examples`](https://github.com/terraform-yacloud-modules/terraform-yandex-module-template/tree/main/examples) are intended
to give users references for how to use the module(s) as well as testing/validating changes to the source code of the
module. If contributing to the project, please be sure to make any appropriate updates to the relevant examples to allow
maintainers to test your changes and to keep the examples up to date for users. Thank you!

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | >= 0.47.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | >= 0.47.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [yandex_mdb_greenplum_cluster.greenplum_cluster](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_greenplum_cluster) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_web_sql"></a> [access\_web\_sql](#input\_access\_web\_sql) | Whether to enable web-based SQL query interface in the Yandex Cloud management console. | `bool` | n/a | yes |
| <a name="input_assign_public_ip"></a> [assign\_public\_ip](#input\_assign\_public\_ip) | Whether to assign public IP addresses to the master hosts. Enables external access to the cluster. | `bool` | n/a | yes |
| <a name="input_cluster_description"></a> [cluster\_description](#input\_cluster\_description) | An optional description of the Greenplum cluster. Helps document the purpose and usage of the cluster. | `string` | `null` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the Greenplum cluster | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The deployment environment of the Greenplum cluster. PRODUCTION for production workloads with higher availability, PRESTABLE for testing and development. | `string` | n/a | yes |
| <a name="input_greenplum_config"></a> [greenplum\_config](#input\_greenplum\_config) | A map of Greenplum configuration parameters. Allows fine-tuning of cluster behavior and performance. | `map(string)` | n/a | yes |
| <a name="input_greenplum_version"></a> [greenplum\_version](#input\_greenplum\_version) | The version of Greenplum to deploy. Currently only version 6.25 is supported. | `string` | n/a | yes |
| <a name="input_master_disk_size"></a> [master\_disk\_size](#input\_master\_disk\_size) | The disk size in GB for the master hosts. Stores metadata, logs, and temporary data. | `number` | n/a | yes |
| <a name="input_master_disk_type"></a> [master\_disk\_type](#input\_master\_disk\_type) | The disk type for the master hosts. Options include network-ssd, network-hdd, local-ssd, etc. | `string` | n/a | yes |
| <a name="input_master_host_count"></a> [master\_host\_count](#input\_master\_host\_count) | The number of hosts in the master subcluster. Must be 1 (single master) or 2 (master with standby) for high availability. | `number` | n/a | yes |
| <a name="input_master_resources_preset"></a> [master\_resources\_preset](#input\_master\_resources\_preset) | The resource preset (CPU and memory configuration) for the master hosts. Determines the computational power of the master nodes. | `string` | n/a | yes |
| <a name="input_network_id"></a> [network\_id](#input\_network\_id) | The ID of the VPC network where the Greenplum cluster will be deployed. All cluster hosts will be placed within this network. | `string` | n/a | yes |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | A list of security group IDs to assign to the Greenplum cluster hosts. Controls network access to the cluster nodes. | `list(string)` | `[]` | no |
| <a name="input_segment_disk_size"></a> [segment\_disk\_size](#input\_segment\_disk\_size) | The disk size in GB for the segment hosts. Stores the actual data and affects query performance. | `number` | n/a | yes |
| <a name="input_segment_disk_type"></a> [segment\_disk\_type](#input\_segment\_disk\_type) | The disk type for the segment hosts. Options include network-ssd, network-hdd, local-ssd, etc. | `string` | n/a | yes |
| <a name="input_segment_host_count"></a> [segment\_host\_count](#input\_segment\_host\_count) | The number of hosts in the segment subcluster. These hosts store the actual data and handle query processing. | `number` | n/a | yes |
| <a name="input_segment_in_host"></a> [segment\_in\_host](#input\_segment\_in\_host) | The number of Greenplum segments to run on each segment host. Affects parallelism and resource utilization. | `number` | n/a | yes |
| <a name="input_segment_resources_preset"></a> [segment\_resources\_preset](#input\_segment\_resources\_preset) | The resource preset (CPU and memory configuration) for the segment hosts. Determines the computational power of the data processing nodes. | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The ID of the subnet where the Greenplum cluster hosts will be deployed. The subnet must be part of the specified network. | `string` | n/a | yes |
| <a name="input_user_name"></a> [user\_name](#input\_user\_name) | The username for the Greenplum cluster administrator account. Used for database access and management. | `string` | n/a | yes |
| <a name="input_user_password"></a> [user\_password](#input\_user\_password) | The password for the Greenplum cluster administrator account. Should be strong and stored securely. | `string` | n/a | yes |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | Availability zone for the subnet | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | ID of the created Greenplum cluster |
| <a name="output_master_hosts"></a> [master\_hosts](#output\_master\_hosts) | A list of master hosts in the Greenplum cluster, including their FQDNs, IP addresses, and configuration details. |
| <a name="output_name"></a> [name](#output\_name) | Name of the created Greenplum cluster |
| <a name="output_segment_hosts"></a> [segment\_hosts](#output\_segment\_hosts) | A list of segment hosts in the Greenplum cluster, including their FQDNs, IP addresses, and configuration details. |
<!-- END_TF_DOCS -->

## License

Apache-2.0 Licensed.
See [LICENSE](https://github.com/terraform-yacloud-modules/terraform-yandex-module-template/blob/main/LICENSE).
