# ftp-tranfer-action ✨

**Automate File Transfer via FTP using GitHub Actions**

 - This GitHub Action allows you to automate the process of transferring
   files via FTP. Simply specify the source and destination directories,
   and the Action will handle the rest.

## Usage 💯
To use this Action, you'll need to add it to your workflow file. Here's an example of how to do so:

```	
on: [push]

jobs:
  transfer_files:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - name: Transfer files via FTP
      uses: ercindedeoglu/ftp-transfer-action@v1
      with:
        source: '/path/to/local/source/directory'
        destination: '/path/to/remote/destination/directory'
        host: 'ftp.example.com'
        user: 'your-ftp-username'
        password: 'your-ftp-password'
        options: "--delete --asci"
```

Replace the placeholders (e.g. your-username, /path/to/local/source/directory, etc.) with the appropriate values.


## Input parameters 🔤

Input parameter | Description | Required | Default
--- | --- | --- | ---
host | The hostname of the FTP server | Yes | N/A
user | The username to use when connecting to the FTP server | Yes | N/A
password | The password to use when connecting to the FTP server | Yes | N/A
source | The local directory from which files will be transferred | No | .
destination | The remote directory to which files will be transferred | No | .
forceSSL | Force SSL encryption | No | false
options | Mirror command options | No | ''


## IMPORTANT 🛎️

**Don't forget to use GitHub Secrets to store your FTP credentials.**
This will help ensure that your password is kept secure and is not exposed in your workflow file.

To use GitHub Secrets, you'll need to store your FTP credentials as secrets in your repository settings. Then, in your workflow file, you can reference those secrets using the ${{ secrets.SECRET_NAME }} syntax.

For example, to use the username and password secrets in the example above, you would modify the with block like so:

```
with:
  source: '/path/to/local/source/directory'
  destination: '/path/to/remote/destination/directory'
  host: ftp.example.com
  user: ${{ secrets.FTP_USERNAME }}
  password: ${{ secrets.FTP_PASSWORD }}
```

Remember to replace `USERNAME` and `PASSWORD` with the actual names you gave to your secrets.

## Contributing ❤️
**We welcome contributions to this project!**

If you have an idea for a new feature or have found a bug that needs to be fixed, please feel free to open an issue or submit a pull request.

Pull requests should be made to the main branch, and all code should be written in accordance with the project's style guidelines.

Before submitting a pull request, please ensure that you have run the test suite and received a passing result. This helps ensure that your changes do not break existing functionality.

**Thank you for considering contributing to this project!**


## Supporting this project 🎉

If you found this project helpful, please consider giving it a star on GitHub. Your support helps encourage future development and maintenance of this and other open source projects.

**Thank you for your support! 🫶**
