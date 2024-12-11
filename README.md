<!--
---
page_type: sample
languages:
- tsql
- sql
- csharp
- dotnetcli
products:
- azure-sql-database
- azure-sql-managed-instance
- azure-sqlserver-vm
- sql-server
name: SQL projects DevOps sample
urlFragment: sqlprojects-devops-samples
description: Sample CI/CD workflows for database development and deployment
---
-->

# SQL projects DevOps samples

This repository contains sample workflows for several scenarios related to SQL projects, including CI checks and deployments to multiple environments. Following this sample you'll be able to setup CI/CD workflows for database development and deployment, including:

- getting started from an existing database
- a CI check that validates all object references with `dotnet build`
- a CI check for SQL code quality with code analysis
- incorporating additional database objects in your build, such as system objects
- a deployment workflow that checks for deployment warnings
- a deployment workflow that updates a testing environment
- a deployment workflow that generates a script for review

The .NET Conf 2024 session [Next-gen SQL projects with Microsoft.Build.Sql](https://www.youtube.com/watch?v=uYT8UGZgC5w) covered the topics in this repository for some background on establishing a database development lifecycle.

[![dotnet conf recording](https://img.youtube.com/vi/uYT8UGZgC5w/0.jpg)](https://www.youtube.com/watch?v=uYT8UGZgC5w)

## Contents

- [.github](.github/): GitHub actions workflows
- [ContosoOutdoors](ContosoOutdoors/): SQL project folder
- [Demos](Demos/): walk-through of examples

### Demo walk-through

- [Get started](Demos/1-GetStarted.md)
- [CI checks](Demos/2-ContinuousIntegration.md)
- [Architecture options](Demos/3-ArchitectureOptions.md)
- [Deploy to multiple environments](Demos/4-ContinuousDeployments.md)

## Resources

- [.NET Conf 2024 slides](dotnetConf-2024-MicrosoftBuildSql.pdf)
- [SQL projects documentation](https://aka.ms/sqlprojects)
- [DacFx GitHub repository](https://github.com/microsoft/dacfx)
