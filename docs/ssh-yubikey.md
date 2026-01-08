# A Hitchhiker's Guide to YubiKey and SSH

So, you want to traverse the digital galaxy securely? Excellent choice. Using a YubiKey for SSH is like having a Vogon guard for your private data, but one that's actually on your side.

This guide assumes you have a YubiKey, a Mac, and a healthy dose of skepticism about password-only security.

## 1. Check Your Tools

Before we begin, you need to make sure you're using the right version of OpenSSH. The one that comes with macOS is, shall we say, a bit... provincial. It doesn't fully appreciate the beauty of FIDO2.

```bash
which ssh-keygen
# Expected output: /opt/homebrew/opt/openssh/bin/ssh-keygen
```

If you see `/usr/bin/ssh-keygen`, it means you're using the boring, native version. Don't panic. Just tell your Zsh shell to look in the right place by adding this to your `~/.zshrc`:

```bash
export PATH="/opt/homebrew/opt/openssh/bin:$PATH"
```

## 2. Generate the Key (and lock it down)

Now, let's create a key that lives on your YubiKey. This is a "resident" key, meaning the YubiKey itself holds a reference to it. We'll also require a PIN for every use, because we're paranoid like that.

```bash
ssh-keygen -t ed25519-sk -O resident -O verify-required -C "your_email@example.com"
```

## 3. Configure Your Ship's Computer (SSH)

Your SSH client needs to know about this new key. Edit your `~/.ssh/config` file. The `AddKeysToAgent no` part is crucial. It tells the native macOS agent to back off and let the YubiKey do its thing, especially when it comes to asking for your PIN.

```ssh
Host *
  IgnoreUnknown UseKeychain
  AddKeysToAgent no
  IdentityFile ~/.ssh/id_ed25519_sk
```

## 4. Present Your Credentials to the Galactic Authorities (GitHub)

Now, you need to tell GitHub (and any other service) about your new public key. This command copies it to your clipboard.

```bash
cat ~/.ssh/id_ed25519_sk.pub | pbcopy
```

Go to your GitHub settings, find the "SSH and GPG keys" section, and paste it in.

## 5. When Things Go Wrong (Troubleshooting)

Sometimes, the SSH agent gets a bit confused and refuses to cooperate (you might see an "agent refused operation" error). When this happens, just give it a good old-fashioned memory wipe.

```bash
ssh-add -D
```

And that's it! You're now ready to navigate the galaxy with the confidence that only a hardware-backed key can provide.