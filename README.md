# Non-blocking workflow starter

Non-blocking workflow starter with built-in Github pending health status report

## How to use this Step

Add the following to your `bitrise.yml`
```
- git::https://github.com/hmrc/bitrise-step-non-blocking-workflow-starter.git@main:
   title: Non-blocking workflow starter
   inputs:
   - step_workflows: workflow1 workflow2
```
