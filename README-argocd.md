# ArgoCD PR Automation

This workflow automatically runs `argocd app diff` on every Pull Request and posts the results as a comment.

## Setup

### Required GitHub Secrets

You need to configure the following secrets in your GitHub repository:

1. **ARGOCD_SERVER** - The ArgoCD server URL (e.g., `argocd.example.com:443`)
2. **ARGOCD_USERNAME** - ArgoCD username for authentication
3. **ARGOCD_PASSWORD** - ArgoCD password for authentication  
4. **ARGOCD_APP_NAME** - The name of your ArgoCD application

### How to add secrets:

1. Go to your GitHub repository
2. Click on **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret**
4. Add each of the required secrets above

## Features

### Automatic PR Comments
- On every PR, the workflow runs `argocd app diff`
- Shows exactly what will change in the cluster
- If diff output is too large (>65K chars), uploads as artifact with download link

### Manual Commands
You can trigger ArgoCD commands manually by commenting on a PR:

- `/argocd-diff` - Run app diff
- `/argocd-sync` - Sync the application  
- `/argocd-status` - Get application status

## Example Output

The workflow will post a comment like this on your PR:

```
#### 👀 ArgoCD App Diff

```diff
~ spec:
~   replicas: 2 → 3
+ metadata:
+   annotations:
+     deployment.kubernetes.io/revision: "2"
```
```

## Alternative: Token-based Authentication

If you prefer using ArgoCD tokens instead of username/password:

1. Generate a token: `argocd account generate-token --account <account-name>`
2. Use `ARGOCD_AUTH_TOKEN` secret instead of username/password
3. Update the login command to: `argocd login ${{ secrets.ARGOCD_SERVER }} --auth-token ${{ secrets.ARGOCD_AUTH_TOKEN }}`

## Troubleshooting

- Make sure your ArgoCD server is accessible from GitHub Actions runners
- Verify that the application name matches exactly
- Check that the user has sufficient permissions to run diff/sync operations
