# Non-blocking workflow starter

Non-blocking workflow starter with built-in Github pending health status report

## How to use this Step

Add the following to your `bitrise.yml`
```
- git::https://github.com/hmrc/bitrise-step-non-blocking-workflow-starter.git@main:
   title: Non-blocking workflow starter
   inputs:
   - step_workflows: workflow1 workflow2
   is_always_run: true
```

### Environment Variables

Set an environment variable called `GITHUB_TOKEN` in the secrets tab of your Bitrise workflow editor. The token needs to have `repo:status` permissions.
\
\
Also in secrets, set an environment variable called `BITRISE_BUILD_TRIGGER_TOKEN`. This is a standard Bitrise build token.
\
\
Some internal Bitrise environment variables are also used:
* `BITRISEIO_GIT_REPOSITORY_SLUG`
* `BITRISE_GIT_COMMIT`
* `BITRISE_BUILD_URL`
* `BITRISEIO_GIT_REPOSITORY_SLUG`
* `BITRISE_GIT_BRANCH`
* `BITRISE_TRIGGERED_WORKFLOW_ID`
