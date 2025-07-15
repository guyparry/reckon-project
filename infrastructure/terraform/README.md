# 🏗️ Reckon Infrastructure as Code

This Terraform configuration creates a cost-optimized GCP infrastructure for the Reckon project, designed specifically for hobby projects with minimal traffic.

## 🎯 Cost Optimization Features

- **Scale to Zero**: Cloud Run services scale down to 0 instances when not in use
- **Minimal Database**: Uses `db-f1-micro` (smallest Cloud SQL instance)
- **Shared Resources**: Uses shared CPU and minimal memory allocations
- **No Load Balancer**: Uses Cloud Run URLs directly to save costs
- **Minimal Backups**: 3-7 day retention instead of 30+ days
- **No High Availability**: Disabled for cost savings

## 📊 Estimated Monthly Costs

### Staging Environment
- **Cloud Run**: $5-10/month (mostly free tier)
- **Cloud SQL**: $8-12/month
- **Secret Manager**: $2/month
- **VPC Connector**: $5-10/month
- **Total**: ~$20-35/month

### Production Environment
- **Cloud Run**: $10-20/month
- **Cloud SQL**: $8-12/month
- **Secret Manager**: $2/month
- **VPC Connector**: $5-10/month
- **Total**: ~$25-45/month

**With $300 GCP credits**: Should last 6-12 months for both environments!

## 🚀 Quick Start

### Prerequisites

1. **Install Terraform** (version >= 1.0)
2. **Install Google Cloud CLI**
3. **Create GCP Project** with billing enabled
4. **Enable required APIs** (done automatically by Terraform)

### Setup Steps

1. **Authenticate with GCP**:
   ```bash
   gcloud auth application-default login
   ```

2. **Update project IDs** in environment files:
   ```bash
   # Edit these files:
   environments/staging/terraform.tfvars
   environments/production/terraform.tfvars
   ```

3. **Deploy Staging Environment**:
   ```bash
   cd environments/staging
   terraform init
   terraform plan
   terraform apply
   ```

4. **Deploy Production Environment**:
   ```bash
   cd environments/production
   terraform init
   terraform plan
   terraform apply
   ```

## 📁 Project Structure

```
infrastructure/terraform/
├── main.tf                 # Main configuration
├── variables.tf            # Variable definitions
├── outputs.tf              # Output values
├── modules/                # Reusable modules
│   ├── vpc/               # VPC and networking
│   ├── database/          # Cloud SQL setup
│   ├── secrets/           # Secret Manager
│   ├── cloud_run/         # Cloud Run services
│   └── service_account/   # IAM and permissions
└── environments/          # Environment-specific configs
    ├── staging/
    └── production/
```

## 🔧 Configuration Options

### Database Settings
- **Instance Type**: `db-f1-micro` (smallest available)
- **Disk Size**: 10GB (staging) / 20GB (production)
- **Backup Retention**: 3 days (staging) / 7 days (production)
- **High Availability**: Disabled for cost savings

### Cloud Run Settings
- **CPU**: 1 shared CPU
- **Memory**: 256Mi (staging) / 512Mi (production)
- **Min Instances**: 0 (staging) / 1 (production)
- **Max Instances**: 2 (staging) / 5 (production)

### Networking
- **VPC**: Private network for security
- **VPC Connector**: Minimal instances (0-2)
- **No Load Balancer**: Direct Cloud Run URLs

## 🔐 Security Features

- **Private Database**: No public IP access
- **Secret Manager**: All secrets stored securely
- **VPC Isolation**: Services communicate privately
- **Service Accounts**: Minimal required permissions
- **SSL/TLS**: All connections encrypted

## 📝 Post-Deployment Steps

1. **Update Database Secrets**:
   ```bash
   # Get the database connection details from Terraform output
   terraform output database_connection_name
   
   # Update the database URL secret with real connection string
   gcloud secrets versions add reckon-{env}-database-url --data-file=-
   ```

2. **Update Application Secrets**:
   ```bash
   # Update JWT secret
   echo "your-super-secret-jwt-key" | gcloud secrets versions add reckon-{env}-jwt-secret --data-file=-
   
   # Update application secret key
   echo "your-app-secret-key" | gcloud secrets versions add reckon-{env}-secret-key --data-file=-
   ```

3. **Deploy Your Application**:
   ```bash
   # Build and push your containers
   gcloud builds submit --tag gcr.io/{project-id}/reckon-backend
   gcloud builds submit --tag gcr.io/{project-id}/reckon-frontend
   ```

## 🧹 Cleanup

To destroy the infrastructure:
```bash
cd environments/{environment}
terraform destroy
```

⚠️ **Warning**: This will delete all resources including databases!

## 💡 Cost Optimization Tips

1. **Monitor Usage**: Set up billing alerts
2. **Scale Down**: Services automatically scale to zero
3. **Use Free Tier**: First 12 months have generous free limits
4. **Optimize Images**: Use multi-stage Docker builds
5. **Cache Dependencies**: Reduce build times and costs

## 🆘 Troubleshooting

### Common Issues

1. **API Not Enabled**: Wait for API enablement to complete
2. **Permission Denied**: Ensure service account has required roles
3. **VPC Connector Issues**: Check subnet IP ranges don't conflict
4. **Database Connection**: Verify VPC connector is working

### Useful Commands

```bash
# Check API status
gcloud services list --enabled

# View service account permissions
gcloud projects get-iam-policy {project-id}

# Test VPC connectivity
gcloud compute instances create test-instance --zone=us-central1-a
```

## 📞 Support

For issues with this infrastructure setup:
1. Check the [GCP documentation](https://cloud.google.com/docs)
2. Review [Terraform Google provider docs](https://registry.terraform.io/providers/hashicorp/google/latest/docs)
3. Monitor costs in the [GCP Console](https://console.cloud.google.com/billing)

---

**Remember**: This setup is optimized for hobby projects with minimal traffic. For production applications with higher traffic, consider upgrading resources accordingly. 