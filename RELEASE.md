# Release

Run maven releaser plugin:

```
mvn release:prepare -Dresume=false
```

This command will update the pom version, creates the tag and advance the pom version to the next dev version.

The Github Actions will build all the artifacts and create the Github release.
