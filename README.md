# SnipsGoogleTTS

Provides GoogleTTS speeach synthesis for use with Snips AI.

## Installation

Installation comprises 4 steps:
1. Install dependencies
2. Get SnipsGoogleTTS scripts
3. Prepare the environment for the google API
4. Tell Snips to use SnipsGoogleTTS.


### 1. Install dependencies

The scripts depend on some installed software:
* git for installation
* curl for sending the POST requests to the REST API
* base64 for decoding the audio file dent by Google (in the coreutils package):

```
sudo apt-get install git-core curl base64
```



### 2. Get SnipsGoogleTTS scripts

The scripts can be stored anywhere on the computer, running Snips (most
probably a Raspberry Pie). A good location is for example
`/opt/SnipsHelpers/SnipsGoogleTTS`.
To install, just change to the target directory and clone the
repository:
```
cd /opt
sudo mkdir SnipsHelpers
sudo chown YOUR.USER.NAME SnipsHelpers
git clone git@github.com:andreasdominik/SnipsGoogleTTS.git
```

### 3. Prepare the environment for the google API

Go through Google's tutorial [Quickstart: Using the command line](https://cloud.google.com/text-to-speech/docs/quickstart-protocol).

In summary a Google Cloud Platform Project is needed, the Cloud Text-to-Speech
API must be enabled and the JSON-file with the credentials must be downloaded.
The file can be stored anywhere on the local file system (the Credentials
sub-directory of SnipsGoogleTTS is a good place) and the environment variable
GOOGLE_APPLICATION_CREDENTIALS must point to the file.

For testing enter the command:
```
$ export GOOGLE_APPLICATION_CREDENTIALS=/path/to/JSON/file
```
To make it permanent add the command to the file `.bashrc` in the home
directory of the user that runs Snips on the Raspberry Pie.

As last step the Cloud SDK must be intsalled.
To check the installation run
```
$ gcloud auth application-default print-access-token
```
It should print an access token, which can be uses to access the Cloud
Text-to-Speech API.


### 4. Tell Snips to use SnipsGoogleTTS

Edit the section ```### ``` of the file ```/etc/snips.toml``` and
change teh two lines as shown:


## Caveat

Please be aware that the Google-Text-to-Speach runs on Google's servers
and no longer locally on your Raspberry Pi but instead is shared with
Google.

Do not install this scripts, if you want to keep everything locally!

eof.
