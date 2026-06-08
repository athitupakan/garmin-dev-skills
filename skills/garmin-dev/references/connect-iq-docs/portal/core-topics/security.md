---
source: https://developer.garmin.com/connect-iq/core-topics/security/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Core_Topics/Security.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Security

At Garmin we are focused on the security of our devices and services. The security model in Connect IQ is designed to give the developer and the user the tools to know that their device and their information is safe with Garmin.

Connect IQ has three levels of trust for apps:

- **Trusted** - Content that has been approved by the app store. These apps have passed the Garmin review process and can be downloaded from the Connect IQ store.
- **Developer** - Content that has been written by an individual developer, but has not been released in the Connect IQ store. This content can be used for testing, but is not an officially released app.
- **Untrusted** - Content that should not be run on device.

These levels of trust are enforced using digital signatures. Key management has been worked into the app store, the device, and the developer SDK. The goal is to make sure that apps loaded from developers only come from two locations - the app store or a trusted developer.

## Developer Keys

The Connect IQ compiler requires a developer key be provided to for signing when compiling and packaging apps. The required key must be a RSA 4096 bit private key.

**Note**: It's important you keep track of the key you use to sign app packages. You will need to use the same key to sign updates to an existing app on the store. If you lose your original signing key you will not be able to update your app.

## Generating a Key Using Visual Studio Code

If you have a developer key you can set the path to it by selecting *File > Preferences > Settings > Monkey C* and setting the *Monkey C: Developer Key Path* to your developer key. If you do not have a developer key, you can create one using the *Monkey C: Generate Developer Key* command in the command palette, or the Monkey C extension will create one when you verify the installation using the *Monkey C: Verify Installation* command.

## Generating a Key Using OpenSSL

If you're working from the command line you can generate a RSA key using OpenSSL. The following command will generate a valid signing key.

```
> openssl genrsa -out developer_key.pem 4096
> openssl pkcs8 -topk8 -inform PEM -outform DER -in developer_key.pem -out developer_key.der -nocrypt
```

This developer key, `developer_key.der`, is passed to the compiler using the `-y` command line option.

## Running on Device

Apps must be signed to run on a Garmin device, and unsigned apps will be deleted by the device. The Monkey C tool will automatically sign your app based on your key. Your apps will run at the Developer privilege level. Apps signed by the app store run at the Trusted privilege level. The content of their object store will be encrypted and unreadable from the Connect IQ developer tools.

The app store requires IQ files to be digitally signed. Your upload will be rejected If the developer key has changed since your last upload.
