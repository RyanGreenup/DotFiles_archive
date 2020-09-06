#!/bin/bash
# * Preamble
    readonly script_name=$(basename "${0}")
             script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
    readonly script_dir=$(realpath "${script_dir}""/""${script_name}" | xargs dirname)
# * Check Arguments and write Permissions

if [[ "${1}" == "--help" || "${1}" == "-h" ]]; then
    echo -e "First argument should be a HTML File in the current directory"
    echo -e "Second argument is optional and should be the namespace HTML File"
    echo -e "\tDownloaded with Firefox Worked for me"
    echo -e "This script will take a HTML file and return a data directory that can be merged"
    echo -e "with dokuwiki such that relative path images will work"
    exit 0
elif [[ "${1}" == "" ]]; then
    echo -e "\n Please provide the HTML File as the first argument\n"
    "${script_dir}"/"${script_name}" -h
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
# pandoc creates a directory called media
  # beware the rel path on --extract-media!
    # Currently pandoc creates a media directory for all rel paths
    # if this changes this script will need to change
    # TODO I think a more robust solution would be to use sed
        # So give pandoc the abs path to the media directory
        # then use sed to fix the links inside the dokuwiki txt file
        # this way any changes in where media is stored by dokuwiki or pandoc
        # will not affect this script
  # html math should work fine in dokuwiki because
  # pandoc doesn't escape it.
pandoc "${INPUT}" -f html -t dokuwiki --extract-media="./" -o "${OUTPUT_NAME}"
# ** Create the Corresponding Page
# *** Change into the pages directory
mv "${OUTPUT_NAME}" "${DIR}/${PAGE_DIR}"



# Should the user continue?
echo -e "Would you like to sudo copy this file into /srv/http/dokuwiki? as root"
echo -e "This will alsow chown -R http:http /srv/http/dokuwiki \n"
echo -e "Press y to continue and any other key to exit"
read -d '' -s -n1 continueQ
if [ ! "${continueQ}" == "y" ]; then
echo -e "Exported Data Directory Available in:\n ${DIR}"
    exit 0
fi



# * Copy the data into Dokuwiki
# Change directories back to root.
cd "${DIR}"
# To copy the data into mediawiki
# Merge the data directory with the dokuwiki one
sudo chown http:http -R data
sudo cp -r data/ /srv/http/dokuwiki/
# Change ownership of the files
sudo chown -R http:http /srv/http/dokuwiki
echo -e "\nMake sure to run:\n"
echo -e "sudo chown -R http:http /srv/http/dokuwiki \n"


echo "Successfully imported HTML File into Dokuwiki"

exit 0
# DONE


nautilus "${INPUT}" && exit 0
exit 0
