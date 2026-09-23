# AMD Property Template

This root module deploys an Akamai Adaptive Media Delivery (AMD) property by calling the reusable module in `../templates-module-amd`.

## Workflow

1. Copy or edit an environment tfvars file.
2. Set the EdgeGrid section, contract/group IDs, property name, hostnames, origin, and activation contacts.
3. Run Terraform from this directory:

```text
terraform init
terraform plan -var-file=environments/abm-test.tfvars -out=.plan
terraform apply .plan
```

Keep `activate_to_staging` and `activate_to_production` false while building or reviewing a property. Set them only when an activation is intended.

## Edge hostname modes

- `SBD`: Secure By Default. With `etls = true`, Akamai provisions the `edgekey.net` hostname automatically. With `etls = false`, Terraform creates an `edgesuite.net` hostname.
- `EDGESUITE`: Creates a Standard TLS `edgesuite.net` edge hostname.
- `EDGEKEY`: Creates an Enhanced TLS `edgekey.net` edge hostname and requires `certificate_id`.
- `AKAMAIZED_HOSTNAME`: Creates an `akamaized.net` Shared Cert edge hostname. Supply only the label in `hostnames`; do not include the suffix.

`etls` controls the AMD default rule's secure-delivery setting. The edge-hostname network is selected by `edge_hostname_type` and, for SBD, by `etls`.

## Additional origins

Set `additional_origins` to a map when requests need to route to origins other than `default_origin`. Each entry requires `origin_name`, `forward_host_header`, `hostname_match`, and `path_match`. Either match list may be `null`; at least one should identify the requests for that origin.

```hcl
additional_origins = {
	api = {
		origin_name         = "api-origin.example.com"
		forward_host_header = "REQUEST_HOST_HEADER"
		hostname_match      = ["api.example.com"]
		path_match          = ["/api/*"]
	}
}
```

The rule tree creates an `Additional Origins` parent rule and one child origin rule per map entry. An empty map keeps all requests on `default_origin`.

## Debugging

Enhanced debug is enabled by default. Set `debug_key` to a 64-character hexadecimal value when a managed key is required; otherwise Terraform generates and stores a stable key in state.

## Activation state

The `activation_to_staging_exists` and `activation_to_production_exists` flags preserve existing activation resources during refreshes. They are state-management flags and should not normally be changed manually.
