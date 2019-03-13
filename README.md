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
* base64 for decoding the audio file retrieved from Google (in the coreutils package):

```
sudo apt-get install git-core curl coreutils
```



### 2. Get SnipsGoogleTTS scripts

The scripts can be stored anywhere on the computer running Snips (most
probably a Raspberry Pie). A good location is for example
`/opt/SnipsHelpers/SnipsGoogleTTS`.
To install, just change to the target directory and clone the
repository:
```
cd /opt
sudo mkdir SnipsHelpers
sudo chown <YOUR.USER.NAME> SnipsHelpers
git clone git@github.com:andreasdominik/SnipsGoogleTTS.git
```

Verify that the two scripts `say` and `saySnips` are exectuable
(permissons `-rwxr-xr-x`) and all files and directories are readable
(three `r`s) and the directory Cache must be writable for everybody
(three `w`s).
`ls -l` should read somehow like:
```
drwxrwxrwx 4 andreas andreas 4096 Mär 13 10:03 Cache
drwxrwxrwx 2 andreas andreas 4096 Mär 13 10:03 Credentials
-rw-r--r-- 1 andreas andreas 7653 Mär 13 10:03 LICENSE
-rw-r--r-- 1 andreas andreas 2988 Mär 13 10:03 README.md
-rwxr-xr-x 1 andreas andreas  762 Mär 13 10:03 say
-rwxr-xr-x 1 andreas andreas  947 Mär 13 10:03 saySnips
drwxr-xr-x 2 andreas andreas 4096 Mär 13 10:03 src
```

If necessary change the permissions as:
```
chmod 755 say saySnips
cdmod -R a+r *
chmod -R 777 Cache
```

If you like, you can add a symbolic link to the say-executable from a directory in the
path, such as `/usr/local/bin`:
```
cd \usr\local\bin
sudo ln -s /opt/SnipsHelpers/SnipsGoogleTTS/say
```

You can test the intallation by calling say, as:
```
say en Hello I am snips. How are you?
```

All generated audio files will be added to the cache, so the `say`-command
can be used to add sentences to the cache.


### 3. Prepare the environment for the google API

#### Google-side setup:
Go through Google's tutorial [Quickstart: Using the command line](https://cloud.google.com/text-to-speech/docs/quickstart-protocol).

In summary ...
* a Google Cloud Platform Project is needed,
* the Cloud Text-to-Speech API must be enabled and
* the JSON-file with the credentials must be downloaded.

#### Local setup:
Save the json file with the credentials in the `Credentials` sub-directory
of SnipsGoogleTT and rename it to `google-credentials.json`.

As last step the Cloud SDK must be installed.
To check the installation run
```
$ gcloud auth application-default print-access-token
```
It should print an access token, which can be uses to access the Cloud
Text-to-Speech API.


### 4. Tell Snips to use SnipsGoogleTTS

Edit the section ```[snips-tts]``` of the file ```/etc/snips.toml``` and
change the two lines defining the custom tts settings as shown:

```
[snips-tts]
## Choose one tts provider (defaults to picotts)
# provider = "picotts"
# provider = "makerstts"
provider = "customtts"
## customtts specific configuration (here configured to use picotts using the en-US language)
## available placeholder variables : %%OUTPUT_FILE%%, %%LANG%%, %%TEXT%%
customtts = { command = ["/opt/Snips/GoogleTTS4Snips/saySnips", "%%OUTPUT_FILE%%", "%%LANG%    %", "%%TEXT%%"] }
```



## Caveat

Please be aware that the Google-Text-to-Speach runs on Google's servers
and no longer locally on your Raspberry Pi but instead is shared with
Google.

Do not install this scripts, if you want to keep everything local!

eof.
