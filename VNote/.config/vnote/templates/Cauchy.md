# Cauchy Integral Formula

This is from section 54 of the book, isn't it nice that it more or less just works hey?

$$
\begin{aligned}
f\left( a \right) &= \frac{1}{2 \pi i} &= \oint \frac{f\left( z \right)}{z- a} \mathrm{d}z
\end{aligned}
$$ 


In view of this equation then:

$$\begin{aligned}
\left| \int_C \frac{f\left( z \right)}{z- z_0} \mathrm{d}z - 2 \pi i f\left( z_0 \right)  \right|<2 \pi \varepsilon
\end{aligned}$$ 




Why won't that preview?

In order to convert between `org` and `md` it can be helpful to write some scripts, for example if I wanted to go to a `md` file from an org file I was working on I could just use pandoc, but it would be a nuisance to have to find the file and type the command, instead, using the following script:

```bash
n/bash

# Print Help
if [ "$1" == "-h" ]; then
    echo "Usage: `basename $0` <Format> <CSS>"
    style=~/Dropbox/profiles/Emacs/org-css/github-org.css
    exit 0
fi

# Make a working File from clipboard
filename=lkjdskjjalkjkj392jlkj
xclip -o -selection clipboard >> $filename
LocalFile=$filename.org

pandoc -s  -f org -t gfm $filename -o $filename

echo "
This was converted from `org` to `md` using `pandoc -t gfm` at time: 
$(date --utc +%FT%H-%M-%S)
" >> $filename

cat $filename | xclip -selection clipboard
rm $filename 

nv & disown
echo "Conversion from Org Successful, MD is in Clipboard"

exit 0
```
