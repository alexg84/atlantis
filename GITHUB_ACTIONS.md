# GitHub Actions Atlantis-Style Workflows

This repository includes two GitHub Actions workflows that provide Atlantis-like functionality for Terraform automation in Pull Requests.

## Workflows

### 1. `atlantis.yml` - Full Atlantis Simulation
This workflow provides comprehensive Atlantis-like functionality:

**Triggers:**
- Pull Request creation/updates
- Comments on PRs containing "atlantis"
- Pushes to main branch

**Features:**
- Automatic Terraform validation and planning on PRs
- Comment-based commands: `atlantis plan`, `atlantis apply`, `atlantis help`
- Auto-apply on main branch merges
- Artifact uploads for debugging

### 2. `terraform-pr.yml` - Simplified PR Automation
A cleaner, more focused workflow for Terraform PR automation:

**Triggers:**
- Pull Request creation/updates
- Comments starting with `/terraform`

**Features:**
- Automatic format, validate, and plan checks
- Comment commands: `/terraform-plan`, `/terraform-apply`, `/terraform-fmt`
- Clean status reporting

## How to Use

### Automatic Checks
When you create or update a Pull Request, the workflows will automatically:
1. ✅ Check Terraform formatting
2. 🔍 Validate Terraform configuration
3. 📋 Generate a Terraform plan
4. 💬 Comment on the PR with results

### Manual Commands

#### Using `atlantis.yml` workflow:
Comment on your PR with:
- `atlantis plan` - Run terraform plan
- `atlantis apply` - Run terraform apply
- `atlantis help` - Show available commands

#### Using `terraform-pr.yml` workflow:
Comment on your PR with:
- `/terraform-plan` - Re-run terraform plan
- `/terraform-apply` - Apply the changes
- `/terraform-fmt` - Format the Terraform code

## Example PR Flow

1. **Create PR** → Automatic checks run
2. **Review plan** → Check the generated plan in PR comments
3. **Apply changes** → Comment `/terraform-apply` or `atlantis apply`
4. **Merge PR** → Changes are applied to main branch

## Setup Requirements

### Repository Permissions
Make sure your repository has the following permissions enabled:
- Actions: Read and write
- Contents: Read
- Issues: Write
- Pull requests: Write

### Branch Protection (Recommended)
Set up branch protection rules for `main`:
1. Require status checks to pass
2. Require branches to be up to date
3. Include the Terraform workflow checks

### Secrets (if needed)
Add any required secrets to your repository:
- `TERRAFORM_TOKEN` - If using Terraform Cloud
- Cloud provider credentials (AWS, Azure, GCP)

## Workflow Comparison

| Feature | atlantis.yml | terraform-pr.yml |
|---------|-------------|------------------|
| Auto-checks on PR | ✅ | ✅ |
| Comment commands | ✅ | ✅ |
| Auto-apply on merge | ✅ | ❌ |
| Artifact uploads | ✅ | ❌ |
| Simpler syntax | ❌ | ✅ |
| Full Atlantis simulation | ✅ | ❌ |

## Customization

### Terraform Version
Update the `TF_VERSION` in the workflow files:
```yaml
env:
  TF_VERSION: "1.5.0"  # Change this
```

### Working Directory
If your Terraform files are in a subdirectory:
```yaml
defaults:
  run:
    working-directory: ./terraform
```

### Additional Validation
Add custom validation steps:
```yaml
- name: Custom Validation
  run: |
    # Your custom checks
    terraform fmt -check -recursive
    tflint
    checkov -d .
```

## Troubleshooting

### Common Issues

1. **Permission Denied**
   - Check repository permissions for Actions
   - Ensure GITHUB_TOKEN has sufficient permissions

2. **Terraform Init Fails**
   - Add required provider credentials as secrets
   - Check if backend configuration is correct

3. **Commands Not Triggering**
   - Ensure comments are on Pull Requests, not issues
   - Check exact command syntax (case-sensitive)

### Debug Information
Both workflows upload artifacts that include:
- Terraform plan files
- Command outputs
- State files (if any)

Access these in the Actions tab → Workflow run → Artifacts.

## Security Considerations

- Commands can only be run on Pull Requests, not arbitrary issues
- Terraform state should use remote backends for production
- Consider requiring PR reviews before allowing `/terraform-apply`
- Use environment protection rules for production deployments

## Migration from Real Atlantis

If migrating from a real Atlantis setup:
1. Keep your `atlantis.yaml` configuration file
2. Update webhook URLs to point to GitHub Actions
3. Move any custom scripts to workflow steps
4. Update team permissions in repository settings
