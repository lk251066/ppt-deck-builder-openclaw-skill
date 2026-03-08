# Provider Adapters

## Goal

Keep the PPT workflow stable while letting the image backend change.
Story design, page briefs, prompt rules, QA, and PPTX packaging should not depend on one image API.

## Built-In Provider Names

- `runninghub_g31`
- `command`

## Recommended Strategy

- Keep `runninghub_g31` as the ready-to-run default.
- Use `command` when OpenClaw or another agent should own the image backend.
- Put backend-specific changes in one adapter command instead of editing the story and layout workflow.

## Plan File Pattern

```json
{
  "image_provider": "command",
  "provider_options": {
    "command": "python3 {baseDir}/scripts/provider_mock_png.py"
  }
}
```

The generator expands `{baseDir}` before invoking the command.

## Command Provider Contract

The command provider is called like this:

```bash
python3 your_adapter.py --request-file /tmp/request.json
```

The request file contains fields such as:

- `slide_number`
- `slide`
- `prompt`
- `resolution`
- `aspectRatio`
- `provider_options`

The command must print one JSON object to stdout.

Success response can contain any one of these image outputs:

- `image_url`
- `image_path`
- `image_base64`
- `image_data_uri`

Recommended success shape:

```json
{
  "status": "SUCCESS",
  "provider": "your_provider_name",
  "model": "your_model_name",
  "image_url": "https://example.com/slide.png"
}
```

Recommended failure shape:

```json
{
  "status": "FAILED",
  "provider": "your_provider_name",
  "reason": "what went wrong"
}
```

## RunningHub Notes

For `runninghub_g31`, supported provider options include:

- `model`
- `base_url`
- `submit_path`
- `query_path`
- `api_key_env`
- `request_overrides`

This keeps the default adapter usable even if the exact RunningHub model changes later.

## OpenClaw Guidance

When used from OpenClaw:

- prefer `{baseDir}` in skill instructions
- let OpenClaw change only the adapter command or provider options
- avoid rewriting the main workflow unless the output contract changes

## Useful Local Files

- `scripts/provider_command_template.py`
- `scripts/provider_mock_png.py`
