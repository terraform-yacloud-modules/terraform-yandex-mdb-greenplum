# Yandex Cloud Greenplum Terraform module

Terraform module which creates Yandex Cloud Greenplum resources.

## Examples

Examples codified under
the [`examples`](https://github.com/terraform-yacloud-modules/terraform-yandex-module-template/tree/main/examples) are intended
to give users references for how to use the module(s) as well as testing/validating changes to the source code of the
module. If contributing to the project, please be sure to make any appropriate updates to the relevant examples to allow
maintainers to test your changes and to keep the examples up to date for users. Thank you!

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
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
| <a name="input_access_web_sql"></a> [access\_web\_sql](#input\_access\_web\_sql) | Allow access for SQL queries in the management console | `bool` | n/a | yes |
| <a name="input_assign_public_ip"></a> [assign\_public\_ip](#input\_assign\_public\_ip) | Assign a public IP to the master hosts | `bool` | n/a | yes |
| <a name="input_cluster_description"></a> [cluster\_description](#input\_cluster\_description) | Description of the Greenplum cluster | `string` | `null` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the Greenplum cluster | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Deployment environment of the Greenplum cluster | `string` | n/a | yes |
| <a name="input_greenplum_config"></a> [greenplum\_config](#input\_greenplum\_config) | Greenplum cluster config | `map(string)` | n/a | yes |
| <a name="input_greenplum_version"></a> [greenplum\_version](#input\_greenplum\_version) | Version of the Greenplum cluster | `string` | n/a | yes |
| <a name="input_master_disk_size"></a> [master\_disk\_size](#input\_master\_disk\_size) | Disk size for master hosts | `number` | n/a | yes |
| <a name="input_master_disk_type"></a> [master\_disk\_type](#input\_master\_disk\_type) | Disk type for master hosts | `string` | n/a | yes |
| <a name="input_master_host_count"></a> [master\_host\_count](#input\_master\_host\_count) | Number of hosts in master subcluster | `number` | n/a | yes |
| <a name="input_master_resources_preset"></a> [master\_resources\_preset](#input\_master\_resources\_preset) | Resource preset for master hosts | `string` | n/a | yes |
| <a name="input_network_id"></a> [network\_id](#input\_network\_id) | Yandex Cloud network ID | `string` | n/a | yes |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | List of security group IDs | `list(string)` | `[]` | no |
| <a name="input_segment_disk_size"></a> [segment\_disk\_size](#input\_segment\_disk\_size) | Disk size for segment hosts | `number` | n/a | yes |
| <a name="input_segment_disk_type"></a> [segment\_disk\_type](#input\_segment\_disk\_type) | Disk type for segment hosts | `string` | n/a | yes |
| <a name="input_segment_host_count"></a> [segment\_host\_count](#input\_segment\_host\_count) | Number of hosts in segment subcluster | `number` | n/a | yes |
| <a name="input_segment_in_host"></a> [segment\_in\_host](#input\_segment\_in\_host) | Number of segments on segment host | `number` | n/a | yes |
| <a name="input_segment_resources_preset"></a> [segment\_resources\_preset](#input\_segment\_resources\_preset) | Resource preset for segment hosts | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The ID of the subnet, to which the host belongs. The subnet must be a part of the network to which the cluster belongs | `string` | n/a | yes |
| <a name="input_user_name"></a> [user\_name](#input\_user\_name) | Greenplum cluster admin user name | `string` | n/a | yes |
| <a name="input_user_password"></a> [user\_password](#input\_user\_password) | Greenplum cluster admin password | `string` | n/a | yes |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | Availability zone for the subnet | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | ID of the created Greenplum cluster |
| <a name="output_master_hosts"></a> [master\_hosts](#output\_master\_hosts) | Information about the master hosts of the Greenplum cluster |
| <a name="output_name"></a> [name](#output\_name) | Name of the created Greenplum cluster |
| <a name="output_segment_hosts"></a> [segment\_hosts](#output\_segment\_hosts) | Information about the segment hosts of the Greenplum cluster |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache-2.0 Licensed.
See [LICENSE](https://github.com/terraform-yacloud-modules/terraform-yandex-module-template/blob/main/LICENSE).
