## Setting up Radicale {#setting_up_radicale}

This procedure is adapted from [^1] with the difference that command
line arguments[^2] have been used and `multifilesystem` has been
specifically specified rather than being a default.

1.  **Install Radicale**
    1.  It\'s in the *Arch* repos
        [1](https://archlinux.org/packages/community/any/radicale/) and
        *pip [2](https://pypi.org/project/Radicale/)*
    2.  If a global config is unavailable, specify one with the `-C`
        option (an empty file is sufficient).
2.  **Create a default calendar** (and decide on a username [^3] and
    password) by adding one through the web GUI at
    <http://localhost:5232>, it will be necessary to run radicale like
    so: [^4]
	```bash
	sudo radicale -H 0.0.0.0:5232 \--debug
	```
3.  **Set the `file-save` location** so that the calendar data is in a
    well known (ideally secure) location, this can be done like so:

	```bash
	radicale -H 0.0.0.0:5232 \\
		--storage-type multifilesystem\\
		--storage-filesystem-folder /home/ryan/Documents/Calendar
	```
4.  **Set a user password**, by default there is no password, `htpasswd`
    can be used to create a file containing the hashed username and
    password like so (enter the username/password from before):

	```bash
	htpasswd -c \~/Documents/Calendar/user_details.passwd ryan
	```

Then run radicale using that username and password like so:

	``` bash
	radicale -H 0.0.0.0:5232 \
		--storage-type multifilesystem  \
		--storage-filesystem-folder /home/ryan/Documents/Calendar \
		--auth-type htpasswd \ 
		--auth-htpasswd-filename ~/Sync/Documents/Calendar/user_details.passwd

	```

5.  **Set up SSL**; This is not *necessary* if you are willing to VPN
    into the network.
    1.  Is this necessary?
        1.  Not if you trust **all** users on your network **and** you
            are willing to **VPN** in.
        2.  If you are on iOS this is required, a self-signed
            certificate is fine but **must** expire after 825 days [^5]
    2.  Create the Certificate To create the certificate use `openssl`
        and specify the config using the appropriate ip address ( note
        the apple specific restrictions
        `<ref name=":0" group="fn">`{=html}

In my case that was:

-   Not installing the ssl certificate on Apple
    -   Don't forget to also trust it as shown in the video
-   Not specifying the \*SAN\* by appending

	```
	-addext "subjectAltName=DNS:foo.co.uk
	```

	``` bash
	# Record the ip address (If a Domain Name is going to be used that could work)
	ip route get 1 # ifconfig is another option

	# Create the Key
	openssl genrsa -out myselfsigned.key 2048
	# Create the Certificate
	openssl req -new -x509 -sha256     \
		-key radicale.key          \
		-out radicale.cer          \
		-days 800                      \
		-subj /CN=Radicale Calendar    \
		-addext  "subjectAltName = IP:192.168.50.190" # No Port number

	mv radicale.key radicale.cer ~/Sync/Documents/Calendar/

	```

	This can also be done with a config file See also [Self-Host Calendar
	with Radicale and SSL for iOS/Using Open SSL with a
	config](Self-Host_Calendar_with_Radicale_and_SSL_for_iOS/Using_Open_SSL_with_a_config "wikilink").

	1.  1.  Import the Certificate on Mobile Devices
			1.  Android is TBD
			2.  On iOS this is demonstrated in the thumnailed videos and
				involves:
				1.  opening the `.cer` file [^6] so it is automatically
					added to the settings as a *profile*
				2.  Importing the *profile* from the settings menu
				3.  Toggling the certificate from *\"General* ▶ *About* ▶
					*Trusted Certificates*\"
		2.  Run Radicale by enabling ssl using those certificates:

	```
	radicale -H 0.0.0.0:5232 \\

	   --storage-type multifilesystem  \\
	   --storage-filesystem-folder /home/ryan/Documents/Calendar \\
	   --auth-type htpasswd\
	   --auth-htpasswd-filename ~/Sync/Documents/Calendar/user_details.passwd \\
	   --ssl \ \
	       --certificate ~/Sync/Documents/Calendar/radicale.cer \\
	       --key ~/Sync/Documents/Calendar/radicale.key\
	   
	```
	1.  Add Radicale with the `--debug` flag and test with iOS and
		*Korganizer*.
		1.  Note for *iOS* users Note that if SSL has not been configured to
			worrk correctly, calendar and contacts may sync but reminders
			may fail to sync, as of *iOS14.6* and Radicale 3.0.6 this does
			work.[^7]


[^1]: Radicale \"3.0\" Documentation. (2021, March 23). Retrieved from
    <https://radicale.org/3.0.html> (Retrieved 2021 July)

[^2]: See `radicale --help`

[^3]: In this case assume the username is `ryan`

[^4]: Sometimes Korgansier cannot add a calendar on localhost and so
    specify the ip address

[^5]: <https://support.apple.com/en-us/HT210176>

[^6]: Ocassionally the `.crt` extension is used, seemingly either is
    fine.

[^7]: i.e. a self-signed certificate that has an SAN, expires in 800
    days, is *SHA256* and is imported onto *iOS*.

