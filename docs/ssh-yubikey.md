# Guía de Setup: YubiKey SSH (ed25519-sk)

Notas para configurar autenticación SSH con hardware key (FIDO2) en macOS.

## 1. Verificar Entorno (OpenSSH)
Es necesario usar `openssh` de Homebrew (el nativo de macOS no soporta bien FIDO).

```bash
which ssh-keygen
# Resultado esperado: /opt/homebrew/opt/openssh/bin/ssh-keygen
```

Si el resultado es `/usr/bin/ssh-keygen`, configurar el PATH en `~/.zshrc`:

```bash
export PATH="/opt/homebrew/opt/openssh/bin:$PATH"
```

## 2. Generar la Clave (Residente + PIN)
Este comando guarda el handle en la YubiKey (`-O resident`) y fuerza el uso del PIN (`-O verify-required`).

```bash
ssh-keygen -t ed25519-sk -O resident -O verify-required -C "ernestosperanza@gmail.com"
```

## 3. Configuración SSH
Editar el archivo `~/.ssh/config`.
**Nota:** `AddKeysToAgent no` es obligatorio para evitar conflictos con el agente nativo de macOS al pedir el PIN.

```ssh
Host *
  IgnoreUnknown UseKeychain
  AddKeysToAgent no
  IdentityFile ~/.ssh/id_ed25519_sk
  IdentityFile ~/.ssh/id_ed25519_sk_backup
```

## 4. Agregar Clave Pública a GitHub
Copiar la clave al portapapeles para pegarla en GitHub Settings:

```bash
cat ~/.ssh/id_ed25519_sk.pub | pbcopy
```

## 5. Troubleshooting
Si el agente SSH se tranca (error "agent refused operation"), limpiar el caché:

```bash
ssh-add -D
```
