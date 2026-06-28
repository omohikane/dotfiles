# Secrets

Read this when working with API keys, tokens, credentials, certificates, private keys, or files that may contain sensitive values.

## Goal

Prevent secrets from leaking into commits, logs, prompts, summaries, or external services.

## Treat as secret

Treat the following as secret unless proven otherwise:

- API keys, tokens, OAuth credentials
- SSH, GPG, TLS, or other private keys
- database passwords and connection strings with credentials
- `.env`, `.envrc`, `secrets.yaml`, credentials files, and files with `secret`, `token`, or `credential` in the name
- VPN tokens, MFA seeds, recovery codes, and backup codes

If unsure, treat the value as secret.

## Never do

- commit secret values
- print secret values to stdout, stderr, logs, reports, or summaries
- include secret values in prompts or conversation history
- send secret values to external services
- quote secret values when explaining findings

Refer to secret names, keys, file paths, or placeholders instead.

## Reading secret files

Avoid reading secret-containing files unless required for the task.

When reading is required:

- read the smallest relevant section
- do not echo the value
- do not repeat the value in later output
- report only the key name, file path, or whether a value exists

## Editing secret files

Before editing:

- check whether the file is ignored by git
- avoid showing existing secret values
- use placeholders in explanations

If the file is not ignored by git, stop and ask before editing.

Do not create new secret files in the repository unless the user explicitly asks and the file is ignored.

## Secret indicators

Common indicators include:

- names containing `KEY`, `TOKEN`, `SECRET`, `PASSWORD`, or `PASS`
- `Authorization`, `Bearer`, or `Basic`
- private key markers such as `-----BEGIN`
- files named like `.env`, `credentials`, `secrets`, or `auth`

These indicators are not complete. Absence from this list does not mean a value is safe.

## If exposure may have happened

Stop immediately and report:

- what kind of secret may have been exposed
- where it may have appeared
- whether it may have entered git history, logs, prompts, or external services
- the safest next step

Recommend rotation when exposure is plausible.
Do not rotate, delete, rewrite history, or contact external services without user approval.
