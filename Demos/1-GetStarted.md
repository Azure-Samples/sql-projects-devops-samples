# Get started with SQL projects

There's a number of ways to get a SQL project started, and you can start from scratch or use the objects from an existing database. For an overview on SQL projects, check out the [SQL database projects](https://learn.microsoft.com/sql/tools/sql-database-projects/sql-database-projects) documentation.

Full tutorials available for Visual Studio, VS Code, and the command line:
- [Create a new SQL project](https://learn.microsoft.com/sql/tools/sql-database-projects/tutorials/create-deploy-sql-project)
- [Start from an existing database](https://learn.microsoft.com/sql/tools/sql-database-projects/tutorials/start-from-existing-database)

In the simplest form, you can create a new SQL project with the `dotnet new` command:

```bash
dotnet new install microsoft.build.sql.templates

dotnet new sqlproj
```

You can add more files to the project, such as tables, views, and stored procedures. If you have an existing database, you can generate the files from the database with the `sqlpackage /a:Extract` command.

```bash
dotnet tool install -g microsoft.sqlpackage

sqlpackage /Action:Extract /SourceConnectionString:"{your_connection_string}" /TargetFile:DatabaseObjects /p:ExtractTarget=SchemaObjectType
```

As long as the `.sql` files are in the project folder structure, they're included in the project build. You can run the build with the `dotnet build` command to create a `.dacpac` build artifact.

```bash
dotnet build
```
