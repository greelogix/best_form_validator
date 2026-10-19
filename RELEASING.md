# Releasing best_form_validator

Versioning, changelog updates, GitHub releases, tags, and pub.dev publication
are automated. A release still requires merging the generated release pull
request so that publishing remains an intentional decision.

## How the automation works

1. Changes are merged into `master` using Conventional Commit messages.
2. Release Please creates or updates a release pull request.
3. The release pull request updates `pubspec.yaml` and `CHANGELOG.md` with the
   next unique version.
4. CI validates the release pull request.
5. Merging the release pull request creates the matching GitHub release and
   `v<version>` tag.
6. The tag starts `.github/workflows/publish.yml`, which validates the package
   and publishes it to pub.dev using OIDC.

Published pub.dev versions are immutable. Never move or reuse a release tag.
Release Please tracks the last published version in
`.release-please-manifest.json` and always prepares a new version.

## One-time GitHub token setup

Release Please needs a token that can create a pull request and whose generated
tag can start the publishing workflow. The default `GITHUB_TOKEN` cannot start
a second workflow from a tag that it creates.

1. Create a fine-grained personal access token for only
   `greelogix/best_form_validator`.
2. Grant repository permissions for **Contents: Read and write** and
   **Pull requests: Read and write**. Also grant **Issues: Read and write** so
   Release Please can manage release labels.
3. In GitHub, open **Settings > Secrets and variables > Actions**.
4. Create a repository secret named `RELEASE_PLEASE_TOKEN` containing the
   token.

Treat this token as a secret. Do not place it in the repository, workflow file,
logs, or pub.dev configuration.

## One-time pub.dev and environment setup

1. Open <https://pub.dev/packages/best_form_validator/admin> using an uploader
   account.
2. Enable publishing from GitHub Actions.
3. Set the repository to `greelogix/best_form_validator`.
4. Set the tag pattern to `v{{version}}`.
5. Require the GitHub Actions environment named `pub.dev`.
6. In the GitHub repository, create an environment named `pub.dev`. Add a
   required reviewer only if publication should pause for human approval.
7. Protect `master` with a ruleset that requires the `Validate package` CI job
   before pull requests can merge.

The environment name and tag pattern must match exactly between GitHub,
pub.dev, and `.github/workflows/publish.yml`.

## Commit messages and version selection

Release Please determines the next semantic version from commit messages:

- `fix: correct phone validation` creates a patch release such as `1.4.2`.
- `feat: add a new validator` creates a minor release such as `1.5.0`.
- `feat!: redesign the validator API` creates a major release such as `2.0.0`.
- `chore:`, `docs:`, `test:`, and `ci:` changes do not create a package release
  by themselves.

Use squash merging when a pull request contains noisy or inconsistent commit
messages, and give the squash commit a Conventional Commit title.

## Development workflow

1. Create a branch from `master`.
2. Implement and test the change.
3. Open a pull request into `master` with a Conventional Commit title.
4. Wait for `Validate package` to pass and merge the pull request.
5. Review the generated Release Please pull request.
6. Merge the release pull request when the collected changes should be
   published.

No manual version edit or Git tag command is needed.

## Verify a release

1. Inspect the workflows at
   <https://github.com/greelogix/best_form_validator/actions>.
2. Confirm the version at
   <https://pub.dev/packages/best_form_validator/versions>.
3. Confirm that pub.dev generated API documentation successfully.

If publication reports that a version already exists, do not retry with the
same tag. Confirm the release manifest matches the latest published version and
allow Release Please to generate the next version.
