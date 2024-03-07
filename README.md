```bash
podman build -t prover -f prover.dockerfile .
```

```bash
podman run -i --rm prover < program_input.json > proof.json
```

```bash
podman build -t verifier -f verifier.dockerfile .
```

```bash
podman run -i --rm verifier < proof.json
```
