# Hush

[hush-shell.github.io](https://hush-shell.github.io/) [github](https://github.com/hush-shell/hush)

```bash
curl -so hush.tar.gz --location \
  $(curl -s https://api.github.com/repos/hush-shell/hush/releases \
    | grep -oP 'https://github.com/hush-shell/hush/releases/download/[^}]*static-x86_64.tar.gz' \
    | head -n 1 \
  ) \
  && tar -x hush -f hush.tar.gz && /bin/rm hush.tar.gz \
  && chmod +x ./hush && mv ./hush ~/.local/bin/hush
```

Use `#!/usr/bin/env hush` as shebang

You can run scripts like
```
➜ ./hello-world.hsh
or
➜ hush hello-world.hsh
```
