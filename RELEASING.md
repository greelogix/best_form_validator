# Releasing best_form_validator

Releases are published to pub.dev by GitHub Actions after a matching version
tag is pushed. The publishing workflow uses OpenID Connect (OIDC), so the
repository must not contain a pub.dev token or other long-lived publishing
credential.

## One-time setup

1. Open <https://pub.dev/packages/best_form_validator/admin> using an uploader
   account.
2. Enable publishing from GitHub Actions.
3. Set the repository to `greelogix/best_form_validator`.
4. Set the tag pattern to `v{{version}}`.
5. Require the GitHub Actions environment named `pub.dev`.
6. In the GitHub repository, create an environment named `pub.dev` and add a
   required reviewer who is authorized to approve releases.
7. Protect `master` with a ruleset that requires the `Validate package` CI job
   to pass before pull requests can merge.

The environment name and tag pattern must match exactly between GitHub,
pub.dev, and `.github/workflows/publish.yml`.

## Prepare a release

1. Create a branch from `master`.
2. Update `version:` in `pubspec.yaml`.
3. Add the release notes to the top of `CHANGELOG.md`.
4. Update documentation and tests for any public behavior changes.
5. Run the local checks:

   ```sh
   dart format --output=none --set-exit-if-changed lib test example/lib example/test
   flutter analyze
   flutter test
   (cd example && flutter test)
   dart pub publish --dry-run
   ```

6. Commit every release file and open a pull request into `master`.
7. Wait for CI and review, then merge the pull request.

## Publish the release

From an up-to-date `master` checkout, replace `1.4.1` with the version in
`pubspec.yaml`:

```sh
git switch master
git pull --ff-only origin master
git tag -a v1.4.1 -m "Release 1.4.1"
git push origin v1.4.1
```

The tag starts the `Publish to pub.dev` workflow. It verifies that the tag and
package versions match, runs formatting, analysis, package tests, and example
tests, then pauses for approval on the `pub.dev` environment. After approval,
the Dart reusable workflow performs a publication dry run and publishes using
OIDC.

Never move or reuse a published version tag. If a published release needs a
fix, prepare a new patch version.

## Verify the release

1. Inspect the workflow at
   <https://github.com/greelogix/best_form_validator/actions>.
2. Confirm the version at
   <https://pub.dev/packages/best_form_validator/versions>.
3. Confirm that pub.dev generated API documentation successfully.
