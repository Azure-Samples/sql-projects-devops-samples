# Continuous deployments across environments

SQL projects tooling provides different deployment options such that you can customize the way you deploy your database per environment. Let's explore these options through an example set of environments:

- development, which is automatically updated from the content of `main` branch on each push/merge. This is the environment baseline for developers and provides a very early feedback loop.
- staging, which is updated manually from the content of `main` branch on demand. This is the environment where the team can validate the changes and evaluate how the deployment is applied before they are promoted to production.
- production, which is updated manually from the content of `main` branch on demand. This environment may have additional checks and validations before the deployment is applied, as well as much stricter security measures in place that requires manual intervention to execute the deployment.

In our sample workflows, the 3 environments are represented by 3 [GitHub Actions secrets](https://docs.github.com/actions/security-for-github-actions/security-guides/using-secrets-in-github-actions) storing the individual connection strings:

- `DEV_CONNECTION_STRING`
- `STAGING_CONNECTION_STRING`
- `PROD_CONNECTION_STRING`

## Deploy on push to `main`

Our [CI checks](2-ContinuousIntegration.md) ensure that the SQL project is in a good state before it is merged into the `main` branch. Since we trust the CI checks, we can automatically deploy the SQL project to the development environment on each push to the `main` branch.

```yaml
on:
  push:
    branches:
      - main
    paths:
      - 'ContosoOutdoors/**'

...

      # deploy the sql project to dev
      - name: 'Deploy dacpac'
        run: sqlpackage /a:Publish /sf:'bin/Debug/ContosoOutdoors.dacpac' /tcs:"${{ secrets.DEV_CONNECTION_STRING }}"
        working-directory: ContosoOutdoors
```

It's really nothing special, just a `sqlpackage` command that publishes the `.dacpac` file to the development environment. Since this workflow is triggered on each push to the `main` branch, we filter the paths to only trigger the deployment when the SQL project is updated.

## Deploy Report for staging on push to main

Even though we are automatically deploying to our development environment immediately on each push to the `main` branch, we want to have a manual step to deploy to the staging environment. We can use an automated action to provide feedback on warnings on the deployment plan that would be executed against the staging environment.

```yaml
# generate a deployment report
      - name: 'Deploy dacpac'
        run: sqlpackage /a:deployreport /sf:'bin/Debug/ContosoOutdoors.dacpac' /tcs:"${{ secrets.STAGING_CONNECTION_STRING }};" /OutputPath:DeployReport.xml
        working-directory: ContosoOutdoors
      

       # save the deployment script as an artifact
      - name: 'Save deployment script'
        uses: actions/upload-artifact@v4
        with:
          name: deployment-report
          path: ContosoOutdoors/DeployReport.xml

      - name: Check for alerts
        run: check-for-alerts.sh
```

The `sqlpackage` command with the `deployreport` action is similar to the `publish` action, but instead of deploying the changes, it generates an XML report on the deployment plan, including highlighting any warnings or alerts that should be considered for the deployment. We save this report as an artifact and run a script to check for alerts. There's a [sample deployment report](Sample-Deployment-Report.xml) available in this repository.

```bash
#!/bin/bash

# Check if the input file is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <input-file>"
  exit 1
fi

# Search for the string "<Alert Name" in the input file
if grep -q '<Alert Name' "$1"; then
  echo "Alert Found"
  exit 1
else
  echo "No Alert Found"
  exit 0
fi
```

The script is a rudimentary prototype with a simple check for the presence of the string `<Alert Name` in the deployment report. If the string is found, the script exits with a non-zero status code, which will fail the workflow. This is a simple example, but you can extend it to check for specific alerts or warnings that are important for your deployment process.

## Manual deployment to staging and production

If we're satisfied with our deployment report output, we can use the manual workflows to deploy to the staging and production environments. These workflows are triggered manually from the GitHub Actions UI.

```yaml
on:
  workflow_dispatch:
```

For staging, we still use the `sqlpackage` command with `publish` to deploy the `.dacpac` file to the staging environment.

```yaml
      - name: 'Deploy dacpac'
        run: sqlpackage /a:Publish /sf:'bin/Debug/ContosoOutdoors.dacpac' /tcs:"${{ secrets.STAGING_CONNECTION_STRING }}"
        working-directory: ContosoOutdoors
```

For production, we use `sqlpackage` again, but instead of deploying the `.dacpac` file directly, we generate a deployment script and save it as an artifact.

```yaml
      - name: 'Deploy dacpac'
        run: sqlpackage /a:script /sf:'bin/Debug/ContosoOutdoors.dacpac' /tcs:"${{ secrets.PROD_CONNECTION_STRING }};" /OutputPath:deployment-script.sql
        working-directory: ContosoOutdoors

      - name: 'Save deployment script'
        uses: actions/upload-artifact@v4
        with:
          name: deployment-script
          path: ContosoOutdoors/deployment-script.sql
```

This deployment script can be used to apply the changes from a login with higher permissions or to be reviewed by a DBA before applying the changes to the production environment.
