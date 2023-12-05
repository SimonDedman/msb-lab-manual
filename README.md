<p align="center"> 
   Florida International University, Biscayne Bay Campus, Marine Science Building, labs manual
</p>


For **incoming, current, and outgoing** members of the MSB, to be collaboratively edited by its users, rather than the work of one individual. To make changes, do a pull request and your changes will be reviewed then pulled into the manual for everyone to see & benefit from.

This file/page is edited in README.md and rendered/published to <https://github.com/SimonDedman/msb-lab-manual> i.e. the GitHub *code project page*. Quarto (qmd) files within the project directory are rendered/published to the actual online manual, <https://simondedman.github.io/msb-lab-manual>

## How to fork this project

1. Have a [Github](https://github.com/) account.
2. [Setup Git on RStudio and Associate with GitHub](https://www.r-bloggers.com/2015/07/rstudio-and-github/).
3. Fork the project (e.g. this one) on the project's Github webpage (top right). This copies the external project to your own Github account.
4. In your GitHub forked project webpage, click the green `code` button, copy git address.
5. In your filesystem (/home, My Computer, etc., i.e. not online, look away from your browser), choose a parent folder to host the project folder and its files and folders. The result will be a folder called "msb-lab-manual" WITHIN the folder you choose, so I suggest either something FIU-specific (e.g. /FIU/Code) or somewhere which will host multiple of your own projects and forked projects in the future (e.g. /R). In that folder open a terminal AKA command prompt, and type `git clone [gitaddress]`. You will need to have [git installed](https://git-scm.com/downloads) (if you use linux it's already installed, well done you).
6. Go to the new subfolder and open the .Rproj file in RStudio (hopefully you can just doubleclick it).

## How to make changes
Go to the QMD file for a page you want to edit and make changes using [RMarkdown](https://rstudio.github.io/cheatsheets/rmarkdown.pdf) or [Quarto](https://quarto.org/docs/get-started/hello/rstudio.html) formatting, depending on the file. Quarto text formatting conventions seem to be the same as markdown, but it includes more features in the YAML headers and code chunks.

## How to do a pull request
5. Make changes in your local files in RStudio, e.g. open the relevant qmd file for a page you want to change, test your edits bywith the Render button, then type `devtools::document()` in the console to synchronise any documentation changes resulting from your edits (unlikely for qmd files but good practice generally), then click the "GIT" icon in the top bar of RStudio, "Commit...", select all the files on the left hand side so they're all ticked (staged to be committed; I ctrl+shift+click the bottom one while the top one's selected, then hit the space bar), type a commit message briefly explaining what these changes are, then Commit, close, then the Push button in the top right. The edits are now pushed from your local machine to your OWN Github forked project. And NOT to the remote/main/original project you forked from.
6. Go to original (other person's) package, pull requests, create, "compare across forks", select your fork as the right hand side. "Create pull request" button.
7. If it's not automatically named correctly, name it well. See [this](https://docs.github.com/en/issues/tracking-your-work-with-issues/linking-a-pull-request-to-an-issue).
8. [Pull request example](https://github.com/r-lib/usethis/pull/1898).

[More info](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request?tool=desktop).

## General info about site structure & editing

The Github R project file pertaining to the central *frame* on the first [page](https://simondedman.github.io/msb-lab-manual) (from "Welcome" to the bottom, not including the top and side panes) is `index.qmd`. The top and side bits are edited in `_quarto.yml` (chapters are autopopulated: 1 = index.qmd (this file), then alphabetically by qmd filenames in the root folder, pulling the name from the name of the header in each file). References are tagged thus: `[@wilson2017]`, corresponding to a bibtext entry added to `references.bib`. If creating a new site like this one, also edit `sitemap.xml` and possibly also `robots.txt`.

Adding more complex stuff than just text is possible and very much encouraged, e.g. the table on the lab members page. Look around for existing examples on this site and elsewhere you can copy from rather than trying to bash your head against the wall. Also check the [Github actions page](https://github.com/SimonDedman/msb-lab-manual/actions), though this might only be useful for the package owner...


## Acknowledgements

The structure for this manual was forked from Gavin Fay's FayLab manual following [these steps](https://github.com/thefaylab/lab-manual/wiki/Quick-steps-to-making-a-copy-of-the-lab-manual-&-publishing-it) (plus some wrangling to get it to work), which was itself developed as part of the Openscapes Champions program.

<a rel='license' href='http://creativecommons.org/licenses/by/4.0/'><img alt='Creative Commons License' style='border-width:0' src='https://i.creativecommons.org/l/by/4.0/88x31.png' /></a>&nbsp;&nbsp;This manual is licensed under a <a rel='license' href='http://creativecommons.org/licenses/by/4.0/'>Creative Commons Attribution 4.0 International License</a>.
