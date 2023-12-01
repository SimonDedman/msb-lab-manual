<p align="center"> 
   :sparkles: Florida International University, Biscayne Bay Campus, Marine Science Building, labs manual :sparkles: 
</p>


For **incoming, current, and outgoing** members of the MSB, to be collaboratively edited by its users, rather than the work of one individual. To make changes, do a pull request and your changes will be reviewed then pulled into the manual for everyone to see & benefit from.

## How to fork this project

1. Have a [Github](https://github.com/) account.
2. [Setup Git on RStudio and Associate with GitHub](https://www.r-bloggers.com/2015/07/rstudio-and-github/).
3. Fork the project (e.g. this one) on the project's Github webpage (top right). This copies the external project to your own Github account.
4. In your GitHub forked project webpage, click the green `code` button, copy git address.
5. In your filesystem (/home, My Computer, etc., i.e. not online, look away fropm your browser), choose a parent folder to host the project folder and its files and folders. The result will be a folder called "msb-lab-manual" WITHIN the folder you choose, so I suggest either something FIU-specific (e.g. /FIU/Code) or somewhere which will host multiple of your own projects and forked projects in the future (e.g. /R). In that folder open a terminal AKA command prompt, and type `git clone [gitaddress]`. You will need to have [git installed](https://git-scm.com/downloads) (if you use linux it's already installed, well done you).
6. Go to the new subfolder and open the .Rproj file in RStudio (hopefully you can just doubleclick it).

## How to do a pull request
5. Make changes in your local files in RStudio, e.g. open the relevant qmd file for a page you want to change, test your edits bywith the Render button, then type `devtools::document()` in the console to synchronise any documentation changes resulting from your edits (unlikely for qmd files but good practice generally), then click the "GIT" icon in the top bar of RStudio, "Commit...", select all the files on the left hand side so they're all ticked (staged to be committed; I ctrl+shift+click the bottom one while the top one's selected, then hit the space bar), type a commit message briefly explaining what these changes are,   `git commit push` to your own Github fork.
6. Go to original (other person's) package, pull requests, create, "compare across forks", select your fork as the right hand side. "Create pull request" button.
7. If it's not automatically named correctly, name it well. See https://docs.github.com/en/issues/tracking-your-work-with-issues/linking-a-pull-request-to-an-issue.
8. Example: https://github.com/r-lib/usethis/pull/1898

https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request?tool=desktop


**Acknowledgements**

The content for this book was developed as part of our group’s participation in the Openscapes Champions program.
We are extremely grateful to and acknowledge [Dr. Julia Stewart Lowndes](https://github.com/jules32)’ role in helping shape how our lab both works and how we articulate our identity. 🙏
Thanks also to [Ileana Fenwick](https://github.com/IleanaF) and [Stefanie Butland](https://github.com/stefaniebutland) for their work moving the lab-manual from bookdown to Quarto. 🙌

---

<a rel='license' href='http://creativecommons.org/licenses/by/4.0/'><img alt='Creative Commons License' style='border-width:0' src='https://i.creativecommons.org/l/by/4.0/88x31.png' /></a>&nbsp;&nbsp;The Faylab Lab Manual is licensed under a <a rel='license' href='http://creativecommons.org/licenses/by/4.0/'>Creative Commons Attribution 4.0 International License</a>.


