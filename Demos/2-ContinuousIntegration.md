# CI checks and SQL projects

When we create SQL objects with SQL projects, we want to ensure a minimum bar of quality before the code is combined with other changes. This is where continuous integration (CI) checks come in.

- is it valid SQL?
- is it good/decent SQL?

## Build - syntax and object reference validation

By default, the SQL project will validate the syntax of the SQL code in the project and the references between objects. For example, a foreign key defined cannot reference a column that isn't part of the SQL project. This is a baseline feature of the Microsoft.Build.Sql project SDK.

## SQL code analysis

We can leverage SQL code analysis to provide build-time feedback on the contents of the objects in our SQL project. This is also a feature of the Microsoft.Build.Sql project SDK, but is controlled with a project property `RunSqlCodeAnalysis`.

```bash
dotnet build /p:RunSqlCodeAnalysis=true
```

The [default ruleset](https://learn.microsoft.com/sql/tools/sql-database-projects/concepts/sql-code-analysis/sql-code-analysis) includes 15 code analysis rules that check for common issues in SQL code. SQL code analysis rules are [extensible](https://learn.microsoft.com/sql/tools/sql-database-projects/concepts/code-analysis-extensibility) and can be customized to fit the needs of your project. Several large sets of rules have been created by the community.

Custom rules can be enabled by adding a package reference to the code analysis rule package and setting the `RunSqlCodeAnalysis` property to `true`.

```xml
  <ItemGroup>
    <PackageReference Include="ErikEJ.DacFX.TSQLSmellSCA" Version="1.1.1" />
  </ItemGroup>
</Project>
```

> [!TIP]
> A sample CI check pipeline that runs SQL code analysis is available in [.github/workflows/main-PR-codeanalysis.yml](../.github/workflows/main-PR-codeanalysis.yml).

## Ephemeral CI environments

Service containers (sometimes called sidecar containers) can be added to the CI pipeline to provide an ephemeral environment for running tests against the SQL database. This allows us to run a sample deployment of our objects as well.

```yaml
jobs:
  build-and-deploy:
    # Containers must run in Linux based operating systems
    runs-on: ubuntu-latest

    # service/sidecar container for sql
    services:
      mssql:
        image: mcr.microsoft.com/mssql/server:2022-latest
        env:
          ACCEPT_EULA: 1
          SA_PASSWORD: ${{ secrets.CONTAINER_SQL_PASSWORD }}
        ports:
          - 1433:1433
```

With a service container defined as above, the connection string `"Server=localhost;Database=ContosoOutdoors;User Id=sa;Password=${{ secrets.CONTAINER_SQL_PASSWORD }};TrustServerCertificate=True;"` can be used to connect to the SQL Server instance running in the service container. With that connection we can deploy our SQL project (`.dacpac`) to the SQL Server instance and run tests against it.

> [!TIP]
> A sample CI check pipeline that deploys a SQL project to a container is available in [.github/workflows/main-PR-deploy.yml](../.github/workflows/main-PR-publish.yml).
