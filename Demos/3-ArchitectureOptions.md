# SQL projects architecture options

SQL projects are a powerful way to manage SQL code in a version-controlled environment. They provide a way to define the schema of a SQL database in a declarative way, and to manage the changes to that schema over time. The references between objects, whether within the same database or between databases on the same server, can be managed in different ways.

## dacpac references

Additional objects in the same database or in another database (3-part naming) can be referenced in the SQL project by adding a reference to the dacpac file that contains the objects. While simplest to setup, this method can lead to managing physical `.dacpac` files across build agents and developer workstations. It's most helpful when investigating if you have a discrete set of objects that changes infrequently, such that you can be actively building only a subset of the database objects in the SQL project with a reference to the rest of the objects in a pre-compiled `.dacpac`.

## Package references

SQL projects can reference NuGet packages that contain SQL objects. The NuGet package contains the same project build artifact (a `.dacpac` file), but is prepared to be distributed by package feeds. Similarly to dacpac references, package references can be used for same-database references and 3-part naming references.

Create a NuGet package from a SQL project with the following command:

```bash
dotnet pack
```

The system databases have already been published to NuGet.org. You can reference them in your SQL project by adding a package reference to the NuGet package. For example, to reference the `master` database, add the similar package reference to your SQL project file:

```xml
  <ItemGroup>
    <PackageReference Include="Microsoft.SqlServer.Dacpacs.Master" Version="160.0.0" />
  </ItemGroup>
</Project>
```

Creating and consuming package references are covered further in the [SQL projects documentation](https://learn.microsoft.com/sql/tools/sql-database-projects/concepts/package-references).
