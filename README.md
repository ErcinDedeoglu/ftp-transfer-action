# [FTP Transfer Action](https://github.com/ErcinDedeoglu/ftp-transfer-action) ✨

Automate your file transfers seamlessly with GitHub Actions. Our FTP Transfer Action simplifies the synchronization of files between your local and remote FTP servers, ensuring a smooth workflow within your CI/CD pipeline.

<div align="center"><img src="https://github.com/ErcinDedeoglu/ftp-transfer-action/raw/main/assets/logo.png" width="400"></div>

## Prerequisites 📋

Before using this action, make sure you have access to an FTP server and your FTP credentials are securely stored as GitHub Secrets.

## How to Use 🚀

Add this action to your GitHub workflow to start automating your file transfers. Here’s a basic setup guide:

1. Include this action in your workflow file after the checkout step.
2. Configure the action parameters such as source, destination, host, user, and password.
3. For security, use GitHub Secrets to handle sensitive information like FTP credentials.
4. Adjust additional settings like `forceSSL` and `options` as needed.

## Configuration Parameters 🔧

Configure the FTP Transfer Action by setting the following parameters in your workflow file:

- `host`: The hostname or IP address of your FTP server. (Required)
  - Example: `ftp.example.com`

- `user`: Your username for the FTP server. (Required)
  - Example: `ftp_user`

- `password`: The corresponding password for your FTP server user account. (Required)
  - Example: Use `${{ secrets.FTP_PASSWORD }}` to securely fetch your password from GitHub Secrets.

- `source`: The local directory path in your repository from which files will be transferred. (Optional)
  - Default: `.` (current working directory)
  - Example: `./local_directory/`

- `destination`: The target directory path on your FTP server where files will be transferred. (Optional)
  - Default: `.` (home directory of the FTP user)
  - Example: `/public_html/`

- `forceSSL`: A boolean to enforce SSL encryption for the FTP transfer. (Optional)
  - Default: `false`
  - Example: `true` to enforce SSL encryption.

- `options`: Additional mirror command options for the `lftp` command. (Optional)
  - Default: `''` (no additional options)
  - Example: `"--delete --verbose"` to enable verbose logging and delete extraneous files from the destination.

Remember to wrap your input parameters in quotes if they contain special characters or spaces.

Here's how you might include these parameters in your workflow file:

```yaml
- name: Transfer files via FTP
  uses: ercindedeoglu/ftp-transfer-action@v2
  with:
    host: ${{ secrets.FTP_HOST }}
    user: ${{ secrets.FTP_USER }}
    password: ${{ secrets.FTP_PASSWORD }}
    source: './local_directory/'
    destination: '/public_html/'
    forceSSL: true
    options: "--delete --verbose"
```

Ensure that sensitive information, especially the FTP password, is always referenced from GitHub Secrets to maintain security.

## Security Notice 🔒

When setting up the FTP Transfer Action, it is crucial to handle your FTP credentials with the utmost care to maintain the security of your server and its contents. Here's how to manage your sensitive data securely:

**Use GitHub Secrets**: Always store sensitive information such as your FTP server's host, username, and password within GitHub Secrets. This prevents your credentials from being exposed in your workflow files or logs.

For example, instead of directly inserting your credentials into your workflow file, you should add them to your repository's secrets and reference them as follows:

```yaml
with:
  host: ${{ secrets.FTP_HOST }}
  user: ${{ secrets.FTP_USER }}
  password: ${{ secrets.FTP_PASSWORD }}
```

**SSL Encryption**: It is recommended to set `forceSSL` to `true` to ensure that all data transferred between your repository and the FTP server is encrypted, reducing the risk of interception by unauthorized parties.

```yaml
with:
  # ... other parameters
  forceSSL: true
```

**Minimal Permissions**: Assign the FTP user account used in the action the minimal permissions required to perform the necessary tasks. Avoid using an account with administrative privileges unless absolutely necessary.

By following these security practices, you can help protect your FTP server and its data from unauthorized access and exposure.

## Sample Workflows 📝

To help you get started with the FTP Transfer Action, here are some sample workflows for common use cases:

### Basic File Transfer

This basic example transfers files from a local directory to a remote FTP server every time changes are pushed to the main branch.

```yaml
name: FTP Deploy on Push
on:
  push:
    branches:
      - main

jobs:
  ftp-deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - name: FTP Transfer Files
      uses: ercindedeoglu/ftp-transfer-action@v2
      with:
        host: ${{ secrets.FTP_HOST }}
        user: ${{ secrets.FTP_USER }}
        password: ${{ secrets.FTP_PASSWORD }}
        source: 'local_directory/'
        destination: 'remote_directory/'
        forceSSL: true
```

### Scheduled Backup to FTP

In this workflow, backup files from a specific directory are transferred to an FTP server every night at midnight.

```yaml
name: Scheduled FTP Backup
on:
  schedule:
    - cron: '0 0 * * *'  # Runs at midnight every day

jobs:
  backup:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - name: Backup to FTP
      uses: ercindedeoglu/ftp-transfer-action@v2
      with:
        host: ${{ secrets.FTP_HOST }}
        user: ${{ secrets.FTP_USER }}
        password: ${{ secrets.FTP_PASSWORD }}
        source: 'backup/'
        destination: 'backup_destination/'
        forceSSL: true
        options: '--reverse --delete --verbose'
```

### Deployment with Cleanup

This example deploys files to a remote server and cleans up files that are no longer present in the source directory.

```yaml
name: FTP Deploy with Cleanup
on:
  push:
    branches:
      - release

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - name: Deploy and Clean up
      uses: ercindedeoglu/ftp-transfer-action@v2
      with:
        host: ${{ secrets.FTP_HOST }}
        user: ${{ secrets.FTP_USER }}
        password: ${{ secrets.FTP_PASSWORD }}
        source: 'dist/'
        destination: 'public_html/'
        forceSSL: true
        options: '--mirror --delete'
```

These examples are meant to be templates to get you started. Customize the `source`, `destination`, and `options` parameters to match your project's structure and deployment needs. Always remember to use GitHub Secrets to store your FTP credentials securely.

## Contributing to This Project 🤝

We actively welcome your contributions to make the FTP Transfer Action even better and more efficient. Whether you're fixing a bug, adding a feature, or improving the documentation, your help is appreciated. Here's how you can contribute:

1. **Fork the Repository**: Start by forking the repository. This is your own copy of the project where you can make your changes.

2. **Clone Your Fork**: Clone your fork to your local machine to start making your changes.

3. **Create a New Branch**: Create a new branch in your forked repository for each significant change or addition. This keeps your modifications organized and separated from the main branch.

4. **Make Your Changes**: Implement your changes, additions, or fixes in your branch. Make sure to keep your changes focused and on topic. If you have multiple unrelated changes, create separate branches and pull requests for them.

5. **Test Your Changes**: Before submitting your changes, test them thoroughly to ensure they work as expected and do not introduce new issues.

6. **Commit Your Changes**: Commit your changes with a clear and detailed commit message, explaining what your changes do and why.

7. **Push to Your Fork**: Push your changes to your fork on GitHub.

8. **Submit a Pull Request**: Go to the original project repository and submit a pull request from your branch to the main branch. Provide a clear description of the problem you're solving or the feature you're adding.

9. **Code Review**: Once your pull request is submitted, maintainers will review your changes. Be open to feedback and be prepared to make some revisions if requested.

10. **Pull Request Merge**: If your changes are approved, they will be merged into the project's main branch by the maintainers.

**Code Standards**: Please adhere to the coding standards used throughout the project to make your contributions consistent with the existing codebase.

**Issue Reporting**: If you find a bug or have a suggestion for a new feature, please check the issue tracker to see if it has already been reported. If not, submit a new issue providing as much detail as possible to explain the bug or feature.

Thank you for considering contributing to this project! Your efforts help improve the tool for everyone.

## Support and Feedback 📬

If you found this project helpful, please consider giving it a star on GitHub. Your support helps encourage future development and maintenance of this and other open source projects.

Thank you for your support! 🫶
