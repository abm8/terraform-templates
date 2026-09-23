/**
 * # Onboarding: Akamai AMD (Adaptive Media Delivery) Property
 *
 * ## Authentication
 *
 * Please refer to [Terraform Overview](https://techdocs.akamai.com/terraform/docs/overview)
 * and [Terraform Alternative authentication](https://techdocs.akamai.com/terraform/docs/gs-authentication)
 * for details on authenticating to Akamai when using Terraform.
 *
 * ## Usage Instructions
 *
 * ### Step 1: Download the Template
 * ```bash
 * > git clone <git url>
 * > cd templates-amd/
 * ```
 *
 * ### Step 2: Update your environment's tfvars
 * Copy `environments/<env>/<env>.tfvars.dist` to `environments/<env>/<env>.tfvars`
 * and fill in the required values: edgerc_section, name, contract_id, group_id,
 * hostnames, default_origin, activation_contacts.
 *
 * ### Step 3: Run Terraform
 * Run the deployment script `../deploy.ps1` (if available for this repo), or run
 * terraform directly from within this directory, pointing at the right environment's
 * backend/tfvars.
 */

module "property" {
  source = "../../modules-contribution/delivery-media"

  contract_id   = var.contract_id
  group_id      = var.group_id
  product_id    = var.product_id
  name          = var.name
  version_notes = var.version_notes

  hostnames           = var.hostnames
  edge_hostname_type  = var.edge_hostname_type
  certificate_id      = var.certificate_id
  ip_behavior         = var.ip_behavior
  etls                = var.etls
  default_origin      = var.default_origin
  additional_origins  = var.additional_origins
  forward_host_header = var.forward_host_header
  http2_enabled       = var.http2_enabled
  min_tls_version     = var.min_tls_version
  verification_mode   = var.verification_mode

  segmented_media_optimization_behavior = var.segmented_media_optimization_behavior
  origin_authentication_method          = var.origin_authentication_method
  origin_country                        = var.origin_country
  client_country                        = var.client_country

  content_catalog_size            = var.content_catalog_size
  content_type                    = var.content_type
  content_popularity_distribution = var.content_popularity_distribution
  enable_dash                     = var.enable_dash
  enable_hds                      = var.enable_hds
  enable_hls                      = var.enable_hls
  enable_smooth                   = var.enable_smooth
  segment_duration_dash           = var.segment_duration_dash
  segment_duration_hds            = var.segment_duration_hds
  segment_duration_hls            = var.segment_duration_hls
  segment_duration_smooth         = var.segment_duration_smooth

  cache_key_query_params_behavior        = var.cache_key_query_params_behavior
  enable_dynamic_throughput_optimization = var.enable_dynamic_throughput_optimization
  enable_http3                           = var.enable_http3

  enable_segmented_content_protection = var.enable_segmented_content_protection
  dash_media_encryption               = var.dash_media_encryption
  hls_media_encryption                = var.hls_media_encryption

  enable_debug = var.enable_debug
  debug_key    = var.debug_key

  enable_cors_policy     = var.enable_cors_policy
  cors_allow_origin      = var.cors_allow_origin
  cors_allow_methods     = var.cors_allow_methods
  cors_allow_headers     = var.cors_allow_headers
  cors_expose_headers    = var.cors_expose_headers
  cors_allow_credentials = var.cors_allow_credentials
  cors_max_age           = var.cors_max_age

  activation_contacts             = var.activation_contacts
  activate_to_staging             = var.activate_to_staging
  activate_to_production          = var.activate_to_production
  activation_to_staging_exists    = var.activation_to_staging_exists
  activation_to_production_exists = var.activation_to_production_exists
  noncompliance_reason            = var.noncompliance_reason
  ticket_id                       = var.ticket_id
  other_noncompliance_reason      = var.other_noncompliance_reason
  peer_reviewed_by                = var.peer_reviewed_by
  customer_email                  = var.customer_email
  unit_tested                     = var.unit_tested
  activation_notes                = var.activation_notes

  cpcode_name = var.cpcode_name

  providers = {
    akamai = akamai
  }
}
