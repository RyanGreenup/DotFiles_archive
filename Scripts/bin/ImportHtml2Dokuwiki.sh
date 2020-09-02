#!/bin/bash
# * Check Arguments and write Permissions

if [[ "${1}" == "--help" || "${1}" == "-h" ]]; then
    echo -e "First argument should be a HTML File"
    echo -e "Second argument is optional and should be the namespace HTML File"
    echo -e "\tDownloaded with Firefox Worked for me"
    echo -e "This script will take a HTML file and return a data directory that can be merged"
    echo -e "with dokuwiki such that relative path images will work"
    exit 0
elif [[ "${1}" == "" ]]; then
    echo "Please provide the HTML File as the first argument"
    exit 0
elif [[ ! -f "${1}" ]]; then
    echo "Cannot detect any file by that name in this directory"
    exit 0
else
    # Check for Write Permissions
    name="$(date)"; touch "${name}" && rm "${name}" && echo "Write Permissions detected"  || {  echo "Do not have write permissions, exiting";  exit 1; }

    # Make a working directory
    DIR="$(mktemp -d)"

    # Fix the name if it has whitespace or caps
    INPUT_NAME="$(echo "${1}" | tr '\ ' '_' | tr 'A-Z' 'a-z')"
    INPUT="${DIR}/${INPUT_NAME}"
    if [[ ! "${1}" == "${INPUT}" ]]; then
        cp "${1}" "${INPUT}"
    fi

    # Change into the working Directory
    cd "${DIR}"

    # Set the namespace var
    if [[ -z "${2}" ]]; then
        NSPC=""
    else
        NSPC="$(echo ${2} | tr '\ ' '_' | tr 'A-Z' 'a-z')"
    fi
fi


# Make Directories to match dokuwiki
# Mk Directories, in this case I'm using the chaos namespace
PAGE="data/pages/${NSPSC}/${INPUT_NAME}"
PAGE_DIR="data/pages/${NSPC}"
MEDIA_DIR="data/media/${NSPC}"
OUTPUT_NAME="$(echo "${INPUT_NAME}" | cut -f 1 -d '.').txt"


mkdir -p "${PAGE_DIR}"
mkdir -p "${MEDIA_DIR}"





# * Convert the Article to DokuWiki
# ** Extract the Media
# All media goes underneath =./data/media/namespace=,
# All text  goes underneath =./data/pages/namespace=
# in this case the namespace is chaos.
#
# Pandoc will extract media and change links
# relative to where the media is with the =--extract-media /path/to/media=
# for dokuwiki the media is considered relative in a seperate path so we
# need to change directories twice.
# *** Change Directories into the Media Directory
cd data/media/"${NSPC}"
# *** Call Pandoc to Extract Media
pandoc "${INPUT}" -f html --extract-media ./ >& /dev/null
# ** Create the Corresponding Page
# *** Change into the pages directory
cd "${DIR}/${PAGE_DIR}"
# *** Convert the Document
pandoc "${INPUT}" -f html -t dokuwiki --extract-media ./ -o "${OUTPUT_NAME}"
# *** Store the Document in the clipboard
DWTMP="$(mktemp)"
mv  "${OUTPUT_NAME}" "${DWTMP}"
# *** Delete Everything
# Delete all the extracter material that belongs in a different directory
# The file has to be saved in the directory because otherwise the links
# will not be altered so there's gotta be a paste and delete without
# fundamentally modifying pandoc
rm -rf *
# Put the clipboard back into the directory
mv "${DWTMP}" "${OUTPUT_NAME}"


# Change directories back to root.
cd "${DIR}"


# Should the user continue?
echo -e "Would you like to sudo copy this file into /srv/http/dokuwiki? as root"
echo -e "This will alsow chown -R http:http /srv/http/dokuwiki \n"
echo -e "Press y to continue and any other key to exit"
read -d '' -s -n1 continueQ
if [ ! "${continueQ}" == "y" ]; then
    exit 0
fi

echo "Exported Data Directory Available in ${DIR}"

# * Copy the data into Dokuwiki
# To copy the data into mediawiki
# Merge the data directory with the dokuwiki one
sudo cp -r data/ /srv/http/dokuwiki/
# Change ownership of the files
sudo chown -R http:http /srv/http/dokuwiki

echo "Successfully imported HTML File into Dokuwiki"

exit 0
# DONE


nautilus "${INPUT}" && exit 0
exit 0
