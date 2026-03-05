# Task: Select and Run

Use AI_INDEX.md to determine the best configuration for the user's request.

## Step 1

Choose the most appropriate:

- profile
- optional personas
- optional skills

Return this block first:

```yaml
selected:
  profiles: []
  personas: []
  skills: []
reason:
  - explain briefly
```

## Step 2

Answer the user request using the selected configuration.

Respect:

- output.format
- output.checklist
- safety requirements
