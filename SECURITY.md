# Security

Scratch Kitchen handles household data: kitchen photos, inventory, meal times, household members' names, and share offers. Treat that data as private by default.

## Reporting

Report a security issue privately, not as a public issue, to the maintainer. Do not include kitchen photos, household member details, addresses, or share recipient details in a public report.

## Rules

- No credentials, API keys, tokens, or payment details in the repo, in issues, or in pull requests.
- No household addresses, phone numbers, or recipient details in code, tests, or fixtures. Use named test fixtures (e.g. "Person A", "Neighbour B"), never real people.
- Kitchen photos in tests must be fixtures, not real household photos.
- No cloud photo upload without explicit approval. On-device recognition first.
- Share offers must never include a recipient's private details beyond what the cook approved for that specific offer.

## Food safety, separately

This file is about software security, not food safety. Still-good judgements in Scratch Kitchen are the cook's judgement, not a food-safety guarantee, and no code in this repo certifies a food as safe.
